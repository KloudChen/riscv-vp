# if(NOT USE_SYSTEM_SYSTEMC)
# 	find_package( SystemC REQUIRED)
# 	include_directories( ${SystemC_INCLUDE_DIRS})
# else()
# 	find_library(SystemC_LIBRARIES libsystemc.a)
# endif()

file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

if (NOT BUILD_COSIM)
        add_library(platform-basic
                ethernet.cpp
                display.cpp
                str_transformer.cpp
                ${HEADERS})

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
        add_library(platform-basic
                ethernet.cpp
                display.cpp
                main.cpp
                str_transformer.cpp
                ${HEADERS})

        target_include_directories(platform-basic PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

        if (TRUE)
                target_compile_definitions(platform-basic PUBLIC -DRV32B -DCOSIM)
                target_link_libraries(platform-basic rv32 platform-common gdb-mc ${Boost_LIBRARIES} systemc pthread)
        else()
                target_compile_definitions(platform-basic PUBLIC -DRV64B -DCOSIM)
                target_link_libraries(platform-basic rv64 platform-common gdb-mc ${Boost_LIBRARIES} systemc pthread)
        endif()
endif()
