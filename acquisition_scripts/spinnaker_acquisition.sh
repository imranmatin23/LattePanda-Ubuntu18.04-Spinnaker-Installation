#!/bin/sh

conda_env=spinnaker_py37

printf "This script will run the Spinnaker example python script to acquire images from the camera.\n"

######### Validate location to save the images and where script is  ###########

# Get name of conda environment for spinnaker
# printf "\nWhat is the name of the conda environment for Spinnaker? For example: 'spinnaker_py37'?\n"
# read -p ">> " conda_env

# check if path is not empty string
# if [ -z "$conda_env" ]
# then
#   echo "This path is an empty string."
#   exit 1
# fi


######### Validate location to save the images and where script is  ###########

# Get location to save images
printf "\nWhere would you like to save the images? Please enter an absolute path such as '/home/imran/Desktop/blackfly'\n"
read -p ">> " img_path

#check if path is not empty string
if [ -z "$img_path" ]
then
  echo "This path is an empty string."
  exit 1
fi

# Get location of python script Acquisition.py
printf "\nWhat is the path to the Spinnaker Python Acquisition.py script?. Example: 'path_to_spinnaker_python/Examples/Python3\n"
read -p ">> " script_loc

#check if path is not empty string
if [ -z "$script_loc" ]
then
  echo "This path is an empty string."
  exit 1
fi
#check if file exist
if [ ! -e "$script_loc" ]
then
  echo "This path does not exist."
  exit 1
fi

# create the directory to store the images
mkdir $img_path
cd $img_path

# activate the conda environment
. ~/anaconda3/etc/profile.d/conda.sh
conda activate ${conda_env}

# Run python script to acquire images
python $script_loc/Acquisition.py

printf "\nIf the camera could not start acquisition with error [-1010], run this command..."
printf "\n$ sudo sh -c 'echo 256 > /sys/module/usbcore/parameters/usbfs_memory_mb'"
printf "\nYou must be in the conda environment to acquire images..."
printf "\nThe images have been acquired and can be found out $img_path/$img_directory. Thank you, goodbye.\n"
