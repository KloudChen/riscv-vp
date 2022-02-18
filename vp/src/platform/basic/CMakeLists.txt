file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_library(platform-basic
ethernet.cpp
display.cpp
${HEADERS})

target_include_directories(platform-basic PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(riscv-vp
        main.cpp)

target_include_directories(riscv-vp PUBLIC ${AXI_INCLUDE_DIR} ${VERILATOR_ROOT}/include)

if (TRUE)
        target_compile_definitions(riscv-vp PUBLIC -DRV32B)
        target_link_libraries(riscv-vp rv32 ${DUT_LIBRARIES} ${VERILATED_LIBRARIES} platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
else()
        target_compile_definitions(riscv-vp PUBLIC -DRV64B)
        target_link_libraries(riscv-vp rv64 ${DUT_LIBRARIES} ${VERILATED_LIBRARIES} platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
endif()

INSTALL(TARGETS riscv-vp RUNTIME DESTINATION bin)
