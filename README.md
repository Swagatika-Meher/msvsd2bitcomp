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

**1. NgSpice -** Spice Simulation

**2. Xschem -** Schematic Editor

**3. Netgen -** Netlist Comparator

**4. Magic VLSI -** Layout Editor

**5. Open PDK -** Sky130 Library

**6. ALIGN Tool -** Translate SPICE netlist of an analog circuit to a GDSII layout

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
  - Now, download the tarball from this [link](https://sourceforge.net/projects/ngspice/files/ng-spice-rework/old-releases/37/ngspice-37.tar.gz/download) and unpack it using below commands:
    ```
    $ tar -zxvf ngspice-37.tar.gz
    $ cd ngspice-37
    $ mkdir release
    $ cd release
    $ ../configure  --with-x --with-readline=yes --disable-debug
    $ make
    $ sudo make install
    ```
  - Please note that to view the simulation graphs of ngspice, xterm is required and can be installed using.
    ```
    $ sudo apt-get update
    $ sudo apt-get install xterm
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
    $ git clone https://github.com/google/skywater-pdk
    $ cd skywater-pdk
    $ git submodule init libraries/sky130_fd_io/latest
    $ git submodule init libraries/sky130_fd_pr/latest
    $ git submodule init libraries/sky130_fd_sc_hd/latest
    $ git submodule init libraries/sky130_fd_sc_hvl/latest
    $ git submodule init libraries/sky130_fd_sc_hdll/latest
    $ git submodule init libraries/sky130_fd_sc_hs/latest
    $ git submodule init libraries/sky130_fd_sc_ms/latest
    $ git submodule init libraries/sky130_fd_sc_ls/latest
    $ git submodule init libraries/sky130_fd_sc_lp/latest
    $ git submodule update
    $ make timing
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
    More info can be found [here](http://opencircuitdesign.com/open_pdks/).
    
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
* **Netgen**

  - Netgen is a tool for comparing netlists, a process known as LVS, which stands for "Layout vs. Schematic". Install netgen using the command below:
    ```
    $ git clone git://opencircuitdesign.com/netgen
    $ cd netgen
    $ sudo ./configure
    $ sudo make
    $ sudo make install
    $ cd ..
    ```
* **ALIGN Tool**

  - ALIGN is an open source automatic layout generator for analog circuits. The goal of ALIGN (Analog Layout, Intelligently Generated from Netlists) is to automatically translate an unannotated (or partially annotated) SPICE netlist of an analog circuit to a GDSII layout. Use the following commands to install ALIGN tool.
    ```
    $ cd
    $ sudo apt-get install libboost-all-dec
    $ sudo apt-get update
    $ sudo apt-get install ip-solve
    
    $ export CC=/usr/bin/gcc
    $ export CXX=/usr/bin/g++
    $ git clone https://github.com/ALIGN-analoglayout/ALIGN-public
    $ cd ALIGN-public
    
    $ python3 -m venv general
    $ source general/bin/activate
    $ python -m pip install pip --upgrade
    
    $ pip install -v .
    $ pip install -e .
    
    $ pip install setuptools wheel pybind11 scikit-build cmake ninja
    $ pip install -v -e .[test] --no-build-isolation
    $ pip install -v --no-build-isolation -e . --no-deps --install-option='-DBUILD_TESTING=ON'
    ```
* **Making ALIGN Portable to Sky130 tehnology**
  
  - Clone the following Repository inside ALIGN-public directory.
    ```
    $ git clone https://github.com/ALIGN-analoglayout/ALIGN-pdk-sky130
    ```
  Move `SKY130_PDK` folder to `/home/username/ALIGN-public/pdks`.
  To run ALIGN Tool and for more info, follow this [link](https://github.com/sanampudig/OpenFASoC/tree/main/AUXCELL).
