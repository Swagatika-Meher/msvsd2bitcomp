# OpenRoad Installation
Run the below commands step-by-step.
```
$ cd
$ git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
$ cd OpenROAD
$ sudo ./etc/DependencyInstaller.sh
$ cd
$ git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
$ cd OpenROAD-flow-scripts
$ sudo ./build_openroad.sh –local
$ export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
$ export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```
# Installation of OpenFASOC
OpenFASoC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. Run the below commands. Before installing OpenFASoC, some dependendies including Magic, Netgen, Klayout, Yosys and Openroad must be installed. Follow this [link](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_0) for dependendies installation.
```
$ cd
$ git clone https://github.com/idea-fasoc/openfasoc
$ cd openfasoc
$ sudo ./dependencies.sh
```

