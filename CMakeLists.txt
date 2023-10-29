# CMakeLists for an EK-RA4M3 project that uses FreeRTOS from source, 
# along with FSP from source and some generated BSP files

# Project minimum required CMake version
cmake_minimum_required(VERSION 3.16.4)

# Project configuration
project(ek_ra4m3_freertos_cmake
	VERSION 1.0.0
	LANGUAGES C ASM
)

set (CMAKE_C_STANDARD 11)

# Set variables for root directories, used below
set(PROJECT_ROOT ${CMAKE_CURRENT_LIST_DIR})
set(RA_ROOT ${CMAKE_CURRENT_LIST_DIR}/firmware/ek-ra4m3)

#-------------FREE-RTOS-------------
# Build FreeRTOS as an interface library

#set(FREERTOS_PORT "GCC_ARM_CM33_NONSECURE CACHE STRING")
#add_library(freertos_config INTERFACE)
#target_include_directories(freertos_config SYSTEM
#    INTERFACE
#    ${CMAKE_CURRENT_LIST_DIR}/firmware/ek-ra4m3/inc/FreeRTOSConfig.h
#) # The config file directory
#target_compile_definitions(freertos_config
#    INTERFACE
#    projCOVERAGE_TEST=0
#)
#add_subdirectory(${PROJECT_ROOT}/FreeRTOS-kernel)
file(GLOB freertos_files
    #${CMAKE_CURRENT_LIST_DIR}/inc/FreeRTOSConfig.h
    ${PROJECT_ROOT}/FreeRTOS-kernel/*.c
    #${GIT_ROOT}/software/FreeRTOS-Kernel/portable/GCC/ARM_CM33_NTZ/non_secure/*.c
    ${PROJECT_ROOT}/fsp/ra/fsp/src/rm_freertos_port/*.c
    ${PROJECT_ROOT}/FreeRTOS-kernel/portable/MemMang/heap_3.c
    #
)
#-------------FSP-------------
file(GLOB fsp_files
    ${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/cmsis/Device/RENESAS/Source/*.c
    ${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/mcu/all/*.c
    ${PROJECT_ROOT}/fsp/ra/board/ra4m3_ek/*.c
    ${PROJECT_ROOT}/fsp/ra/fsp/src/r_ioport/*.c
)

#-------------Source files-------------
file(GLOB_RECURSE source_files 
    # Firmware source files, incl. generated sources
    ${RA_ROOT}/src/*.c
    ${RA_ROOT}/inc/*.c
)


SET(ALL_FILES ${source_files} ${fsp_files} ${freertos_files})

add_executable(${PROJECT_NAME}.elf ${ALL_FILES})

target_include_directories(${PROJECT_NAME}.elf PUBLIC
    # Firmware
    ${RA_ROOT}/inc/
    ${RA_ROOT}/inc/fsp_cfg/
    ${RA_ROOT}/inc/fsp_cfg/bsp/
    ${RA_ROOT}/src/
    # ARM CMSIS:
    ${PROJECT_ROOT}/CMSIS_5/CMSIS/Core/Include
    # FSP
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/instances/
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/api/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/mcu/all/
    ${PROJECT_ROOT}/fsp/ra/board/ra4m3_ek/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/r_ioport/
    # FreeRTOS
    ${PROJECT_ROOT}/FreeRTOS-kernel/include/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/rm_freertos_port/
)

#target_link_libraries(
#    ${PROJECT_NAME}.elf INTERFACE
#    freertos_config
#)

# Set the linker script path:
set(FSP_LINKER_SCRIPT_PATH ${RA_ROOT}/script/)
set(FSP_LINKER_SCRIPT ${RA_ROOT}/script/fsp.ld)

# Add the specific linker script
target_link_options(
    ${PROJECT_NAME}.elf
    PUBLIC
    -T ${FSP_LINKER_SCRIPT}
    -L ${FSP_LINKER_SCRIPT_PATH}
)


