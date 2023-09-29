# CMakeLists for an EK-RA4M3 project that uses FreeRTOS from source, 
# along with FSP from source and some generated BSP files

# Project minimum required CMake version
cmake_minimum_required(VERSION 3.16.4)

# Project configuration
project(ek_ra4m3_freertos_cmake
	VERSION 1.0.0
	LANGUAGES C CXX ASM)

# Set variables for root directories, used below
set(PROJECT_ROOT ${CMAKE_CURRENT_LIST_DIR})
set(GIT_ROOT ${CMAKE_CURRENT_LIST_DIR}/../..)


# Set the linker script path:
set(FSP_LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/script/fsp.ld)

#source directories
file(GLOB_RECURSE Source_Files 
"${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
"${CMAKE_CURRENT_SOURCE_DIR}/inc/*.cpp"
# Include FreeRTOS
"${GIT_ROOT}/FreeRTOS-kernel/include/*.c"
"${GIT_ROOT}/FreeRTOS-kernel/portable/GCC/ARM_CM33/non_secure/*.c"
# Include FSP files
"${GIT_ROOT}/fsp/ra/fsp/src/bsp/*.c"
"${GIT_ROOT}/fsp/ra/fsp/src/r_ioport/*.c"
"${GIT_ROOT}/fsp/ra/board/ra4m3_ek/*.c"

)


SET(ALL_FILES ${Source_Files})

add_executable(${PROJECT_NAME}.elf ${ALL_FILES})

target_include_directories(${PROJECT_NAME}.elf
    PUBLIC
    ${GIT_ROOT}/CMSIS_5/CMSIS/Core/Include/
    ${CMAKE_CURRENT_SOURCE_DIR}/src/
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/fsp_cfg/
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/fsp_cfg/bsp/
    ${GIT_ROOT}/FreeRTOS-kernel/include/
    ${GIT_ROOT}/FreeRTOS-kernel/portable/GCC/ARM_CM33/non_secure/
    ${GIT_ROOT}/fsp/ra/fsp/inc/
    ${GIT_ROOT}/fsp/ra/fsp/inc/instances/
    ${GIT_ROOT}/fsp/ra/fsp/inc/api/
    ${GIT_ROOT}/fsp/ra/fsp/src/bsp/
    ${GIT_ROOT}/fsp/ra/fsp/src/r_ioport/
    ${GIT_ROOT}/fsp/ra/board/ra4m3_ek/
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