file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_executable(tiny32-mc
        mc_main.cpp
        ${HEADERS})

target_compile_definitions(tiny32-mc PUBLIC -DRV32B)  
target_link_libraries(tiny32-mc rv32 platform-common gdb-mc
	${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)

INSTALL(TARGETS tiny32-mc RUNTIME DESTINATION bin)
