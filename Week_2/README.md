# Installation of OpenFASOC
OpenFASoC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. Run the below commands. Before installing OpenFASoC, some dependendies including Magic, Netgen, Klayout, Yosys and Openroad must be installed. Follow this [link](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_0) for Magic and Netgen installation.
## Installation of Yosys
Packages needed by Yosys.
```
$ sudo apt install -y clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
```
Installing Yosys
```
$ git clone https://github.com/YosysHQ/yosys.git
$ cd yosys
$ make
$ sudo make install
```

## OpenRoad Installation
Packages needed by OpenROAD
```
$ sudo apt install -y cmake qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libmng2 qt5-image-formats-plugins tcl-tclreadline \
    swig libboost-all-dev libeigen3-dev libspdlog-dev
```
Run the below commands step-by-step.
```
$ cd
$ git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
$ cd OpenROAD
$ sudo ./etc/DependencyInstaller.sh
$ sudo ./etc/DependencyInstaller.sh -run
$ sudo ./etc/DependencyInstaller.sh -dev
$ mkdir build
$ cd build
$ cmake ..
$ make
$ sudo make install

$ cd
$ git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
$ cd OpenROAD-flow-scripts
$ sudo ./build_openroad.sh –local
$ export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
$ export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```
**Verifying OpenROAD Installation**

The OpenROAD-flow-scripts repository has example designs, constraints and makefile flows.
```
$ cd 
$ cd OpenROAD-flow-scripts
$ cd flow
$ make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk
```
This builds the 'ibex' 32-bit RISC-V CPU core and the results end up here.
```
~/OpenROAD-flow-scripts/flow/results/sky130hd/ibex/base$
```
To see the results in OpenROAD’s GUI, type the below command.
```
make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk gui_final
```
![AL25](https://user-images.githubusercontent.com/114692581/221372828-5082cf48-11db-4a56-a8e1-d4d6e6543249.PNG)


## Installing Openfasoc
```
$ cd
$ git clone https://github.com/idea-fasoc/openfasoc
$ cd openfasoc
$ sudo ./dependencies.sh
```
**Run OpenFASoC Flow,**

Go to one of the generators with `cd openfasoc/generators/<generator_name>` and run `make` to list down all the generator specific targets.

![AL26](https://user-images.githubusercontent.com/114692581/221373898-cd6847e1-4e67-4d36-9417-de51f32335e7.PNG)

# OpenFASOC flow for Temperature Sensor Generation
  * To configure circuit specifications, modify the `test.json` specfile in the `openfasoc/generators/temp-sense-gen/` folder.
  * To run the default generator, `cd` into `openfasoc/generators/temp-sense-gen/` and execute the following commands.
First Initialised open_pdk root
```
$ export PDK_ROOT=/usr/local/share/pdk
$ make sky130hd_temp
```
The default circuit’s physical design generation can be divided into three parts:
1. Verilog generation
2. RTL-to-GDS flow (OpenROAD)
3. Post-layout verification (DRC and LVS)

**Verilog Generation**

To run verilog generation,
```
$ make sky130hd_temp_verilog
```
![AL27](https://user-images.githubusercontent.com/114692581/221375088-cbff0643-fcc7-4ecd-ab21-8d4acc9e2216.PNG)

**Synthesis**

The OpenROAD Flow starts with a flow configuration file config.mk, the chosen platform (sky130hd, for example) and the Verilog files are generated from the previous part.
```
$ export PDK_ROOT=/usr/local/share/pdk
$ make sky130hd_temp
```
If will get some OpenROAD path error, follow the below commands.
```
$ export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
$ export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
$ export PDK_ROOT=/usr/local/share/pdk
```
This commands are initialised OpenROAD along with open_pdks path. The systhesis verilog codes in `/openfasoc/openfasoc/generators/temp-sense-gen/flow/results/sky130hd/tempsense`.
    


