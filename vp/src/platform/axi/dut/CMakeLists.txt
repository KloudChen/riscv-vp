cmake_minimum_required(VERSION 3.8)
project(dut_gen)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "-Wno-unused-parameter -g")
# set(CMAKE_CXX_FLAGS_DEBUG "-g3")
# set(CMAKE_CXX_FLAGS_RELEASE "-O3")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_package(SystemC REQUIRED)
message(STATUS "systemc lib: " ${SYSTEMC_LIBRARIES})

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()
message(STATUS "Found verilator. Root: " ${VERILATOR_ROOT})
set(VERILATOR ${VERILATOR_ROOT}/bin/verilator)

find_package(Dut REQUIRED)
message(STATUS "dut lib:" ${DUT_LIBRARIES})

# verilate sc modules
# set(VERILATOR_FLAGS --sc --pins-bv 2 -O2 -x-assign 0 --assert)
# set(VERILATOR_FLAGS --sc --pins-bv 2 -CFLAGS -std=c++14)
set(VERILATOR_FLAGS --sc --pins-bv 2)
execute_process(COMMAND rm -rf ${DUT_SC_DIR})
execute_process(COMMAND mkdir -p ${DUT_SC_DIR})
execute_process(COMMAND ${VERILATOR} ${VERILATOR_FLAGS} ${DUT_SRC_V} --Mdir ${DUT_SC_DIR})
execute_process(COMMAND make -j4 -C ${DUT_SC_DIR} -f ${DUT_MF})

# build verilator lib
execute_process(COMMAND g++ -c ${VERILATOR_ROOT}/include/verilated.cpp -I${VERILATOR_ROOT}/include -o verilated.o)
execute_process(COMMAND ar -cr verilated.a verilated.o)
set(VERILATED_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/verilated.a)

# include_directories(
#     .
#     ${SYSTEMC_INCLUDE_DIR}
#     ${VERILATOR_ROOT}/include)

# file(
#     GLOB_RECURSE SRCS
#     test_main.cc
#     test-modules/*.cc
#     traffic_generators/config_parser/*.cc)

# add_executable(test_demo ${SRCS})
# target_link_libraries(test_demo ${SYSTEMC_LIBRARIES} ${VERILATED_LIBRARIES} ${DUT_LIBRARIES})
# target_link_libraries(test_demo ${DUT_LIBRARIES} m stdc++ ${SYSTEMC_LIBRARIES} ${VERILATED_LIBRARIES})
