/**
 * @file accelerator.cpp
 * @author cw (wei.c.chen@intel.com)
 * @brief 
 * @version 0.1
 * @date 2021-12-07
 * 
 * Copyright (C) 2020, Intel Corporation. All rights reserved.
 * 
 */

#include "accelerator.h"

const sc_core::sc_time StrTransformer::contr_cycle(10, sc_core::SC_NS);


StrTransformer::StrTransformer(sc_core::sc_module_name name, io_fence_if& core)
    : sc_core::sc_module(name), peq("str_transformer_peq"), core(core) {
    tsocks[0].register_b_transport(this, &StrTransformer::transport_core);
    // TODO: memory has no controller (sc_thread), no concurrent memory access from both CORE & ROCC
    tsocks[1].register_b_transport(this, &StrTransformer::transport_mem);

    for (int i = 0; i < num_buffers; i++) {
        auto pe = std::make_shared<PE>(i, this);
        pes[i] = pe;
    }
}

void StrTransformer::dispatch() {
    while (true) {
        sc_core::wait(peq.get_event());
        tlm::tlm_generic_payload* trans = peq.get_next_transaction();
        while (trans) {
            wait(contr_cycle);
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
                    auto pe = pes[buffer_index];
                    assert(!pe->is_busy());
                    pe->set_reg(local_index, value);
                    pe->phase = PE::TransPhase::CONFIG;
                    break;
                }
                case 1: {  // run
                    assert(!instr.xs1() && instr.xs2() && !instr.xd());
                    auto& buffer_index = req->rs2;
                    assert(buffer_index < num_buffers);
                    auto pe = pes[buffer_index];
                    assert(pe->phase <= PE::TransPhase::CONFIG);
                    pe->phase = PE::TransPhase::RUNNING;
                    pe->notify_run_event();
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

void StrTransformer::monitor() {
    while (true) {
        wait(idle_event);
        core.io_fence_done();
    }
}

void StrTransformer::pe_idle(int index) {
    for (auto& pe : pes) {
        if (pe->is_busy()) return;
    }
    idle_event.notify();
}

bool StrTransformer::is_busy() const {
    for (auto& pe : pes)
        if (pe->is_busy())
            return true;
    return false;
}

void StrTransformer::init(GenericMemoryProxy<reg_t>* mem_proxy) {
    for (auto& pe : pes)
        pe->mem_if = mem_proxy;
}
