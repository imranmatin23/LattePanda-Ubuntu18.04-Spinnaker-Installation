# Spinnaker 2.0.0.146 SDK Installation on LattePanda

This is a guide to installing Spinnaker 2.0.0.146 SDK onto your LattePanda. Note that in this guide, local computer refers to the computer that you use regularly and LattePanda will refer to your actual LattePanda.

### Prerequisites
* Completed the steps in [README_UBUNTU.md](README_UBUNTU.md).
* Have a FLIR Blackfly S USB3 camera.
* Have a FLIR Blackfly S USB3 cable.

## Section 1: Installing Spinnaker 2.0.0.146 SDK

### Section 1.1: Perform these steps on your LattePanda.
1. Download the required Spinnaker SDK files from Microsoft OneDrive.
    * spinnaker-2.0.0.146-Ubuntu18.04-amd64-pkg.tar.gz 
    * spinnaker_python-2.0.0.146-Ubuntu18.04-cp37-cp37m-linux_x86_64.tar.gz

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

6. Install Spinnaker and follow onscreen instructions.
    ```
    sh install_spinnaker.sh
    ```

7. Reboot the LattePanda.
    ```
    sudo reboot
    ```






### CLEAN UP
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







### Potential Errors
* TODO
    * 

* DONE
    * 


**Spinnaker SDK Option 2:** Follow links below to download Spinnaker 2.0.0.146 SDK installation files independently. Note, these links may lead to newer releases of the software and may cause issues during installation.

1. Download the Spinnaker for AMD64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).
2. Download the Python wrapper for Spinnaker for x86_64 package from this [link](https://flir.app.boxcn.net/v/SpinnakerSDK).
