# CMakeLists for an EK-RA4M3 project that uses FreeRTOS from source, 
# along with FSP from source and some generated BSP files

# Project minimum required CMake version
cmake_minimum_required(VERSION 3.16.4)

# Project configuration
project(ek_ra4m3_freertos_cmake
	VERSION 1.0.0
	LANGUAGES C ASM)

# Set variables for root directories, used below
set(PROJECT_ROOT ${CMAKE_CURRENT_LIST_DIR})
set(RA_ROOT ${PROJECT_ROOT}/firmware/ek-ra4m3)

#-------------FREE-RTOS-------------
# Build FreeRTOS as an interface library
set(FREERTOS_PORT "GCC_ARM_CM33 CACHE STRING")
add_library(freertos_config INTERFACE)
target_include_directories(freertos_config SYSTEM
    INTERFACE
    "${CMAKE_CURRENT_LIST_DIR}/firmware/ek-ra4m3/inc/FreeRTOSConfig.h"
) # The config file directory
target_compile_definitions(freertos_config
    INTERFACE
    projCOVERAGE_TEST=0
)

#-------------FREE-RTOS-------------
#source directories
file(GLOB_RECURSE Source_Files 
    "${RA_ROOT}/src/*.c"
    "${RA_ROOT}/inc/*.c"
    # Include FSP files
    "${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/*.c"
    "${PROJECT_ROOT}/fsp/ra/fsp/src/r_ioport/*.c"
    "${PROJECT_ROOT}/fsp/ra/board/ra4m3_ek/*.c"
)


SET(ALL_FILES ${Source_Files})

add_executable(${PROJECT_NAME}.elf ${ALL_FILES})

target_include_directories(${PROJECT_NAME}.elf
    PUBLIC
    ${PROJECT_ROOT}/CMSIS_5/CMSIS/Core/Include/
    ${RA_ROOT}/src/
    ${RA_ROOT}/inc/
    ${RA_ROOT}/inc/fsp_cfg/
    ${RA_ROOT}/inc/fsp_cfg/bsp/
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/instances/
    ${PROJECT_ROOT}/fsp/ra/fsp/inc/api/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/bsp/
    ${PROJECT_ROOT}/fsp/ra/fsp/src/r_ioport/
    ${PROJECT_ROOT}/fsp/ra/board/ra4m3_ek/
)

target_link_libraries(
    ${PROJECT_NAME}.elf INTERFACE
    freertos_config
)



set(ARM_OPTIONS -mcpu=cortex-m33 -mfloat-abi=hard -mfpu=fpv5-sp-d16)
set(COMPILER_WARNINGS -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal)
target_compile_options(
    ${PROJECT_NAME}.elf
    PUBLIC
    -g
    ${ARM_OPTIONS}
    -fmessage-length=0
    -funsigned-char
    -ffunction-sections
    -fdata-sections
    -mthumb
    ${COMPILER_WARNINGS}
    -MMD
    -MP
)

#SET(RASC_CMAKE_EXE_LINKER_FLAGS "-g -mfloat-abi=hard -O0 -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -mthumb -T fsp.ld -Xlinker --gc-sections -Wl,-Map,${PROJECT_NAME}.map --specs=nano.specs --specs=rdimon.specs -L ${CMAKE_CURRENT_SOURCE_DIR}/ -L ${CMAKE_CURRENT_SOURCE_DIR}/script  -o ${CMAKE_CURRENT_SOURCE_DIR}/build/CMakeFiles/${RASC_PROJECT_NAME}.elf.dir/${RASC_PROJECT_NAME}.elf")
# TODO: There are a couple of things I need to add here. 
# LINKER
# Add the script subdirectory to the linked directory:
target_link_directories(
    ${PROJECT_NAME}.elf
    PUBLIC
    ${RA_ROOT}/script/
)

# Set the linker script path:
set(FSP_LINKER_SCRIPT ${RA_ROOT}/script/fsp.ld)

# Link options:
target_link_options(
    ${PROJECT_NAME}.elf
    PUBLIC
    -g
    ${ARM_OPTIONS}
    -fmessage-length=0
    -funsigned-char
    -ffunction-sections
    -fdata-sections
    -mthumb
    -Xlinker
    --gc-sections 
    -Wl,-Map=${PROJECT_NAME}.map 
    --specs=nano.specs 
    --specs=rdimon.specs
    ${COMPILER_WARNINGS}
    #-u_printf_float
    #-u_scanf_float
    #-nostartfiles
    -T ${FSP_LINKER_SCRIPT}
)