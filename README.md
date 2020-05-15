# Ubuntu Desktop 18.04 and Spinnaker 1.27.0.48 SDK Installation on LattePanda Steps

This is a guide to installing Ubuntu Desktop 18.04 and Spinnaker 1.27.0.48 SDK onto your LattePanda.

## Prerequisites

These downloads can be either on your LOCAL COMPUTER and then use SCP to transfer them onto the remote computer, or can be downloaded straight onto the REMOTE COMPUTER.

**Download these files from these links.**
1. Download Ubuntu Desktop 18.04.4 LTS from this [link](https://releases.ubuntu.com/18.04.4/).
2. Install BalenaEtcher from this [link](https://www.balena.io/etcher/).


**Spinnaker SDK Option 1:** Download Spinnaker 1.27.0.48 SDK installation files from IMT Lab Dropbox.

1. spinnaker-1.27.0.48-Ubuntu18.04-amd64-pkg.tar.gz 
2. spinnaker_python-1.27.0.48-Ubuntu18.04-cp37-cp37m-linux_x86_64.tar.gz

**Spinnaker SDK Option 2:** Follow links below to download Spinnaker 1.27.0.48 SDK installation files independently. Note, these links may lead to newer releases of the software and may cause issues during installation.

1. Download the Spinnaker for AMD64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).
2. Download the Python wrapper for Spinnaker for x86_64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).


## Installing Ubuntu

**NOTE: All of the following steps until the "Installing Spinnaker" section must be done on the LattePanda.**

A step by step guide that tell you how to install Ubuntu.

1. Burn the .iso onto USB using BalenaEtcher.
2. Insert USB into LattePanda.
3. Press ESC upon boothup to enter BIOS.
4. Boot from the USB drive (usually says name).
5. Choose to install Ubuntu.
    - IMPORTANT: If the Ubuntu Desktop only shows up, then the internal display is enabled. What that means is the HDMI port and the internal display are side by side. You will have to find out which edge will allow the mouse to disappear. Then you must try to grab the installation window from the internal display and drag it onto the monitor.
6. Follow On-Screen instructions.
    - Choose: English.
    - Choose: I don’t want to connect to a wi-fi network right now.
    - Choose: Normal Installation and Download updates.
    - Choose: Erase disk and install Ubuntu.
    - Choose: Time Zone to Los Angeles.
    - Set user credentials.
    - Select login automatically.
7. Remove installation media when prompted.

8. If you did not select "login automatically", a purple screen will appear. You need to enter your password even though it may not show the prompt. Once the password is entered, the Desktop with an orange background and beaver will appear. Press "CTRL-ALT-T" to open a terminal. Type the command below even if you do not see the terminal because your cursor will be already inside the terminal.

9. To disable second output DSI use this command in the terminal.
```
xrandr --output DSI-1 --off
```
10. Enable SSH
```
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl status ssh
sudo ufw allow ssh
```
11. Set up a static IP address for LattePanda. Follow [this guide](https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-18-04/). Please follow the section thtat says "Configuring Static IP address on Ubuntu Desktop" on the lower part of the page. Make sure to open the SETTINGS application and not the SYSTEM SETTINGS application.
    * Change the X in all of the IP addresses 192.168.X.Y to the value that is currently there for your IP Address (ip address can be found using `ip address`)
    * Change the Y in all of the IP addresses 192.168.X.Y to what you would like for this system
    * Below are what need to be customized when setting up you systems static IP if you are confused.
```
IPv4 Method: Manual
Address: 192.168.X.Y
Netmask: 24
Gateway: 192.168.X.1
DNS: 8.8.8.8,1.1.1.1
```


## Installing Spinnaker

A step by step guide that tell you how to install Spinnaker.

**NOTE: These commands were meant to be done through an SSH connection to the LattePanda from a remote computer. They can be done from the Desktop GUI as well with slight modfication.**

1. Login into the LattePanda from your local computer using this command.
```
ssh [USER]@[IP_ADDRESS]
```

2. Update and upgrade the system. If it fails, that means the system is running other apt update processes. Please wait until those complete it may take around 5 minutes, so continue trying the command every minute.
```
sudo apt update -y && sudo apt upgrade -y
```

3. Install necessary Linux commands.
```
sudo apt install git curl vim -y
```

4. Clone the required repository.
```
cd ~/Desktop
git clone https://github.com/imranmatin23/LattePanda-Ubuntu18.04-Spinnaker-Installation.git
```

5. Install Anaconda. The exit command will close the remote SSH connection. This is required to activate the new Anaconda installation.
```
sh install_anaconda.sh && exit
```

6. Login into the LattePanda from your local computer using this command.
```
ssh [USER]@[IP_ADDRESS]
```

7. Create a new Anaconda Spinnaker Python environment. This is necessary to install the correct versions of all the Python Packages used by Spinnaker.
```
sh create_spinnaker_env.sh
```

8. Leave your current terminal and SSH connection open, and open a new terminal on your local computer. Copy the Spinnaker installation files from your local computer to the LattePanda. 
```
scp [LOCAL_PATH]/spinnaker-1.27.0.48-Ubuntu18.04-amd64-pkg.tar.gz [USER]@[IP_ADDRESS]:/home/[USER]/Downloads
```
```
scp [LOCAL_PATH]/spinnaker_python-1.27.0.48-Ubuntu18.04-cp37-cp37m-linux_x86_64.tar.gz [USER]@[IP_ADDRESS]:/home/[USER]/Downloads
```

9. Go back to the terminal that has the SSH connection open. Install Spinnaker and follow onscreen instructions.
```
sh install_spinnaker.sh
```

10. Reboot the LattePanda.
```
sudo reboot
```

11. Login into the LattePanda from your local computer using this command.
```
ssh [USER]@[IP_ADDRESS]
```

12. Increase the memory allocated to the Spinnaker Camera. This is essential for the camera to work.
```
sudo sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'
```

13. Activate the Anaconda Spinnaker environment to use the correct Python packages and versions. Confirm the camera is plugged into the black USB2.0 port and has a flashing green light. Begin acquiring images. 
```
conda activate spinnaker_py37
sh spinnaker_acquisition.sh < spinnaker_acquisition_inputs.txt
```

## Examples of Camera Acquisition Output
![Example Camera Acquisition Output 1](images/example_acquisition1.png)
![Example Camera Acquisition Output 2](images/example_acquisition2.png)

## Errors

1. If cannot SSH into SBC:
    - remove the corresponding old key from PATH/.ssh/known_hosts
2. To handle memory issue and "Error: Spinnaker: Could not Start Acquisition [-1010]" error run this command (must be done every time, can set it indefinitely by using README steps):
    - $ sudo sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'
    - Refer to this [link](https://www.flir.com/support-center/iis/machine-vision/application-note/understanding-usbfs-on-linux/) for a more formal response.
3. Don’t use sudo if not necessary
4. May need to insert dummy HDMI plug if using headless for LattePanda.

## System Notes

1. LattePanda architecture is AMD64 and x86_64
2. When the camera is active it uses 3 Watts. (?CONFIRM?)

## Built With

* Ubuntu - The OS used
* Anaconda - Used to handle Python management
* Spinnaker - Used to get Spinnaker SDK
* [EasyPySpin](https://github.com/elerac/EasyPySpin) - Used to set camera settings using OpenCV

## Contributing

* None

## Versioning

* None

## Authors

* **Imran Matin** - [Github Profile](https://github.com/imranmatin23)

## License

* None

## Acknowledgments

* None

