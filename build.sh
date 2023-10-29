#!/bin/sh
# Script to build the project
rm -r build/*
root_dir=`pwd`
toolchain_file=$root_dir/toolchain/gcc-arm-none-eabi-ra4m3.cmake
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_TOOLCHAIN_FILE=${toolchain_file} -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -S$root_dir -B$root_dir/build -G "MinGW Makefiles"
cd build
cmake --build .
cd ..