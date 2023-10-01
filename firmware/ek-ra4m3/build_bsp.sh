#!/bin/sh

# Check if temp directory exists, in which case delete 
if [ -d temp_bsp ]; then
    rm -r temp_bsp
fi

# Make the temporary directory
mkdir temp_bsp

# Copy the configuration file into the new directory
cp configuration.xml temp_bsp/.

# cd into it and run the configurator
cd temp_bsp

# Generate the configuration
rasc_exe=/c/Users/oskar/AppData/Local/Programs/Renesas/RA/sc_v2023-04_fsp_v4.5.0/eclipse/rasc.exe
bash -c "$rasc_exe --generate configuration.xml"

# copy the content of ra_cfg, ra_gen, script and memory_regions.ld back to the lower level
cd ..
cp -r temp_bsp/ra_cfg/* inc/.
cp -r temp_bsp/ra_gen/* inc/.
cp -r temp_bsp/script/* script/.
cp -r temp_bsp/memory_regions.ld script/.
cp temp_bsp/buildinfo.json .

# Remove the generated main file
rm inc/main.c

# Finally, clean up the temporary dir
#rm -r temp_bsp