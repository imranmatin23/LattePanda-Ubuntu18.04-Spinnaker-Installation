# MPL-Research
Repository to store all code written for MPL Research Lab/IMT Engineering Lab with Grant Deane and Dale Stokes at the Scripps Institute of Oceanography.

## Ubuntu 18.04 and Spinnaker SDK Installation on LattePanda Notes
- Download and flash Ubuntu Desktop 18.04 using BalenaEtcher
- Boot from USB
- Disable the second display screen with: `xrandr --output DSI-1 --off`
- Update and upgrade the system with: `sudo apt update -y && sudo apt upgrade -y`
- Install ssh with: `sudo apt install openssh-server -y`
- Install git, curl, vim with: `sudo apt install git curl vim -y`
- Clone this repository.
- Download necessary zip files for Spinnaker SDK and its Python wrapper.
- Run installation scripts:
    1. `sh install_anaconda.sh < install_anaconda_inputs.txt && exit`
    2. `sh create_spinnaker_env.sh`
    3. `sh install_spinnaker.sh < install_spinnaker_inputs.txt`
    4. `sh install_EasyPySpin.sh`


### Errors and Solutions:
- Circular bootup loop on LattePanda with Ubuntu 18.04
    - On bootup, go onto bios and override boot selection and select Ubuntu
- To solve NotWriteableError:
    - sudo chown -R $USER:$USER anaconda 3
- If cannot SSH into SBC:
    - remove the corresponding old key from PATH/.ssh/known_hosts
- To handle memory issue and "Error: Spinnaker: Could not Start Acquisition [-1010]" error run this command (must be done every time, can set it indefinitely by using README steps):
    - `$ sudo sh -c 'echo 256 > /sys/module/usbcore/parameters/usbfs_memory_mb'`
- Don’t use sudo if not necessary
- Make sure you are in the Spinnaker conda environment



## OpenSUSE Leap 42.3 and LabVIEW Installation on LattePanda Notes
- Download and flash OpenSUSE Leap 42.3 using BalenaEtcher
- Boot from USB
- Press ESC to halt Installation
- Press 'e' to edit Installation parameters
- Change the line "set gfxpayload=keep" to "set gfxpayload=text"
- Change the line "linuxefi /boot/x86_64/loader/linux splash=silent" to "linuxefi /boot/x86_64/loader/linux splash=silent textmode=1"
- Press F10 to begin boot process
- 


### Errors and Solutions:
- 
