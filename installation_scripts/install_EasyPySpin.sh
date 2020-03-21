#!/bin/sh

conda_env=spinnaker_py37

printf "\nThis file will install the necessary dependencies for The EasyPySpin library...\n"

# activate the conda environment
printf "\nActivate the conda environment...\n"
. ~/anaconda3/etc/profile.d/conda.sh
conda activate ${conda_env}

printf "\nCloning the EasyPySpin repository...\n"
cd /home/$USER/Desktop/MPL-Research/Spinnaker
git submodule add https://github.com/elerac/EasyPySpin.git

printf "\nInstalling OpenCV...\n"
conda install opencv -y

printf "\nAll dependencies installed. Thank you, goodbye.\n"
