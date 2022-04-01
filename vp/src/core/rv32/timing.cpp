#include "timing.h"
#include "iss.h"

void HiFive1PipelineTiming::advance(int num_cycles) {
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

    iss->quantum_keeper.inc(num_cycles * iss->cycle_time);
    if (iss->quantum_keeper.need_sync()) {
        if (iss->lr_sc_counter == 0) // match SystemC sync with bus unlocking in a tight LR_W/SC_W loop
            iss->quantum_keeper.sync();
    }
}