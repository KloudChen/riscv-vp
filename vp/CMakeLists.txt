cmake_minimum_required(VERSION 2.8.12)
project(riscv-vp)

option(USE_SYSTEM_SYSTEMC "use systemc version provided by the system" OFF)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()

set(CMAKE_CXX_STANDARD 14)
# set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-unused-parameter") # TODO: -Wpedantic
set(CMAKE_CXX_FLAGS "-Wno-unused-parameter") # TODO: -Wpedantic
set(CMAKE_CXX_FLAGS_DEBUG "-g3")        #"-fsanitize=address -fno-omit-frame-pointer"
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Allows running tests without invoking `make install` first.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR})

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()
message(STATUS "Found verilator. Root: " ${VERILATOR_ROOT})
set(VERILATOR ${VERILATOR_ROOT}/bin/verilator)

find_package(Dut REQUIRED)
message(STATUS "dut lib:" ${DUT_LIBRARIES})

find_package( Boost REQUIRED COMPONENTS iostreams program_options log)

if(NOT USE_SYSTEM_SYSTEMC)
	find_package( SystemC REQUIRED)
	include_directories( ${SystemC_INCLUDE_DIRS})
else()
	find_library(SystemC_LIBRARIES libsystemc.a)
endif()

find_package( SoftFloat REQUIRED )
include_directories( ${SoftFloat_INCLUDE_DIRS} )

# verilate sc modules
# set(VERILATOR_FLAGS --sc --pins-bv 2 -O2 -x-assign 0 --assert)
# set(VERILATOR_FLAGS --sc --pins-bv 2 -CFLAGS -std=c++14)
set(VERILATOR_FLAGS --sc --pins-bv 2)
execute_process(COMMAND rm -rf ${DUT_SC_DIR})
execute_process(COMMAND mkdir -p ${DUT_SC_DIR})
execute_process(COMMAND ${VERILATOR} ${VERILATOR_FLAGS} ${DUT_SRC_V} --Mdir ${DUT_SC_DIR})
execute_process(COMMAND make -j4 -C ${DUT_SC_DIR} -f ${DUT_MF})

# build verilator lib
execute_process(COMMAND g++ -c ${VERILATOR_ROOT}/include/verilated.cpp -I${VERILATOR_ROOT}/include -o verilated.o -std=c++14)
execute_process(COMMAND ar -cr verilated.a verilated.o)
set(VERILATED_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/verilated.a)

subdirs(src)

enable_testing()
list(APPEND CMAKE_CTEST_ARGUMENTS "--verbose")

add_test(NAME libgdb
	COMMAND ./test.sh
	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/tests/libgdb")
add_test(NAME gdb
	COMMAND ./test.sh
	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/tests/gdb")
add_test(NAME integration
	COMMAND ./test.sh
	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/tests/integration")
add_test(NAME sw
	COMMAND ./test.sh
	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/../sw")

set_tests_properties(gdb integration sw PROPERTIES ENVIRONMENT
	PATH=$ENV{PATH}:${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
set_tests_properties(libgdb PROPERTIES ENVIRONMENT
	RISCV_VP_BASE=${CMAKE_CURRENT_SOURCE_DIR}/..)
