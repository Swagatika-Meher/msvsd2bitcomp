# msvsd2bitcomp
# VSD Mixed Signal PD Research
# INDEX
* [Week 0 - Tools Installation](#Week-0---Tools-Installation)
# Week 0 - Tools Installation
## **Prerequisites**
* **Operating System** - Ubuntu 20.04
* GNU Make
* Git
* Python 3.6+ with PIP
> **NOTE:** Pre layout files may only be simulated using Windows 10. While Ubuntu can be used to run all of the project's files. Therefore, it is generally recommended to obtain Ubuntu for executing  this repository. Ubuntu can be set up in three different ways.
> 1. Using Oracle's Virtual Box or VMWare
> 2. By installing Windows Subsystem for Linux (WSL)
> 3. By Dual Booting the PC with Ubuntu
> 
> _To execute this repo, we can go with the first method as it is easy to install and operate. Virtual Box can be downloaded through this [link](https://www.virtualbox.org/wiki/Downloads)._

## **Tools Installation**
To adequately utilize the open source skywater130 pdk and understand the design flow, we first need to install all the necessary tools, which are
1. NgSpice
2. Xschem
3. Netgen
4. Magic VLSI
5. Open_pdk
###### **Pre Layout**
- Before installing, check whether you are in the root directory:
  ```
  $ cd
  ```
- First, let us run a check on the versions, using the command below:
  ```
  $ sudo apt-get update -y
  ```
* **NgSpice**

  - NgSpice is the open-source spice simulator for electric and electronic circuits.
  - Now, install ngspice using the command below:
    ```
    $ sudo apt-get install -y ngspice
    ```
* **Xschem**
  - Install Git and Make using the commands below:
    ```
    $ sudo apt install git
    $ sudo apt install make
    ```
  - Xschem is a schematic capture program. Install xschem using the command below:
    ```
    $ git clone https://github.com/StefanSchippers/xschem.git xschem_git
    $ sudo apt-get install flex
    $ sudo apt-get install bison
    $ sudo apt-get install libxpm-dev
    $ cd xschem_git
    $ sudo ./configure
    $ sudo make
    $ sudo make install
    ```
###### **Post Layout**

* **Magic VLSI**

  - Some dependencies required to run magic vlsi as it doesn't come preinstalled. Enter the following command in terminal to install before installing magic vlsi:
    ```
    $ sudo apt update && sudo apt install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev
    ```
  - Now, download and install magic vlsi using the following command:
    ```
    $ git clone git://opencircuitdesign.com/magic
    $ cd magic    
    $ sudo ./configure
    $ sudo make
    $ sudo make install
    ```
  - Exit Magic Directory:
    ```
    $ cd ..
    ```
* **Skywater PDK**

  - First, download Sky130 PDK using the following command:
    ```
    $ git clone https://foss-eda-tools.googlesource.com/skywater-pdk/libs/sky130_fd_pr
    ```
* **OpenPDK**

  - Next, we we will need OpenPDK to install and generate the required tech files for magic vlsi:
    ```
    $ git clone git://opencircuitdesign.com/open_pdks
    $ cd open_pdks
    $ git checkout open_pdks-1.0
    ```
  - Now, we have to configure sky130 PDK:
    ```
    $ sudo ./configure  --enable-sky130-pdk=<skywater_root_dir>/skywater-pdk/libraries
    ```
> **NOTE:** For those using home directory do NOT use ~/<your_dir>, please use the full directory /home/username/<your_dir> !!!

  - Next, run the following commands, inside the open_pdks root directory to install skywater PDK:
    ```
    $ cd sky130
    $ sudo make
    $ sudo make install
    ```
* **Sky130 PDK and Magic Integration**

  - Integrate Sky130 PDK with Magic. As the skywater tech files are not installed in magic’s library, we need to create a symbolic link in order to use the tech files for drawing layout. This can be done using:
    ```
    $ sudo ln -s <sky130A_install_root_dir>/sky130A/libs.tech/magic/* /usr/local/lib/magic/sys/
    ```
  - Finally, the installation is complete! 
    Now, come back to the current working directory, and check whether the files are properly installed using the command below:
    ```
    $ tcsh
    $ sudo magic -T sky130A
    ```
    
    
    
