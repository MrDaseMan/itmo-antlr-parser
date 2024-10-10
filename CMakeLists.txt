cmake_minimum_required (VERSION 3.10)

# Include the MSVC hot-reload support if supported
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

project ("SSLab" C)

if (WIN32)
  message(STATUS "Configuring for MSVC on Windows")
  set(CMAKE_C_COMPILER "cl.exe")
  set(CMAKE_CXX_COMPILER "cl.exe")
else()
  message(STATUS "Configuring for GCC on Unix")
  set(CMAKE_C_COMPILER "gcc")
  set(CMAKE_CXX_COMPILER "g++")
endif()

### ANTLR
# Set the path to the ANTLR runtime
set(ANTLR_RUNTIME_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/antlr3-3.5.3/runtime/C)

# Include the ANTLR runtime
include_directories(${ANTLR_RUNTIME_PATH}/include)
link_directories(${ANTLR_RUNTIME_PATH}/lib)

# Add the generated lexer and parser files
set(GENERATED_FILES
    ${CMAKE_SOURCE_DIR}/lib/langs/lang.c
    ${CMAKE_SOURCE_DIR}/lib/langs/lang.h
)

# Add a custom command to run the ANTLR tool
add_custom_command(
    OUTPUT ${GENERATED_FILES}
    COMMAND java -jar ${CMAKE_CURRENT_SOURCE_DIR}/antlr/antlr-3.5.3-complete.jar -o ${CMAKE_SOURCE_DIR}/lib/langs ${CMAKE_SOURCE_DIR}/tests/lang.g
    DEPENDS ${CMAKE_SOURCE_DIR}/tests/lang.g
    COMMENT "Running ANTLR to generate lexer and parser"
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/langs)
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/langs)

# Ensure that the generated files are built before the executable
add_custom_target(GenerateParserFiles ALL DEPENDS ${GENERATED_FILES})
###

# Add source files
set(SOURCE_FILES
    ${CMAKE_SOURCE_DIR}/src/main.c
    ${GENERATED_FILES}
)

# Add source to this project's executable
add_executable (SSLab ${SOURCE_FILES})

# Add the ANTLR runtime to the executable
target_link_libraries(SSLab antlr3c)

# Custom target to clean the build directory
# cmake --build . --target clean

# Custom target for development build
# cmake --build . --target dev
add_custom_target(dev
  COMMAND ${CMAKE_COMMAND} --build . --config Debug
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "Building in Debug mode"
)

# Custom target for release build
# cmake --build . --target release
add_custom_target(release
  COMMAND ${CMAKE_COMMAND} --build . --config Release
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "Building in Release mode"
)