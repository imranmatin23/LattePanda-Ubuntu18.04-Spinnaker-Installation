#!/bin/bash

# Turn of DSI-1 LP internal display
xrandr --output DSI-1 --off

# Increase memory for spinnaker camera
# sudo sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'

# activate conda environment
# . ~/anaconda3/etc/profile.d/conda.sh
# conda activate spinnaker_py37

# Run the camera acquisition
# cd /home/$USER/Desktop/waveglider-coms
# python cSBC.py