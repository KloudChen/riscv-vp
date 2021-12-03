/**
 * @file str_transformer.h
 * @author cw (wei.c.chen@intel.com)
 * @brief
 * @version 0.1
 * @date 2021-11-23
 *
 * Copyright (C) 2020, Intel Corporation. All rights reserved.
 *
 * A string transformer as RoCC accelerator. It has two sets of resources for buffering.
 *
 *   ---------------------------------------------------
 * 	| funct7 | rs2 | rs1 | xd | xs1 | xs2 | rd | opcode |
 *   ---------------------------------------------------
 *
 * 	2 operations are supported with different funct7() values:
 * 	0. Register configuration
 *   ----------------------------------------------
 * 	| 0 | rs2 | rs1 | xd | xs1 | xs2 | rd | opcode |
 *   ----------------------------------------------
 *  regs[rs2]: the index of the target register to be configured
 *  regs[rs1]: the value of the configured value
 *
 *  1. Kick off a buffer
 *   ----------------------------------------------
 * 	| 1 | rs2 | rs1 | xd | xs1 | xs2 | rd | opcode |
 *   ----------------------------------------------
 *  regs[rs2]: the index of the buffer to be kicked off
 */

#pragma once

#include <tlm_utils/peq_with_get.h>
#include <tlm_utils/simple_initiator_socket.h>
#include <tlm_utils/simple_target_socket.h>

#include <array>
#include <memory>
#include <systemc>

#include "allocator.h"
#include "core/common/io_fence_if.h"
#include "core/common/rocc_if.h"
#include "core/common/trap.h"
#include "mem.h"

using std::shared_ptr;

#ifdef RV32B
using rv32::GenericMemoryProxy;
#else
using rv64::GenericMemoryProxy;
#endif

class StrTransformer : public rocc_if, public sc_core::sc_module {
   public:
	std::array<tlm_utils::simple_initiator_socket<StrTransformer>, 1> isocks{};
	GenericMemoryProxy<reg_t>* mem_if;
	std::array<tlm_utils::simple_target_socket<StrTransformer>, 2> tsocks{};
	tlm_utils::peq_with_get<tlm::tlm_generic_payload> peq;
	io_fence_if& core;
	tlm_utils::tlm_quantumkeeper quantum_keeper;
	TransAllocator<Transaction<RoccResp>> trans_allocator;

#ifndef COSIM
	SC_HAS_PROCESS(StrTransformer);
#endif

	StrTransformer(sc_core::sc_module_name name, io_fence_if& core);

	void init(GenericMemoryProxy<reg_t>* mem_proxy) {
		mem_if = mem_proxy;
	}

	bool is_busy() const override {
		for (auto& p : phases)
			if (p == TransPhase::RUNNING)
				return true;
		return false;
	}

	void transport_core(tlm::tlm_generic_payload& trans, sc_core::sc_time& delay) {
		auto addr = trans.get_address();
		assert(addr >= ROCC_START_ADDR && addr <= ROCC_END_ADDR);
		peq.notify(trans);
	}

	void transport_mem(tlm::tlm_generic_payload& trans, sc_core::sc_time& delay) {
		assert(false);
	}

	void run();

   private:

    void to_lower(char* buffer, reg_t len);

	void to_upper(char* buffer, reg_t len);

	void load_data(int buffer_index);

	void store_data(int buffer_index);

	void transform(int buffer_index);

   private:
	static constexpr int num_buffers = 2;
	static constexpr int num_funcs = 2;
	static constexpr int buffer_size = 256;
	static const sc_core::sc_time contr_cycle;

	enum TransOp { TO_LOWWER = 0, TO_UPPER };

	enum TransPhase { IDLE = 0, CONFIG, RUNNING } phases[num_buffers]{TransPhase::IDLE};

	/* register address map:
		[00, 01, 02, 03] -> [src_addr[0], dst_addr[0], str_size[0], buffer_func[0]]
	 	[10, 11, 12, 13] -> [src_addr[1], dst_addr[1], str_size[1], buffer_func[1]]
	 	...
	 	[n0, n1, n2, n3] -> [src_addr[n], dst_addr[n], str_size[n], buffer_func[n]]
	*/
	reg_t src_addr[num_buffers]{0};
	reg_t dst_addr[num_buffers]{0};
	reg_t str_size[num_buffers]{0};
	reg_t buffer_func[num_buffers]{0};
	std::array<reg_t*, 4> reg_addrs{src_addr, dst_addr, str_size, buffer_func};


	char buffer[num_buffers][buffer_size];
	std::array<sc_core::sc_time, num_funcs> instr_cycles;
	sc_core::sc_event run_event[num_buffers];
};
