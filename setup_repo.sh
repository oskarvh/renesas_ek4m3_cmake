#!/bin/sh
# Script to setup git repos and other things needed for this repo. 

# Setup software. 
echo "Fetching submodules"
git submodule init
git submodule update
