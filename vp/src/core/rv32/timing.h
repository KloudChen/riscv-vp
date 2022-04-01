#ifndef RISCV_VP_TIMING_H
#define RISCV_VP_TIMING_H

#include <stdint.h>

#include <vector>
#include <list>
#include <deque>


/*
 * Timing model for the HiFive1 pipeline.
 * This model only tracks timing related information (for example it is not necessary to keep track of different pipeline stages)
 * which essentially are:
 *
 * 1. registers that store results of operations that do not complete within a single cycle (i.e. essentially result dependencies between different instructions which may cause a pipeline stall).
 *    Operations that do not complete within a single execution cycle are: mult, div, load, store and csr access.
 *    Accessing such a register will stall the pipeline model, thus essentially advance the cycle counter to complete the pending operation.
 * 2. mult and div operations, since the HiFive1 has only a single multiplication and division unit.
 * 3. load and store addresses, since a load whose address overlaps with a still pending store requires longer time to finish on a HiFive1.
 */
struct HiFive1PipelineTiming {

    struct Range {
        unsigned start;
        unsigned end;

        bool contains(unsigned addr) const {
            assert (end >= start);
            return addr >= start && addr < end;
        }

        bool overlaps(const Range &other) const {
            if (other.start < start) {
                return other.end > start;
            } else {
                return end > other.start;
            }
        }

        unsigned size() const {
            return end-start;
        }
    };

    struct StoreReservation {
        Range range;
        int latency;

        bool contains(unsigned addr) const {
            return range.contains(addr);
        }

        bool overlaps(const Range &other) const {
            return range.overlaps(other);
        }

        bool advance(int num_cycles) {
            assert (latency > 0);
            latency -= num_cycles;
            if (latency <= 0) {
                return false;
            }
            return true;
        }
    };

    struct OperationReservation {
        bool acquired = false;
        int latency = 0;

        void acquire(int num_cycles) {
            assert (num_cycles > 0);
            assert (!acquired);
            acquired = true;
            latency = num_cycles;
        }

        void release() {
            assert (latency <= 0);
            assert (acquired);
            acquired = false;
        }

        bool advance(int num_cycles) {
            if (!acquired)
                return true;
            assert (latency > 0);
            latency -= num_cycles;
            if (latency <= 0) {
                release();
                return false;
            }
            return true;
        }
    };

    struct RegisterLatency {
        unsigned reg_idx;
        int latency;

        bool advance(int num_cycles) {
            assert (latency > 0);
            latency -= num_cycles;
            if (latency <= 0) {
                return false;
            }
            return true;
        }
    };


    std::vector<RegisterLatency> pending_register_latencies;
    OperationReservation mult;
    OperationReservation div;
    std::vector<StoreReservation> pending_store_reservations;
    uint64_t num_total_cycles;

    /*
     * Called by the ISS after execution of every instruction to advance the timing model
     * for one clock cycle.
     */
    void advance(int num_cycles=1) {
        assert (num_cycles > 0);

        {
            auto it = pending_register_latencies.begin();
            while (it != pending_register_latencies.end()) {
                if (!it->advance(num_cycles))
                    it = pending_register_latencies.erase(it);
                else
                    ++it;
            }
        }

        mult.advance(num_cycles);
        div.advance(num_cycles);

        {
            auto it = pending_store_reservations.begin();
            while (it != pending_store_reservations.end()) {
                if (!it->advance(num_cycles))
                    it = pending_store_reservations.erase(it);
                else
                    ++it;
            }
        }

        num_total_cycles += num_cycles;
    }

    void stall(int num_cycles) {
        advance(num_cycles);
    }

    /* Called by the ISS whenever a register is read or written.
     * Stalls the pipeline accordingly in case the register is used in a still pending operation. */
    void access_register(unsigned reg_idx) {
        for (const auto &e : pending_register_latencies) {
            if (e.reg_idx == reg_idx) {
                stall(e.latency);
                return;
            }
        }
    }

    bool _find(unsigned reg_idx) {
        unsigned idx = 0;
        for (const auto &e : pending_register_latencies) {
            if (e.reg_idx == reg_idx)
                return true;
            ++idx;
        }
        return false;
    }

    void add_result_latency(unsigned reg_idx, int result_latency) {
        assert (!_find(reg_idx));
        assert (result_latency > 0);
        pending_register_latencies.push_back({reg_idx, result_latency});
    }

    void reserve_mult(int num_cycles) {
        // HiFive1 has a single multiplication unit
        if (mult.acquired)
            stall(mult.latency);    // thus wait for previous mult to finish before performing the next mult
        mult.acquire(num_cycles);
    }

    int get_mult_result_latency(uint32_t a, uint32_t b) {
        // operation: a * b
        return 5+1;
    }

