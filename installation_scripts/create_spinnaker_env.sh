#!/bin/sh

# NOTE: Uncomment code and change variable env_name to allow for user input of conda environment name

env_name=spinnaker_py37

printf "This script will create a Python 3.7 environment for Spinnaker.\n"

# Allow for conda to be run
printf "\nActivate and test installation...\n"
. ~/.bashrc
conda list

# Update conda and Anaconda
printf "Update conda utility and Anaconda distribution...\n"
conda update conda -y && conda update anaconda -y

# get user input for environment name
# printf "\nWhat would you like the environment to be called? For example: 'spinnaker_py37'?\n"
# read -p ">> " env_name

# check if env_name is not empty string
# if [ -z "$env_name" ]
# then
#   echo "This path is an empty string."
#   exit 1
# fi

printf "\nCreate Python3.7 environment with the name ${env_name}...\n"
conda create --name ${env_name} python=3.7 -y

printf "\nView all available environments...\n"
conda info --envs

printf "\nConfirm Python3.7 is installed...\n"
python --version

printf "\nPlease activate new Python3.7 environment for Spinnaker...\n"
printf "\nYour new environment is created. Thank you, goodbye.\n"
