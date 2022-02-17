/*
 * Copyright (c) 2018 Xilinx Inc.
 * Written by Francisco Iglesias.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
#ifndef TRAFFICDESC_H_
#define TRAFFICDESC_H_

#include "tlm-extensions/genattr.h"
#include "data-transfer.h"

class TrafficDesc : public ITrafficDesc
{
public:
	TrafficDesc(const DataTransferVec& transfers) :
		m_transfers(transfers),
		m_it(m_transfers.begin())
	{}

	TrafficDesc(DataTransferVec&& transfers) :
		m_transfers(transfers),
		m_it(m_transfers.begin())
	{}

	~TrafficDesc()
	{}

	void set_end_check(DataTransfer* e_check) {
		assert(e_check->cmd == DataTransfer::READ);
		assert(e_check->expect != nullptr);
		end_check = e_check;
	}

	virtual tlm::tlm_command getCmd()
	{
		tlm::tlm_command cmd = tlm::TLM_IGNORE_COMMAND;
		if (end_check_mode) {
			return tlm::TLM_READ_COMMAND;
		}

		if ((*m_it).cmd == DataTransfer::WRITE) {
			cmd = tlm::TLM_WRITE_COMMAND;
		} else if ((*m_it).cmd == DataTransfer::READ) {
			cmd = tlm::TLM_READ_COMMAND;
		}

		return cmd;
	}

	virtual uint64_t getAddress() { 
		if (end_check_mode) {
			return end_check->addr;
		}

		return (*m_it).addr;
	}

	virtual unsigned char *getData()
	{
		if (end_check_mode) {
			return const_cast<unsigned char*>(end_check->data);
		}
		return const_cast<unsigned char*>((*m_it).data);
	}

	virtual uint32_t getDataLength() {
		if (end_check_mode) {
			return end_check->length;
		}
		return (*m_it).length;
	}

	virtual unsigned char *getByteEnable()
	{
		if (end_check_mode) {
			return const_cast<unsigned char*>(end_check->byte_enable);
		}
		return const_cast<unsigned char*>((*m_it).byte_enable);
	}

	virtual uint32_t getByteEnableLength()
	{
		if (end_check_mode)
			return end_check->byte_enable_length;
		return (*m_it).byte_enable_length;
	}

	virtual uint32_t getStreamingWidth() {
		if (end_check_mode)
			return end_check->streaming_width;
		return (*m_it).streaming_width;}

	virtual unsigned char *getExpect()
	{
		if (end_check_mode) {
			return const_cast<unsigned char*>(end_check->expect);
		}
		return const_cast<unsigned char*>((*m_it).expect);
	}

	virtual void setExtensions(tlm::tlm_generic_payload *gp)
	{
		DataTransfer& t = end_check_mode ? (*end_check) : (*m_it);

		if (t.ext.gen_attr.enabled) {
			genattr_extension *genattr = new genattr_extension();

			genattr->set_master_id(t.ext.gen_attr.master_id);
			genattr->set_secure(t.ext.gen_attr.secure);
			genattr->set_eop(t.ext.gen_attr.eop);
			genattr->set_wrap(t.ext.gen_attr.wrap);
			genattr->set_burst_width(t.ext.gen_attr.burst_width);
			genattr->set_transaction_id(t.ext.gen_attr.transaction_id);
			genattr->set_exclusive(t.ext.gen_attr.exclusive);
			genattr->set_locked(t.ext.gen_attr.locked);
			genattr->set_bufferable(t.ext.gen_attr.bufferable);
			genattr->set_modifiable(t.ext.gen_attr.modifiable);
			genattr->set_read_allocate(t.ext.gen_attr.read_allocate);
			genattr->set_write_allocate(t.ext.gen_attr.write_allocate);
			genattr->set_qos(t.ext.gen_attr.qos);
			genattr->set_region(t.ext.gen_attr.qos);
			genattr->set_snoop(t.ext.gen_attr.snoop);
			genattr->set_domain(t.ext.gen_attr.domain);
			genattr->set_barrier(t.ext.gen_attr.barrier);
			genattr->set_is_read_tx(t.ext.gen_attr.is_read);

			gp->set_extension(genattr);
		}
	}

	virtual bool done() { return m_it == m_transfers.end(); }
	virtual void next() { m_it++; }

	virtual bool has_end_check() {
		return end_check != nullptr;
	}

	virtual void enter_end_check() {
		end_check_mode = true;
	}

private:
	DataTransferVec m_transfers;
	DataTransferIt  m_it;
	DataTransfer*	end_check{nullptr};
	bool			end_check_mode{false};
};

#endif
