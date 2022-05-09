/**
 * @file riscv_vp_adapter.h
 * @author cw (wei.c.chen@intel.com)
 * @brief 
 * @version 0.1
 * @date 2022-05-02
 * 
 * Copyright (C) 2020, Intel Corporation. All rights reserved.
 * 
 * Adapter for connecting a minimal riscv-vp ISA to a Cofluent based SoC IP.
 * Should build up the ISS with required components to run a binary.
 * Exporting a TLM socket for memory access.
 * Configuration knobs:
 *  1. 32/64 bit core, this is determined by macro definition of RV64.
 *  TODO: Take care of CMakeList when build the lib. RV32 as default, RV64 has
 *  potential issues.
 *  2. Core ID
 *  2. Input program
 */


#pragma once

#include <cstdint>
#include <memory>
#include <string>
#include <systemc>
#include <tlm_utils/simple_initiator_socket.h>

#include "iss.h"
#include "memory.h"
#include "elf_loader.h"
#include "mem.h"
#include "syscall.h"
#include "core/common/clint.h"
#include "bus.h"

using namespace std;

#ifndef RV64
using namespace rv32;
#else
using namespace rv64;
#endif

namespace riscv_vp {

class RiscvVpAdapterBuilder;

class RiscvVpAdapter : public sc_core::sc_module  {
public:
    friend class RiscvVpAdapterBuilder;

    ~RiscvVpAdapter();

    bool init();

    // connect the memory interface
    template<typename T>
	void connect(T& dev) {
        bus.isocks[0].bind(dev.tsock);
    }
	
private:
    explicit RiscvVpAdapter(const RiscvVpAdapterBuilder& builder);
    RiscvVpAdapter(const RiscvVpAdapter&);
    void operator=(const RiscvVpAdapter&);

    ISS core;
    SimpleMemory* mem;
    ELFLoader loader;
    CombinedMemoryInterface iss_mem_if;
    SyscallHandler sys;
    CLINT<1> clint;
    SimpleBus<1, 3> bus;
    
    unique_ptr<DirectCoreRunner> runner;
};

class RiscvVpAdapterBuilder {
public:
    typedef unsigned int addr_t;

    friend class RiscvVpAdapter;
    
    explicit RiscvVpAdapterBuilder();

    RiscvVpAdapterBuilder& set_core_id(uint32_t core_id);
    RiscvVpAdapterBuilder& set_mem_start_addr(addr_t mem_start_addr);
    RiscvVpAdapterBuilder& set_mem_size(addr_t mem_size);
    RiscvVpAdapterBuilder& set_clint_start_addr(addr_t clint_start_addr);
    RiscvVpAdapterBuilder& set_clint_end_addr(addr_t clint_end_addr);
    RiscvVpAdapterBuilder& set_sys_start_addr(addr_t sys_start_addr);
    RiscvVpAdapterBuilder& set_sys_end_addr(addr_t sys_end_addr);
    RiscvVpAdapterBuilder& set_entry_point(unsigned long entry_point);
    RiscvVpAdapterBuilder& set_input_program(const string& input_program);
    RiscvVpAdapterBuilder& set_intercept_syscalls(bool intercept_syscalls);
    RiscvVpAdapterBuilder& set_memory(SimpleMemory* mem);

    bool build(shared_ptr<RiscvVpAdapter>* adapter);

private:
    RiscvVpAdapterBuilder(const RiscvVpAdapterBuilder&);
    void operator=(const RiscvVpAdapterBuilder&);

    uint32_t core_id_;
    addr_t mem_start_addr_;
    addr_t mem_size_;
    addr_t mem_end_addr_;
    addr_t clint_start_addr_;
    addr_t clint_end_addr_;
    addr_t sys_start_addr_;
    addr_t sys_end_addr_;
    unsigned long entry_point_;
    bool entry_point_set_;
    string input_program_;
    bool intercept_syscalls_;
    SimpleMemory* mem_;
};

}
