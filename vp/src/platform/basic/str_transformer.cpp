#include "str_transformer.h"

const sc_core::sc_time StrTransformer::contr_cycle(10, sc_core::SC_NS);

StrTransformer::StrTransformer(sc_core::sc_module_name name, io_fence_if& core)
    : sc_core::sc_module(name), peq("str_transformer_peq"), core(core) {
    for (int i = 0; i < num_buffers; i++) {
        memset(buffer[i], 0, sizeof(buffer[i]));
    }

    sc_core::sc_time ins_time(10, sc_core::SC_NS);
    for (int i = 0; i < num_funcs; i++) {
        instr_cycles[i] = ins_time;
    }

    tsocks[0].register_b_transport(this, &StrTransformer::transport_core);
    // TODO: memory has no controller (sc_thread), no concurrent memory access from both CORE & ROCC
    tsocks[1].register_b_transport(this, &StrTransformer::transport_mem);

#ifndef COSIM
    SC_THREAD(run);
#endif
}

void StrTransformer::run() {
#ifndef COSIM
    for (int i = 0; i < num_buffers; i++) {
        sc_core::sc_spawn(sc_bind(&StrTransformer::transform, this, i));
    }
#endif

    while (true) {
        sc_core::wait(peq.get_event());
        tlm::tlm_generic_payload* trans = peq.get_next_transaction();
        while (trans) {
            quantum_keeper.inc(contr_cycle);
            if (quantum_keeper.need_sync()) {
                quantum_keeper.sync();
            }

            auto req = (RoccCmd*)trans->get_data_ptr();
            auto& instr = req->instr;
            auto func = instr.funct7();
            switch (func) {
                case 0: {  // configure
                    assert(instr.xs1() && instr.xs2() && !instr.xd());
                    auto& index = req->rs2;
                    auto& value = req->rs1;
                    auto buffer_index = index / 10;
                    auto local_index = index % 10;
                    assert(buffer_index < num_buffers);
                    assert(local_index < 4);
                    assert(phases[buffer_index] <= TransPhase::CONFIG);
                    *(reg_addrs[local_index] + buffer_index) = value;
                    phases[buffer_index] = TransPhase::CONFIG;
                    break;
                }
                case 1: {  // run
                    assert(!instr.xs1() && instr.xs2() && !instr.xd());
                    auto& buffer_index = req->rs2;
                    assert(buffer_index < num_buffers);
                    assert(phases[buffer_index] <= TransPhase::CONFIG);
                    phases[buffer_index] = TransPhase::RUNNING;
                    run_event[buffer_index].notify();
                    break;
                }
                default:
                    raise_trap(EXC_ILLEGAL_INSTR, instr.data());
            }

            trans->release();
            trans = peq.get_next_transaction();
        }
    }
}

void StrTransformer::transform(int buffer_index) {
    while (true) {
        wait(run_event[buffer_index]);
        assert(buffer_func[buffer_index] < num_funcs);
        wait(instr_cycles[buffer_func[buffer_index]]);
        switch (buffer_func[buffer_index]) {
            case TransOp::TO_LOWWER: {
                load_data(buffer_index);
                to_lower(buffer[buffer_index], str_size[buffer_index]);
                store_data(buffer_index);
                break;
            }
            case TransOp::TO_UPPER: {
                load_data(buffer_index);
                to_upper(buffer[buffer_index], str_size[buffer_index]);
                store_data(buffer_index);
                break;
            }
            default:
                raise_trap(EXC_ILLEGAL_INSTR, buffer_func[buffer_index]);
        }
        
        phases[buffer_index] = TransPhase::IDLE;
        if (!is_busy()) {
            core.io_fence_done();
        }
    }
}

void StrTransformer::to_lower(char* buffer, reg_t len) {
    char* c = buffer;
    static int inc = 'a' - 'A';
    while (len > 0) {
        if (*c >= 'A' && *c <= 'Z')
            *c += inc;
        c++;
        len--;
    }
}

void StrTransformer::to_upper(char* buffer, reg_t len) {
    char* c = buffer;
    static int inc = 'a' - 'A';
    while (len > 0) {
        if (*c >= 'a' && *c <= 'z')
            *c -= inc;
        c++;
        len--;
    }
}

void StrTransformer::load_data(int buffer_index) {
    auto len = str_size[buffer_index];
    auto addr = src_addr[buffer_index];
    auto offset = 0;
    reg_t data;
    while (len > sizeof(reg_t)) {
        data = mem_if->load(addr);
        memcpy(buffer[buffer_index] + offset, &data, sizeof(reg_t));
        offset += sizeof(reg_t);
        len -= sizeof(reg_t);
        addr += sizeof(reg_t);
    }
    if (len > 0) {
        data = mem_if->load(addr);
        memcpy(buffer[buffer_index] + offset, &data, len);
    }
}

void StrTransformer::store_data(int buffer_index) {
    auto len = str_size[buffer_index];
    auto addr = dst_addr[buffer_index];
    auto offset = 0;
    reg_t data;
    while (len > sizeof(reg_t)) {
        memcpy(&data, buffer[buffer_index] + offset, sizeof(reg_t));
        mem_if->store(addr, data);
        offset += sizeof(reg_t);
        len -= sizeof(reg_t);
        addr += sizeof(reg_t);
    }
    if (len > 0) {
        memcpy(&data, buffer[buffer_index] + offset, len);
        mem_if->store(addr, data);
    }
}