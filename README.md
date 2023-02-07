# msvsd2bitcomp
# VSD Mixed Signal PD Research
# INDEX
* [Week 0 - Tools Installation](#Week-0---Tools-Installation)
# Week 0 - Tools Installation
## **Prerequisites**
* **Operating System** - Ubuntu 20.04
* GNU Make
* Python 3.6+ with PIP
> NOTE: Pre layout files may only be simulated using Windows 10. While Ubuntu can be used to run all of the project's files. Therefore, it is generally recommended to obtain Ubuntu for executing  this repository. Ubuntu can be set up in three different ways.
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
4. Magic
5. Open_pdk

* **NgSpice**
  - NgSpice is the open-source spice simulator for electric and electronic circuits.
  ```
  $ sudo apt-get update -y
  ```
  - Now, install ngspice using the command below:
  ```
  $ sudo apt-get install -y ngspice
  ```
  
