file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

if (NOT BUILD_COSIM)
        message(STATUS "platform-basic: standalone build")
        add_library(platform-basic
                ethernet.cpp
                display.cpp
                str_transformer.cpp
                ${HEADERS})

        if (TRUE)
                target_compile_definitions(platform-basic PUBLIC -DRV32B)
                target_link_libraries(platform-basic rv32 platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        else()
                target_compile_definitions(riscv-vp PUBLIC -DRV64B)
                target_link_libraries(platform-basic rv64 platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        endif()

        target_include_directories(platform-basic PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

        add_executable(riscv-vp
                main.cpp)

        if (TRUE)
                target_compile_definitions(riscv-vp PUBLIC -DRV32B)
                target_link_libraries(riscv-vp rv32 platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        else()
                target_compile_definitions(riscv-vp PUBLIC -DRV64B)
                target_link_libraries(riscv-vp rv64 platform-basic platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        endif()

        INSTALL(TARGETS riscv-vp RUNTIME DESTINATION bin)
else()
        message(STATUS "platform-basic: cosim build")
        add_library(platform-basic
                ethernet.cpp
                display.cpp
                main.cpp
                accelerator.cpp
                ${HEADERS})

        target_include_directories(platform-basic PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

        if (TRUE)
                target_compile_definitions(platform-basic PUBLIC -DRV32B -DCOSIM)
                target_link_libraries(platform-basic rv32 platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        else()
                target_compile_definitions(platform-basic PUBLIC -DRV64B -DCOSIM)
                target_link_libraries(platform-basic rv64 platform-common gdb-mc ${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)
        endif()
endif()
