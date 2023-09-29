# Cross complilation toolchain file for EK-RA4M3, which uses the 
# R7FA4M3 MCU. 

# Cross compilation system information
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Include the config file which specifies where the compiler lives
include(${CMAKE_CURRENT_LIST_DIR}/../config.cmake)

if (NOT CMAKE_FIND_ROOT_PATH)
message(FATAL_ERROR "Toolchain path not defined. Please set CMAKE_FIND_ROOT_PATH variable in Config.cmake")
endif()

# Switch for Linux or windows
if (CMAKE_HOST_WIN32 )
  SET(BINARY_FILE_EXT ".exe")
else()
  SET(BINARY_FILE_EXT "")
endif()

# Name prefix of the compiler itself
set(TOOLCHAIN_PREFIX arm-none-eabi)

# Compile to static library 
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set project wide definitions
#add_definitions(-D_RA_CORE=CM33)
#add_definitions(-D_RENESAS_RA_)
add_compile_definitions(
  _RA_CORE=CM33
  _RENESAS_RA_
)

# Set compiler flags
# Generated compiler flags
#SET(RASC_CMAKE_CXX_FLAGS "-g -mfloat-abi=hard -O0 -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/arm/CMSIS_5/CMSIS/Core/Include -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/api -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/instances -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg/bsp -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_gen -I ${CMAKE_CURRENT_SOURCE_DIR}/src  -D_RA_CORE=CM33 -D_RENESAS_RA_  -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -mthumb  -std=c99 -MMD -MP -MF <SOURCE>.d -MT <OBJECT>")

#SET(RASC_CMAKE_ASM_FLAGS "-g -mfloat-abi=hard -O0 -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/arm/CMSIS_5/CMSIS/Core/Include -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/api -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/instances -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg/bsp -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_gen -I ${CMAKE_CURRENT_SOURCE_DIR}/src  -D_RA_CORE=CM33 -D_RENESAS_RA_  -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -mthumb   -x assembler-with-cpp -MMD -MP")


#SET(RASC_ASM_FILES "${CMAKE_CURRENT_SOURCE_DIR}/ra_gen/*.asm")

#SET(RASC_CMAKE_C_FLAGS "-g -mfloat-abi=hard -O0 -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/arm/CMSIS_5/CMSIS/Core/Include -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/api -I ${CMAKE_CURRENT_SOURCE_DIR}/ra/fsp/inc/instances -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_cfg/fsp_cfg/bsp -I ${CMAKE_CURRENT_SOURCE_DIR}/ra_gen -I ${CMAKE_CURRENT_SOURCE_DIR}/src  -D_RA_CORE=CM33 -D_RENESAS_RA_  -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -mthumb  -std=c99 -MMD -MP -MF <SOURCE>.d -MT <OBJECT>")


# Set the path and name of the C, CPP and ASM compilers
set(CMAKE_C_COMPILER ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-gcc${BINARY_FILE_EXT})
SET(CMAKE_C_COMPILER_ID CCRX)
SET(CMAKE_C_COMPILER_ID_RUN TRUE)
SET(CMAKE_C_COMPILER_FORCED TRUE)
set(CMAKE_CXX_COMPILER ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-g++${BINARY_FILE_EXT})
SET(CMAKE_CXX_COMPILER_ID CCRX)
SET(CMAKE_CXX_COMPILER_ID_RUN TRUE)
SET(CMAKE_CXX_COMPILER_FORCED TRUE)
set(CMAKE_ASM_COMPILER ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-gcc${BINARY_FILE_EXT})
SET(CMAKE_ASM_COMPILER_FORCED TRUE)

# Specify the linker
set(CMAKE_LINKER ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-gcc${BINARY_FILE_EXT})

# Set archiving tool, object copy and object dump
#set(CMAKE_AR ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-ar${BINARY_FILE_EXT})
#set(CMAKE_OBJCOPY ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-objcopy${BINARY_FILE_EXT})
#set(CMAKE_OBJDUMP ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-objdump${BINARY_FILE_EXT})

# Show the size of the final code
set(CMAKE_SIZE ${CMAKE_FIND_ROOT_PATH}/${TOOLCHAIN_PREFIX}-size${BINARY_FILE_EXT})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM     NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY     ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE     ONLY)


