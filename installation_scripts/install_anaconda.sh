#!/bin/sh

# NOTE: Uncomment code to allow for check to confirm user has latest installation script

# Version of anaconda to install
anaconda_script=Anaconda3-2019.10-Linux-x86_64.sh

# URL to current anaconda install file, check if updated version released
anaconda_url=https://repo.anaconda.com/archive/${anaconda_script}

printf "This script will download and install Anaconda.\n"
printf "Please confirm that the script ${anaconda_script} is the latest script available.\n"
sleep 5

# read -p "[yes/no] >> " user_input

# if [ "$user_input" = "yes" ]; then
#  printf "Great!\n"
# elif [ "$user_input" = "no" ]; then
#   printf "Please get the latest script available.\n"
#   exit 1
# fi

printf "\nDownload the installer script...\n"
cd /tmp
curl -O ${anaconda_url}

printf "\nConfirm integrity of installer...\n"
sha256sum ${anaconda_script}

printf "\nRun installation script, accept all questions...\n"
sh ${anaconda_script}

printf "\nAnaconda is installed. This shell will exit in 5 seconds. Thank you, goodbye.\n"
sleep 5
