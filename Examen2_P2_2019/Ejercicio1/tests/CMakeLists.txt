cmake_minimum_required (VERSION 2.8)
project (test_lcm)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cmake/")

find_package(VERILATOR REQUIRED)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CPP_SRCDIR "${CMAKE_SOURCE_DIR}")
set(VERILOG_SRCDIR "${CMAKE_SOURCE_DIR}/..")
set(VERILOG_SOURCES "${VERILOG_SRCDIR}/LCM.v")
set(VTOPMODULE "LCM")
set(VERILOG_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/verilog-build")
set(VERILOG_LIB "${VERILOG_BINARY_DIR}/V${VTOPMODULE}__ALL.a")
separate_arguments(VERILOG_SOURCES)

# Run verilator to compile the MIPS32SOC
add_custom_command (
    OUTPUT ${VERILOG_LIB}
    COMMAND ${VERILATOR} -Wall -Wno-fatal -I${VERILOG_SRCDIR} --cc ${VERILOG_SOURCES}
            --top-module ${VTOPMODULE} -Mdir ${VERILOG_BINARY_DIR} -CFLAGS "-I${CPP_SRCDIR} -std=c++14 -O2 -DNDEBUG"
    COMMAND make -C ${VERILOG_BINARY_DIR} -f V${VTOPMODULE}.mk
    MAIN_DEPENDENCY ${VERILOG_SRCDIR}/${VTOPMODULE}.v
    DEPENDS ${VERILOG_SOURCES}
  )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${VERILOG_BINARY_DIR})
include_directories(${VERILATOR_INCLUDE_DIR})
include_directories(${VERILATOR_DPI_INCLUDE_DIR})
include_directories(${CPP_SRCDIR})

set_source_files_properties(
    ${PROJECT_NAME}.cpp
    PROPERTIES OBJECT_DEPENDS ${VERILOG_LIB}
)

set_directory_properties(
    PROPERTIES
    ADDITIONAL_MAKE_CLEAN_FILES "${VERILOG_BINARY_DIR}"
)
 
add_executable(${PROJECT_NAME}  ${VERILATOR_INCLUDE_DIR}/verilated.cpp
                                ${PROJECT_NAME}.cpp)

target_link_libraries(${PROJECT_NAME} ${VERILOG_LIB})
