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

set(ARM_OPTIONS -mcpu=cortex-m33 -O0 -mfloat-abi=hard -mfpu=fpv5-sp-d16)
set(COMPILER_WARNINGS -Wall)
add_compile_options(
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

# Link options:
add_link_options(
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
    ${COMPILER_WARNINGS}
)