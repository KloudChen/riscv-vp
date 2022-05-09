#include "riscv_vp_adapter.h"

namespace riscv_vp {

RiscvVpAdapterBuilder::RiscvVpAdapterBuilder()
    : core_id_(0),
    mem_start_addr_(0x00000000),
    mem_size_(1024 * 1024 * 32),
    input_program_(""),
    entry_point_set_(false),
    intercept_syscalls_(true) {
        
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_core_id(uint32_t core_id) {
    core_id_ = core_id;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_mem_start_addr(addr_t mem_start_addr) {
    mem_start_addr_ = mem_start_addr;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_mem_size(addr_t mem_size) {
    mem_size_ = mem_size;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_clint_start_addr(addr_t clint_start_addr) {
    clint_start_addr_ = clint_start_addr;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_clint_end_addr(addr_t clint_end_addr) {
    clint_end_addr_ = clint_end_addr;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_sys_start_addr(addr_t sys_start_addr) {
    sys_start_addr_ = sys_start_addr;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_sys_end_addr(addr_t sys_end_addr) {
    sys_end_addr_ = sys_end_addr;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_entry_point(unsigned long entry_point) {
    entry_point_ = entry_point;
    entry_point_set_ = true;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_input_program(const string& input_program) {
    input_program_ = input_program;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_intercept_syscalls(bool intercept_syscalls) {
    intercept_syscalls_ = intercept_syscalls;
    return *this;
}

RiscvVpAdapterBuilder& RiscvVpAdapterBuilder::set_memory(SimpleMemory* mem) {
    mem_ = mem;
    return *this;
}

bool RiscvVpAdapterBuilder::build(shared_ptr<RiscvVpAdapter>* adapter) {
    if (input_program_.empty())
        return false;

    mem_end_addr_ = mem_start_addr_ + mem_size_ - 1;
    RiscvVpAdapter* new_adapter(new RiscvVpAdapter(*this));
    new_adapter->init();
    *adapter = shared_ptr<RiscvVpAdapter>(new_adapter);
    return true;
}


RiscvVpAdapter::RiscvVpAdapter(const RiscvVpAdapterBuilder& bld) :
    sc_module(sc_core::sc_module_name(("riscv_vp_adapter_" + to_string(bld.core_id_)).c_str())),
    core(bld.core_id_),
    mem(bld.mem_),
    loader(bld.input_program_.c_str()),
    iss_mem_if("MemoryInterface", core),
    sys("SyscallHandler"),
    clint("CLINT"),
    bus("SimpleBus") {

    assert(mem != nullptr);

    std::shared_ptr<BusLock> bus_lock = std::make_shared<BusLock>();
	iss_mem_if.bus_lock = bus_lock;

    uint64_t entry_point = loader.get_entrypoint();
	if (bld.entry_point_set_)
		entry_point = bld.entry_point_;
	try {
		loader.load_executable_image(*mem, mem->size, bld.mem_start_addr_);
	} catch(ELFLoader::load_executable_exception& e) {
		std::cerr << e.what() << std::endl;
	}

    core.init(&iss_mem_if, &iss_mem_if, &clint, entry_point, rv32_align_address(bld.mem_end_addr_));
	sys.init(mem->data, bld.mem_start_addr_, loader.get_heap_addr());
	sys.register_core(&core);

	if (bld.intercept_syscalls_)
		core.sys = &sys;
    
    // address mapping
	bus.ports[0] = new PortMapping(bld.mem_start_addr_, bld.mem_end_addr_);
    bus.ports[1] = new PortMapping(bld.clint_start_addr_, bld.clint_end_addr_);
    bus.ports[2] = new PortMapping(bld.sys_start_addr_, bld.sys_end_addr_);

    // connect TLM sockets
	iss_mem_if.isock.bind(bus.tsocks[0]);

    // bus.isocks[0].bind(mem->tsock);
    bus.isocks[1].bind(clint.tsock);
    bus.isocks[2].bind(sys.tsock);

    // connect interrupt signals/communication
    clint.target_harts[0] = &core;

    runner = std::make_unique<DirectCoreRunner>(core);
}

bool RiscvVpAdapter::init() {
    return true;
}

RiscvVpAdapter::~RiscvVpAdapter() {
    core.show();
}

}