# Spinnaker 2.0.0.146 SDK Installation on LattePanda

This is a guide to installing Spinnaker 2.0.0.146 SDK onto your LattePanda. Note that in this guide, local computer refers to the computer that you use regularly and LattePanda will refer to your actual LattePanda.

### Prerequisites
* Completed the steps in [README_UBUNTU.md](README_UBUNTU.md).
* Have a FLIR Blackfly S USB3 camera.
* Have a FLIR Blackfly S USB3 cable.

## Section 1: Installing Spinnaker 2.0.0.146 SDK

### Section 1.1: Perform these steps on your LattePanda.
1. Download the required Spinnaker SDK files from Microsoft OneDrive into your Downloads Folder.
    * spinnaker-2.0.0.146-amd64-pkg.tar.gz
    * spinnaker_python-2.0.0.146-cp37-cp37m-linux_x86_64.tar.gz

2. Update and upgrade the system. If it fails, that means the system is running other apt update processes. Please wait until those complete it may take around 5 minutes, so continue trying the command every minute.
    ```
    sudo apt update -y && sudo apt upgrade -y
    ```

3. Clone this repository onto your Desktop if you haven't already from [README_UBUNTU.md](README_UBUNTU.md).
    ```
    cd ~/Desktop
    git clone <repo>
    ```

4. Install Anaconda to handle the Python environment for the LattePanda.
    ```
    sh install_anaconda.sh && exit
    ```

5. Create a new Anaconda Spinnaker Python environment. This is necessary to install the correct versions of all the Python Packages used by Spinnaker.
    ```
    sh create_spinnaker_env.sh
    ```

6. Enable the Spinnaker environment from Step 5 to automatically be activated by uncommenting the following lines in `startup.sh`. These changes will take effect on the next reboot.
    ```
    sudo sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'
    
    . ~/anaconda3/etc/profile.d/conda.sh
    conda activate spinnaker_py37
    ```

7. Install Spinnaker and follow onscreen instructions.
    ```
    sh install_spinnaker.sh
    ```

8. Reboot the LattePanda.
    ```
    sudo reboot
    ```

9. Test the installation worked by running... TODO

10. If Step 9 was successful, then you can begin acquiring images!


## Errors
1. To handle memory issue and "Error: Spinnaker: Could not Start Acquisition [-1010]" error run this command. Refer to this [link](https://www.flir.com/support-center/iis/machine-vision/application-note/understanding-usbfs-on-linux/) for a more formal description of the problem.
    ```
    sudo sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'
    ```

## Extra Notes
* Follow links below to download Spinnaker 2.0.0.146 SDK installation files independently. Note, these links may lead to newer releases of the software and may cause issues during installation.
    * Download the Spinnaker for AMD64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).
    * Download the Python wrapper for Spinnaker for x86_64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).
