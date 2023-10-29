#!/bin/sh
# Written by Oskar von Heideken
#
# Brief:
# This script calls RASC (Renesas Smart configurator), which is Renesas
# code generator tool. It's main use here though is not to generate all the files
# for the project, since the FSP files are fetched from source. 
# Rather, this is to handle the pinconfig. RASC has a fairly nice pin-config
# tool, which generates some config files for e.g. UART, SPI and so on. 

# Note, if the pin config needs to be changes, open RASC manually and change the
# pin-config. DO NOT GENERATE THE FILES, but just save the config. 
# This script handles the file generation and picks out the config files 
# required for the build. 

# First, check if RASC is installed and can be found
#rasc_exe="ADD ABSOLUTE PATH TO RASC HERE"
if [ ! -e $rasc_exe ]
then
    echo "RASC could not be found, please change the rasc_exe file name in this script!"
    exit 1
fi
if [ -d tmp_fsp_config ]; then
    rm -r tmp_fsp_config
fi

# Make the temporary directory
mkdir tmp_fsp_config

# Copy the configuration file into the new directory
cp configuration.xml tmp_fsp_config/.

# cd into it and run the configurator
cd tmp_fsp_config

echo "Running RASC. Be prepared for a pop-up that might need closing."
# Run RASC to configure the files
bash -c "$rasc_exe --generate configuration.xml"

# Copy over the relevant files
cd ..
cp -r tmp_fsp_config/ra_cfg/* inc/.
cp -r tmp_fsp_config/ra_gen/* inc/.
cp -r tmp_fsp_config/script/* script/.
cp tmp_fsp_config/memory_regions.ld script/.

# Remove the generated main file:
rm inc/main.c

# Remove the temporary directory
echo "Removing the temporary directory"
rm -r tmp_fsp_config

# Finally, make everything look neat
cd ../../..
find firmware/renesas/ek-ra4m3/inc/ -iname *.c -o -iname *.h | xargs clang-format -i
cd -