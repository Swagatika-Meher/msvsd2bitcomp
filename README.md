# msvsd2bitcomp
# VSD Mixed Signal PD Research
# INDEX
* [Week 0](#Week-0)
  - [Tools Installation](#Tools-Installation)
  - [Create Inverter and perform pre-layout using Xschem and NgSpice](#Create-Inverter-and-perform-pre-layout-using-Xschem-and-NgSpice) 
# Week 0
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
* **Verifying the OpenPDK installation**
  
  - An initial working directory can be made by copying the required files as follows:
    ```
    $ mkdir test
    $ cd test
    $ mkdir mag
    $ mkdir netgen
    $ mkdir xschem
    $ cd xschem
    $ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
    $ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
    $ cd ../mag
    $ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
    $ cd ../netgen
    $ cp /usr/local/share/pdk/sky130A/libs.tech/netgen//sky130A_setup.tcl .
    ```
# Create Inverter and perform pre-layout using Xschem and NgSpice
# DC Analysis of Inverter
   An initial schematic of inverter is made by placing components from the open_pdk library in Xschem simulator.
   
   ![dc_cir](https://user-images.githubusercontent.com/114692581/218378837-26801fe0-65ac-4f4d-b6e8-7ba0a852c0a4.PNG)
   
## NgSpice plot

![dc](https://user-images.githubusercontent.com/114692581/218378945-9d42e95f-3a28-408b-ad94-d6e8a5e242da.PNG)

Threshold Voltage (Vth) = 838.1 mV  [Intersection point of Vin and Vout]
   
# Transient Analysis of Inverter
   
![11](https://user-images.githubusercontent.com/114692581/218123256-939d0aed-d8f4-46af-85f4-ff4a18fe59c3.PNG)
  
## Pre-layout Netlist for transient analysis
```
** sch_path: /home/swagatika/Desktop/Circuits/Inverter.sch
**.subckt Inverter Vout Vin Vin VDD GND GND GND VDD
*.opin Vout
*.ipin Vin
*.ipin Vin
*.iopin VDD
*.iopin GND
*.iopin GND
*.iopin GND
*.iopin VDD
XPMOS Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XNMOS Vout Vin GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
Vin Vin GND pulse(0 1.8 0.1ns 0.1ns 0.1ns 5ns 10ns)
.save i(vin)
VDD VDD GND 1.8
.save i(vdd)
**** begin user architecture code

.tran 0.01n 100n
.control
run
set color0=white
set color1=black
plot Vin+3 Vout+1
set xbrushwidth=3
.save all
.endc
.end

.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

**** end user architecture code
**.ends
.end
```
## NgSpice Plot

![22](https://user-images.githubusercontent.com/114692581/218123837-e16d1d9d-90c9-44bc-b78d-552054bd2f08.PNG)

## Make Symbol from Schematic and an independent testbench circuit to simulate
  - First, design an inverter without voltage source. The following is schematic of inverter with metal pins.

    ![33](https://user-images.githubusercontent.com/114692581/218243371-9491fd51-4497-4c44-871d-ca2cdb8fa657.PNG)

  - Then, go to Symbol and click on make symbol from schematic.

    ![44](https://user-images.githubusercontent.com/114692581/218243495-c33e37c1-66bd-42f9-9311-ae90ecaf1ca7.PNG)

  - To create a layout of this circuit but first, we need to functionally validate it and for that we need to create an independent testbench with the schematic as a symbol. 

    ![55](https://user-images.githubusercontent.com/114692581/218245773-095ba650-198a-4ce8-9f97-3ef22a0a551b.PNG)

**Transient analysis of testbench schematic**
  
  Rise time : 1ns
  Fall time : 1ns
  On time : 5ns
  Period : 10ns
* **Netlist of pre-layout testbench schematic**
```
** sch_path: /home/swagatika/Desktop/Circuits/Inverter_tb.sch
**.subckt Inverter_tb Vin Vout
*.ipin Vin
*.opin Vout
V1 Vin GND pulse(0 1.8 0ns 1ns 1ns 5ns 10ns)
.save i(v1)
VDD VDD GND 1.8
.save i(vdd)
x1 VDD Vout Vin GND Inverter_sym
**** begin user architecture code

.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

.tran 1n 30n
.control
run
set color0=white
set color1=black
plot Vin Vout
set xbrushwidth=3
.save all
.endc
.end

**** end user architecture code
**.ends

* expanding   symbol:  /home/swagatika/Desktop/Circuits/Inverter_sym.sym # of pins=4
** sym_path: /home/swagatika/Desktop/Circuits/Inverter_sym.sym
** sch_path: /home/swagatika/Desktop/Circuits/Inverter_sym.sch
.subckt Inverter_sym vdd OUT IN gnd
*.opin OUT
*.ipin IN
*.iopin vdd
*.iopin gnd
XPMOS OUT IN vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XNMOS OUT IN gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```
* **NgSpice Plot**

  ![66](https://user-images.githubusercontent.com/114692581/218246025-70524b2a-9349-4b5a-8a10-46d41fb9bf8e.PNG)
    
# Post-layout using Inverter Schematic in Magic VLSI tool
Create a working directory with `sky130A.tech`, `sky130.magicrc`, `sky130A.magicrc` files and use the following command in the same directory.
```
$ magic -d XR
```
**OR**
```
$ magic -T sky130A.tech
```
This command opens up the Toplevel magic layout window and `Tkcon.tcl` command window. Then, `Go to file --> Import SPICE` and select your generated netlist (Schematic of Inverter symbol which has metal pins, NFET and PFET) from the `.xschem` folder.

Once import the `.spice` file, an empty inverter cell will be visible with black bounding box. Move cursor over the cell and press `s`. Then press `x`. The four metal contacts and two fet cells will be visible as shown below.

![77L](https://user-images.githubusercontent.com/114692581/218332190-7adb1974-5026-449a-9681-b9ce52c0c623.PNG)

Save the `.mag` files in the same working directory. Navigate to `.mag` file using the terminal and rename the files to match the missing cell name displayed on the tkcon window. Reload the renamed `.mag` file in magic layout and expand the cell. NFET, PFET and the metal contacts will be visible. Place the cells and route the **metal1** layer such that the layout should be DRC free as shown below.

**Note:** For moving elements, `s` to select metal contacts, `i` to select cells and `m` to move the cell.

![88L](https://user-images.githubusercontent.com/114692581/218331996-8eb9c5ac-89ef-40ca-8273-92c4d5b670e4.PNG)

Now, `go to File --> save` and select autowrite. Then, go to the `Tkcon.tcl` command window and type the following.
```
extract do local
extract all
```
**Extract do local** is an instruction to perform all extractions to the local directory and **extract all** does the actual extraction. To be in the spice format for LVS check on testbench and layout netlist, run the following commands.
```
ext2spice lvs
ext2spice cthresh 0 rthresh 0
ext2spice
```
Now, we can close magic.
If we run an `ls` in same working directory we should see our `.ext` files, `.mag` files and also post layout `.spice` file for the inverter.

![99L](https://user-images.githubusercontent.com/114692581/218333348-354d7ee0-3f6c-4fc6-9726-21d1183115ee.PNG)

The generated post-layout inverter netlist extracts the interconnect parasitics, that were absent in pre-layout netlist.
```
* NGSPICE file created from Inverter_magic.ext - technology: sky130A

.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_15_n100# w_n211_n319# 0.06fF
C1 a_15_n100# a_n33_n197# 0.03fF
C2 a_15_n100# a_n73_n100# 0.16fF
C3 w_n211_n319# a_n33_n197# 0.26fF
C4 w_n211_n319# a_n73_n100# 0.09fF
C5 a_n73_n100# a_n33_n197# 0.03fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_n33_n188# a_n73_n100# 0.03fF
C1 a_n33_n188# a_15_n100# 0.03fF
C2 a_15_n100# a_n73_n100# 0.16fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

.subckt Inverter_magic vdd OUT IN gnd
XXPMOS vdd OUT XPMOS/w_n211_n319# IN VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXNMOS gnd IN OUT VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 OUT XPMOS/w_n211_n319# 0.08fF
C1 gnd OUT 0.01fF
C2 IN OUT 0.06fF
C3 OUT vdd 0.02fF
C4 IN XPMOS/w_n211_n319# 0.06fF
C5 XPMOS/w_n211_n319# vdd 0.15fF
C6 gnd IN 0.39fF
C7 IN vdd 0.39fF
C8 IN VSUBS 1.11fF
C9 gnd VSUBS 0.90fF
C10 OUT VSUBS 1.11fF
C11 vdd VSUBS 0.71fF
C12 XPMOS/w_n211_n319# VSUBS 1.09fF
.ends
```
## Post-layout Netlist of testbench inverter schematic for transient analysis
Selectively paste the pre-layout netlist of inverter testbench into the magic generated inverter spice netlist. The final post-layout netlist of inverter testbench is shown as following.
```
* NGSPICE file created from Inverter_magic.ext - technology: sky130A

.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_15_n100# w_n211_n319# 0.06fF
C1 a_15_n100# a_n33_n197# 0.03fF
C2 a_15_n100# a_n73_n100# 0.16fF
C3 w_n211_n319# a_n33_n197# 0.26fF
C4 w_n211_n319# a_n73_n100# 0.09fF
C5 a_n73_n100# a_n33_n197# 0.03fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_n33_n188# a_n73_n100# 0.03fF
C1 a_n33_n188# a_15_n100# 0.03fF
C2 a_15_n100# a_n73_n100# 0.16fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

V1 Vin GND pulse(0 1.8 0ns 1ns 1ns 5ns 10ns)
.save i(v1)
VDD VDD GND 1.8
.save i(vdd)
x1 VDD Vout Vin GND Inverter_magic
**** begin user architecture code

.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

.tran 1n 30n
.control
run
set color0=white
set color1=black
plot Vin Vout
set xbrushwidth=3
.save all
.endc

.subckt Inverter_magic vdd OUT IN gnd
XXPMOS vdd OUT XPMOS/w_n211_n319# IN VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXNMOS gnd IN OUT VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 OUT XPMOS/w_n211_n319# 0.08fF
C1 gnd OUT 0.01fF
C2 IN OUT 0.06fF
C3 OUT vdd 0.02fF
C4 IN XPMOS/w_n211_n319# 0.06fF
C5 XPMOS/w_n211_n319# vdd 0.15fF
C6 gnd IN 0.39fF
C7 IN vdd 0.39fF
C8 IN VSUBS 1.11fF
C9 gnd VSUBS 0.90fF
C10 OUT VSUBS 1.11fF
C11 vdd VSUBS 0.71fF
C12 XPMOS/w_n211_n319# VSUBS 1.09fF
.ends
.end
```
## NgSpice Plot

![PL_netlist](https://user-images.githubusercontent.com/114692581/218385930-e1c66f24-5b06-4a37-956c-c9fe2ce55069.PNG)













  
  









