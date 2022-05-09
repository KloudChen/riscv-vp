file(GLOB_RECURSE HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

add_library(platform-chi
		chi_includes.cpp)

target_include_directories(platform-chi PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(platform-chi ${SystemC_LIBRARIES})