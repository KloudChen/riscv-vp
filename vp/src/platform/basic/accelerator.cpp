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
#include "cf_helper.h"

const sc_core::sc_time StrTransformer::contr_cycle(10, sc_core::SC_NS);


StrTransformer::StrTransformer(sc_core::sc_module_name name, io_fence_if& core)
    : sc_core::sc_module(name), peq("str_transformer_peq"), core(core) {
    tsocks[0].register_b_transport(this, &StrTransformer::transport_core);
    // TODO: memory has no controller (sc_thread), no concurrent memory access from both CORE & ROCC
    tsocks[1].register_b_transport(this, &StrTransformer::transport_mem);
}

bool StrTransformer::is_busy() const {
    for (int i = 0; i < num_buffers; i++) {
        auto pe = get_pe(i);
        if (!pe->is_busy())
            return false;
    }
    return true;
}