    // called by ISS on every multiplication
    void do_mult(unsigned result_reg_idx, int32_t a, int32_t b) {
        int num_cycles = get_mult_result_latency(a, b);
        reserve_mult(num_cycles);
        add_result_latency(result_reg_idx, num_cycles+1);
    }

    void reserve_div(int num_cycles) {
        // HiFive1 has a single division unit, similar to multiplication
        if (div.acquired)
            stall(div.latency);
        div.acquire(num_cycles);
    }

    int get_div_result_latency(uint32_t a, uint32_t b) {
        // operation: a / b
        // TODO: approximates the delay of a division, add a more precise model if necessary
        return (rand() % 5) + 6;
    }

    // called by ISS on every division
    void do_div(unsigned result_reg_idx, int32_t a, int32_t b) {
        int num_cycles = get_div_result_latency(a, b);
        reserve_div(num_cycles);
        add_result_latency(result_reg_idx, num_cycles);
    }

    // called by ISS on every CSR access
    void do_csr(unsigned result_reg_idx) {
        add_result_latency(result_reg_idx, 5);
    }

    // called by ISS on store instructions
    void reserve_store(Range addr_range, int num_cycles) {
        pending_store_reservations.push_back({addr_range, num_cycles+1});
    }

    bool has_store_reservation(const Range &addrs) {
        for (const auto &e : pending_store_reservations) {
            if (e.overlaps(addrs))
                return true;
        }
        return false;
    }

    // called by ISS on load instructions
    /*
     * A load instructions whose address overlaps with a still pending store instruction results in extra
     * execution penalty.
     */
    void do_load(const Range &addr_range, unsigned rd, int latency) {
        int extra = 0;
        if (has_store_reservation(addr_range)) {
            stall(5);       // load address overlaps previous still pending store address
            if (addr_range.size() < 4)
                extra += 2; // non word size access takes longer, i.e. LB and LH
        }
        add_result_latency(rd, latency+extra);
    }
};



// Return Address Stack (RAS)
struct HiFive1RAS {
    static constexpr unsigned SIZE = 2;

    std::deque<uint64_t> q;

    void push(uint64_t pc) {
        q.push_back(pc);
        if (q.size() > SIZE)
            q.pop_front();
    }

    bool empty() {
        return q.empty();
    }

    uint64_t pop() {
        assert (!empty());
        auto ans = q.back();
        q.pop_back();
        return ans;
    }
};


// Branch Target Buffer (BTB)
// default HiFive1 setting: 40
struct HiFive1BTB {
    static constexpr unsigned NumEntries = 40;
    static constexpr unsigned InstrAlignment = 1;

    std::array<uint64_t, NumEntries> table{};

    inline size_t _tag(uint64_t pc) {
        return (pc / InstrAlignment) % NumEntries;
    }

    inline uint64_t find(uint64_t pc) {
        return table[_tag(pc)];
    }

    inline void update(uint64_t pc, uint64_t target) {
        table[_tag(pc)] = target;
    }
};


// Branch History Table (BHT)
// default HiFive1 settings: 128, 3, 2
struct HiFive1BHT {
    static constexpr unsigned NumEntries = 128;
    static constexpr unsigned NumHistoryBits = 3;
    static constexpr unsigned CounterBits = 2;
    static constexpr unsigned InstrAlignment = 1;

    static constexpr int CounterThreshold = (1 << CounterBits) / 2;
    static constexpr int CounterMax = (1 << CounterBits) - 1;
    static constexpr unsigned HistoryMask = 1 << (NumHistoryBits - 1);

    struct Entry {
        unsigned history = 0;
        int counters[1 << NumHistoryBits] = { 0 };

        bool predict_branch_taken() {
            /* e.g. for two bits:
                StronglyNotTaken = 0,
                NotTaken = 1,
                Taken = 2,
                StronglyTaken = 3
             */
            return counters[history] >= CounterThreshold;
        }

        void update_history(bool branch_taken) {
            assert (history >= 0 && history < (1 << NumHistoryBits));

            if (branch_taken)
                counters[history] = std::min(++counters[history], int(CounterMax));
            else
                counters[history] = std::max(--counters[history], 0);

            history = (history >> 1) | (branch_taken ? HistoryMask : 0);
        }
    };

    std::array<Entry, NumEntries> table{};

    Entry &get_entry(uint64_t pc) {
        auto tag = (pc / InstrAlignment) % NumEntries;
        assert (tag < NumEntries);

        return table[tag];
    }
};


struct HiFive1BranchPredictor {
    static constexpr unsigned BranchMispredictionPenalty = 3;

    HiFive1PipelineTiming *pipeline = nullptr;
    HiFive1RAS RAS;
    HiFive1BTB BTB;
    HiFive1BHT BHT;

