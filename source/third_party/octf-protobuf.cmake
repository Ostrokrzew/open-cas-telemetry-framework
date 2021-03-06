include(ProcessorCount)
ProcessorCount(N)

set(WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/protobuf")
execute_process(
	COMMAND "mkdir" "-p" "${WORKING_DIRECTORY}"
	RESULT_VARIABLE ret
)

if(NOT ret EQUAL "0")
	message(FATAL_ERROR "Creating directory for protobuf library failed")
endif()

execute_process(
	COMMAND ${CMAKE_COMMAND}
		"${CMAKE_CURRENT_SOURCE_DIR}/protobuf/cmake"
		"-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/third_party"
		"-DCMAKE_CXX_FLAGS_INIT=${CMAKE_CXX_FLAGS_RELEASE}"
		"-DCMAKE_SHARED_LINKER_FLAGS_INIT=${CMAKE_SHARED_LINKER_FLAGS_RELEASE}"
		"-DCMAKE_EXE_LINKER_FLAGS_INIT=${CMAKE_EXE_LINKER_FLAGS_RELEASE}"
		"-DCMAKE_C_FLAGS_RELEASE_INIT=${CMAKE_C_FLAGS_RELEASE}"
		"-Dprotobuf_BUILD_TESTS=NO"
	WORKING_DIRECTORY "${WORKING_DIRECTORY}"
	RESULT_VARIABLE ret
)
if(NOT ret EQUAL "0")
	message(FATAL_ERROR "cmake for protobuf library failed")
endif()

execute_process(
	COMMAND "make" "install" "-j${N}"
	WORKING_DIRECTORY ${WORKING_DIRECTORY}
	RESULT_VARIABLE ret
)
if(NOT ret EQUAL "0")
	message(FATAL_ERROR "Building and installing of protobuf library failed")
endif()
