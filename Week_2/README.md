# Installation of OpenFASOC
OpenFASoC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. Run the below commands. Before installing OpenFASoC, some dependendies including Magic, Netgen, Klayout, Yosys and Openroad must be installed. Follow this [link](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_0) for Magic and Netgen installation.
## Installation of KLayout
Type the below command,
```
$ sudo apt install -y klayout
```

![AL29](https://user-images.githubusercontent.com/114692581/221417334-c2ecddd2-047b-4a8d-9584-509f89f5b4db.PNG)

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

![AL28](https://user-images.githubusercontent.com/114692581/221416969-d1ac345d-c349-42b2-8b08-35ac54557aa2.PNG)

## OpenRoad Installation
A design can be transformed from synthesized Verilog to a routed layout using the integrated chip physical design tool known as OpenROAD.
An outline of steps used to build a chip using OpenROAD is shown below.

1. Initialize floorplan - define the chip size and cell rows
2. Place pins (for designs without pads )
3. Place macro cells (RAMs, embedded macros)
4. Insert substrate tap cells
5. Insert power distribution network
6. Macro Placement of macro cells
7. Global placement of standard cells
8. Repair max slew, max capacitance, and max fanout violations and long wires
9. Clock tree synthesis
10. Optimize setup/hold timing
11. Insert fill cells
12. Global routing (route guides for detailed routing)
13. Antenna repair
14. Detailed routing
15. Parasitic extraction
16. Static timing analysis

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

# OpenFASoC: Temperature Sensor Generator
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

An overview of how the Temperature Sensor Generator (temp-sense-gen) works internally in OpenFASoC.

**Circuit**

Using the topology presented in this paper as a base, this generator develops a small mixed-signal temperature sensor. It is made up of an exponentially temperature-dependent ring oscillator whose frequency is determined by the voltage drop across a MOSFET that is operating in the subthreshold regime.

![AL30](https://user-images.githubusercontent.com/114692581/221419363-107074e9-053f-4966-8502-83d630096e51.PNG)

Two manually created standard cells are used in the circuit to physically implement the analog blocks:
1. HEADER cell, containing the transistors in subthreshold operation;
2. SLC cell, containing the Split-Control Level Converter.

The .gds and .lef files of HEADER and SLC cells are pre-created before the start of the Generator flow.
The layout of the HEADER cell is shown below,



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
    