    /*
     * Called after execution of every branch instruction.
     *
     * last_pc : address of the branch instruction
     * pc : new address after branch execution
     * branch_taken : true iff the branch was taken
     */
    void update_branch_prediction(uint64_t last_pc, uint64_t pc, bool branch_taken) {
        HiFive1BHT::Entry &bht_entry = BHT.get_entry(last_pc);

        if (bht_entry.predict_branch_taken()) {
            // predict branch taken
            if (branch_taken) {
                if (BTB.find(last_pc) != pc) {
                    // wrong prediction, update data structures and incur execution cycle penalty
                    BTB.update(last_pc, pc);
                    pipeline->stall(BranchMispredictionPenalty);
                }
            } else {
                pipeline->stall(BranchMispredictionPenalty);
            }
        } else {
            // predict branch not taken
            if (branch_taken) {
                BTB.update(last_pc, pc);
                pipeline->stall(BranchMispredictionPenalty);
            }
        }

        bht_entry.update_history(branch_taken);
    }

    /*
     * The following functions are called after a jump, call and return instruction, respectively.
     *
     * last_pc : address of the jump/call/return instruction
     * pc : new address after jump/call/return execution
     * link : the address of the instruction following the jump/call/return instruction in the code
     *        (typically last_pc+4 but can be last_pc+2 due to compressed instructions)
     */

    void do_jump(uint64_t last_pc, uint64_t pc, uint64_t link) {
        if (BTB.find(last_pc) != pc) {
            // wrong prediction, update data structures and incur execution cycle penalty
            BTB.update(last_pc, pc);
            pipeline->stall(BranchMispredictionPenalty);
        }
    }

    void do_call(uint64_t last_pc, uint64_t pc, uint64_t link) {
        do_jump(last_pc, pc, link);
        RAS.push(link);	//NOTE: only keep at most two items (discard any item below)
    }

    void do_ret(uint64_t last_pc, uint64_t pc, uint64_t link) {
        if (RAS.empty() || (pc != RAS.pop()))
            do_jump(last_pc, pc, link);
    }
};


#include "mem_if.h"
#include "dmi.h"

/*
 * For the timing model it is sufficient to decide if a memory access results in a cache miss or not.
 * Hence, the model only keeps track of the addresses in the cache and not the values.
 * In case of a cache miss a pre-defined penalty is added to the total execution time by stalling the pipeline timing model.
 */
struct InstrMemoryProxyWithHiFive1CacheTiming : public rv32::instr_memory_if {
    /*
     * Hifive1 fetches instructions from the flash memory which has quite large (and apparently non-deterministic)
     * delays for loading a cache line. The following values are used as an approximation.
     *
     * NOTE: in contrast to instructions, HiFive1 fetches data from a small 16KB RAM which has small and
     * deterministic access times. Hence, data access load/stores are not passed through this cache model.
     */
    static constexpr unsigned cache_line_load_delay_min = 4520;
    static constexpr unsigned cache_line_load_delay_max = 4720;
    static constexpr unsigned cache_line_load_delay_delta = cache_line_load_delay_max - cache_line_load_delay_min;

    struct CacheLine {
        // 2-way associative cache line entry
        uint32_t first = 0;     // address of first entry
        uint32_t second = 0;    // address of second entry
        bool stat = false;      // replacement strategy LRU mark
    };

    HiFive1PipelineTiming *pipeline = nullptr;
    std::array<CacheLine, 512> lines{};
    MemoryDMI dmi;

    inline uint32_t IDX(uint32_t pc) {
        return pc & 0b11111;
    }

    inline uint32_t TAG(uint32_t pc) {
        return (pc & (0b111111111 << 5)) >> 5;
    }

    inline uint32_t HEAD(uint32_t pc) {
        return pc & ~0b11111111111111;
    }

    // dmi is used to access the actual memory (functional model)
    InstrMemoryProxyWithHiFive1CacheTiming(const MemoryDMI &dmi)
            : dmi(dmi) {
    }

    void update_timing_model(uint64_t pc) {
        assert (pc <= UINT32_MAX);

        auto tag = TAG(pc);
        auto head = HEAD(pc);

        if (lines[tag].first == head) {
            // cache hit on the first entry
            lines[tag].stat = true;
        } else if (lines[tag].second == head) {
            // cache hit on the second entry
            lines[tag].stat = false;
        } else {
            // cache miss
            auto cache_miss_penalty = (rand() % cache_line_load_delay_delta) + cache_line_load_delay_min;
            pipeline->stall(cache_miss_penalty);

            if (lines[tag].stat) {
                // swap second entry
                lines[tag].second = head;
            } else {
                // swap first entry
                lines[tag].first = head;
            }

            // swap LRU status mark
            lines[tag].stat = !lines[tag].stat;
        }
    }

    virtual uint32_t load_instr(uint64_t pc) override {
        update_timing_model(pc);

        // return the functional result
        return dmi.load<uint32_t>(pc);
    }
};


#endif //RISCV_VP_TIMING_H
