file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_executable(peripheral-test-vp
        peripheral_test_main.cpp
        ${HEADERS})

target_link_libraries(peripheral-test-vp rv32 platform-common gdb-mc
	${Boost_LIBRARIES} ${SystemC_LIBRARIES} pthread)

INSTALL(TARGETS peripheral-test-vp RUNTIME DESTINATION bin)
