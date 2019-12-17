#ifndef RISCV_GDB_NG
#define RISCV_GDB_NG

#include <stdint.h>
#include <stddef.h>

#include <queue>
#include <mutex>
#include <systemc>
#include <thread>
#include <map>
#include <tuple>

/* TODO: move this header to common? */
#include <platform/hifive/async_event.h>
#include <libgdb/parser2.h>

#include "debug.h"
#include "core_defs.h"
#include "gdb_stub.h" // DebugMemoryInterface

SC_MODULE(GDBServer) {
public:
	typedef void (GDBServer::*packet_handler)(int, gdb_command_t *);

	void haltReason(int, gdb_command_t *);
	void getRegisters(int, gdb_command_t *);
	void setThread(int, gdb_command_t *);
	void killServer(int, gdb_command_t *);
	void readMemory(int, gdb_command_t *);
	void writeMemory(int, gdb_command_t *);
	void readRegister(int, gdb_command_t *);
	void qAttached(int, gdb_command_t *);
	void qSupported(int, gdb_command_t *);
	void threadInfo(int, gdb_command_t *);
	void threadInfoEnd(int, gdb_command_t *);
	void vCont(int, gdb_command_t *);
	void vContSupported(int, gdb_command_t *);
	void removeBreakpoint(int, gdb_command_t *);
	void setBreakpoint(int, gdb_command_t *);
	void isAlive(int, gdb_command_t *);

	SC_HAS_PROCESS(GDBServer);

	GDBServer(sc_core::sc_module_name,
	          std::vector<debug_target*>,
	          DebugMemoryInterface*,
	          uint16_t);

	sc_core::sc_event *get_stop_event(debug_target *);
	void set_run_event(debug_target *, sc_core::sc_event *);

private:
	typedef std::function<void(debug_target *)> thread_func;
	typedef std::tuple<int, gdb_packet_t *> ctx;
	typedef std::tuple<sc_core::sc_event *, sc_core::sc_event *> hart_event;

	DebugMemoryInterface *memory;
	AsyncEvent asyncEvent;
	Architecture arch;
	std::vector<debug_target*> harts;
	std::thread thr;
	char *prevpkt;
	std::queue<ctx> pktq;
	std::mutex mtx;
	int sockfd;

	/* operation → thread id */
	std::map<char, int> thread_ops;

	/* hart → events */
	std::map<debug_target *, hart_event> events;

	void create_sock(uint16_t);
	std::vector<debug_target *> get_threads(int);
	void exec_thread(thread_func, char = 'g');
	std::vector<debug_target *> run_threads(int);
	void writeall(int, char *, size_t);
	void send_packet(int, const char *, gdb_kind_t = GDB_KIND_PACKET);
	void retransmit(int);
	void dispatch(int conn);
	void serve(void);
	void run(void);
};

#endif
