file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_library(platform-basic
ethernet.cpp
display.cpp
${HEADERS})

target_include_directories(platform-basic PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(riscv-vp
        riscv_vp_adapter.cpp)

target_link_libraries(riscv-vp rv32 platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)

INSTALL(TARGETS riscv-vp RUNTIME DESTINATION lib)
