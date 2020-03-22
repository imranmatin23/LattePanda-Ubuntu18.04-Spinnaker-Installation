#!/bin/sh

# NOTE: Uncomment code and change variable conda_env to allow for user input of conda environment name
# Only way to automate this script is to download the Spinnaker files from Dropbox in the script

### LATTEPANDA FILES ###
# Spinnaker SDK file to download
spinnaker_file=spinnaker-1.27.0.48-Ubuntu18.04-amd64-pkg.tar.gz
# Spinnaker Python Wrapper file to download
python_spinnaker_file=spinnaker_python-1.27.0.48-Ubuntu18.04-cp37-cp37m-linux-x86.tar.gz
# Unzipped Spinnaker SDK folder
spinnaker_folder=spinnaker-1.27.0.48-amd64

# Default conda environment
conda_env=spinnaker_py37

printf "This script will install the Spinnaker SDK and it's Python wrapper.\n"
printf "It is meant for Ubuntu 18.04 and Python3.7 on AMD64/x86 or ARM64/aarch64 architecture.\n"
printf "Please have a Python3.7 conda environment ready and the files downloaded as well as the paths to them.\n"

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

######### VALIDATE USER IS SETUP TO INSTALL SPINNAKER ###########
# activate the conda environment
. ~/anaconda3/etc/profile.d/conda.sh
conda activate ${conda_env}

# Confirm the user has downloaded the files
printf "\nPlease confirm that the correct files for the correct architecture have been downloaded from this link: https://flir.app.boxcn.net/v/SpinnakerSDK?\n"
printf ">>>>>>>>>>> ${spinnaker_file}\n"
printf ">>>>>>>>>>> ${python_spinnaker_file}\n"
read -p "[yes/no] >> " user_input

if [ "$user_input" = "yes" ]; then
  printf "Great!\n"
elif [ "$user_input" = "no" ]; then
  printf "Please download those files.\n"
  exit 1
fi

# Get location of downloaded files
printf "\nWhere did you download the files from above? Please enter an absolute path such as '/home/imran/Downloads'\n"
read -p ">> " download_loc

# check if path is not empty string
if [ -z "$download_loc" ]
then
  echo "This path is an empty string."
  exit 1
fi
# check if file exist
if [ ! -e "$download_loc" ]
then
  echo "This path does not exist."
  exit 1
fi

# Get location to save unzipped files
printf "\nWhere would you like to save those files? Please enter an absolute path such as '/home/imran/Desktop'\n"
read -p ">> " unzip_loc

#check if path is not empty string
if [ -z "$unzip_loc" ]
then
  echo "This path is an empty string."
  exit 1
fi
#check if file exist
if [ ! -e "$unzip_loc" ]
then
  echo "This path does not exist."
  exit 1
fi

########### BEGIN INSTALLATION OF SPINNAKER ###############


printf "\nUnzip Spinnaker SDK...\n"
tar -xzf $download_loc/${spinnaker_file} -C $unzip_loc

printf "\nInstall required dependencies for Spinnaker...\n"
sudo apt-get install libavcodec57 libavformat57 libswscale4 libswresample2 libavutil55 libusb-1.0-0 libgtkmm-2.4-dev -y

printf "\nInstall Spinnaker...\n"
printf "Enter 'yes' to all prompts, and add this user to the usergroup...\n\n"
cd $unzip_loc/${spinnaker_folder}/
sudo sh $unzip_loc/${spinnaker_folder}/install_spinnaker.sh

printf "\nSpinnaker is installed. Now installing Spinnaker Python wrapper.\n"
sleep 5

printf "\nCreate directory to store Spinnaker Python wrapper...\n"
mkdir $unzip_loc/python37-spinnaker

printf "\nUnzip Spinnaker Python wrapper...\n"
tar -xzf $download_loc/${python_spinnaker_file} -C $unzip_loc/python37-spinnaker

printf "\nInstall necessary packages to run Python scripts with Spinnaker...\n"

printf "\nInstall pip...\n"
conda install -c anaconda pip -y

printf "\nInstall numpy...\n"
conda install numpy -y

printf "\nInstall matplotlib...\n"
conda install matplotlib -y

printf "\nInstall Pillow...\n"
conda install Pillow -y

printf "\nInstall Spinnaker Python wrapper from .whl...\n"
cd $unzip_loc/python37-spinnaker/
pip install $unzip_loc/python37-spinnaker/spinnaker_python-1.27.0.48-cp37-cp37m-linux_x86_64.whl

printf "\nConfirm that PySpin module was correctly installed, it should exit silently..."
python -c 'import PySpin'

printf "\nExpand memory limit to allow for camera to open..."
sudo echo 256 > /sys/module/usbcore/parameters/usbfs_memory_mb

printf "\nSpinnaker Python wrapper is installed."
printf "\nAnaconda, the conda environment for Spinnaker, and Spinnaker have been installed successfully...."
printf "\nPlease begin acquiring images..."
printf "\nThank you, goodbye.\n"