/**
 * @file txn_router.h
 * @author cw (wei.c.chen@intel.com)
 * @brief 
 * @version 0.1
 * @date 2022-04-08
 * 
 * Copyright (C) 2020, Intel Corporation. All rights reserved.
 * 
 * A txn_router on one side is connected to the memory interface of a core,
 * on the other side connected to a CHI RN-F and a TLM bus. It accepts
 * incoming requests and route them to the downstream interfaces by telling
 * whether one is a memory transaction or not. Non-memory transactions can be
 * DMA register configurations, CLINT events and so on. It helps to integrate
 * CHI modules without messing the VP itself and the CHI library.
 */

#ifndef TXN_ROUTER_H
#define TXN_ROUTER_H

#include <tlm_utils/simple_initiator_socket.h>
#include <tlm_utils/simple_target_socket.h>
#include <systemc>

class TxnRouter : public sc_core::sc_module {
public:
    TxnRouter(sc_core::sc_module_name, uint64_t mem_start_addr_, uint64_t mem_size_) 
        : mem_start_addr(mem_start_addr_), 
        mem_size(mem_size_) {
        tsock.register_b_transport(this, &TxnRouter::b_transport);
    }

private:
    void b_transport(tlm::tlm_generic_payload &trans, sc_core::sc_time &delay) {
        if (ToMem(trans))
            iscock_mem->b_transport(trans, delay);
        else
            iscock_bus->b_transport(trans, delay);
    }

    bool ToMem(tlm::tlm_generic_payload& trans) {
        auto addr = trans.get_address();
        if (addr < mem_start_addr)
            return false;
        if (addr >= mem_start_addr + mem_size)
            return false;
        return true;
    }

    bool ToBus(tlm::tlm_generic_payload& trans) {
        return !ToMem(trans);
    }

public:
    tlm_utils::simple_target_socket<TxnRouter> tsock;
    tlm_utils::simple_initiator_socket<TxnRouter> iscock_mem;
    tlm_utils::simple_initiator_socket<TxnRouter> iscock_bus;

private:
    uint64_t mem_start_addr;
    uint64_t mem_size;

};


#endif
