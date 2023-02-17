* [Week 1](#Week-1)
  - [Inverter Post-layout characterization using ALIGN tool](#Inverter-Post-layout-characterization-using-ALIGN-tool)
    - [Generated .lef and .gds files in KLayout](#Generated-.lef-and-.gds-files-in-KLayout)
  - [Pre-layout simulation of a function using Xschem and NgSpice](#Pre-layout-simulation-of-a-function-using-Xschem-and-NgSpice)
    
    
# Inverter Post-layout characterization using ALIGN tool
Everytime start the ALIGN tool by running the following commands.
```
$ python3 -m venv general
$ source general/bin/activate
```
Then, go to ALIGN-public directory,
```
$ mkdir work
$ cd work
```
Running the inverter pre-layout spice netlist on Sky130pdk,
```
schematic2layout.py ../ALIGN-pdk-sky130/examples/Inverter -p ../pdks/SKY130_PDK/
```
A simple SPICE Netlist for inverter is written to generate .lef and .gds files,
```
.subckt Inverter_sym vdd OUT IN gnd

XPMOS OUT IN vdd vdd sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XNMOS OUT IN gnd gnd sky130_fd_pr__nfet_01v8 L=150n W=630n nf=2
.ends
.end
```

![AL1](https://user-images.githubusercontent.com/114692581/219681953-f12afe7f-9225-4fad-aa02-79ac3b1a9666.PNG)

![AL2](https://user-images.githubusercontent.com/114692581/219681985-03b70156-38d2-477a-8995-5468196b7505.PNG)


## Generated .lef and .gds files in KLayout
* **.gds**
  
  ![AL3](https://user-images.githubusercontent.com/114692581/219683181-61a574ed-74c1-4856-8236-c8b3e8fadf41.PNG)
  
* **.lef**
  
  ![AL4](https://user-images.githubusercontent.com/114692581/219683450-50499c01-f503-4be7-a3dd-5f3db415785d.PNG)
  

To extract the spice netlist of above post-layout go to MAGIC tool and read the .gds file.
Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![AL5](https://user-images.githubusercontent.com/114692581/219689580-306a729e-0dfb-4744-944d-cc0e319591a2.PNG)

Now, click `i` and go to `Tkcon.tcl` command window.












# Pre-layout simulation of a function using Xschem and NgSpice
Given, $\{F_n} = \overline {\left( {B + D} \right) \cdot \left( {A + C} \right) + E \cdot F} \$
An initial schematic of given function is made by placing components from the open_pdk library in Xschem simulator.

![AL6](https://user-images.githubusercontent.com/114692581/219730457-4158080e-1cb7-4da7-9d6d-95557cce1da7.PNG)

* **NgSpice Plot**

  ![AL7](https://user-images.githubusercontent.com/114692581/219732324-3a58d18f-90ba-43fb-82fa-2d2e33d41eea.PNG)
  
## Make Symbol from Schematic and an independent testbench circuit to simulate
The following is schematic of function with metal pins.

![AL8](https://user-images.githubusercontent.com/114692581/219733791-81de381c-997e-4f53-8859-4c8ec51ec44c.PNG)

Then, go to Symbol and click on make symbol from schematic. To create a layout of this circuit but first, we need to functionally validate it and for that we need to create an independent testbench with the schematic as a symbol.

![AL9](https://user-images.githubusercontent.com/114692581/219737128-d0b6255e-92a4-4e91-b217-8fb175ce0f05.PNG)

* **Netlist of pre-layout testbench schematic :**
```
** sch_path: /home/swagatika/Desktop/Circuits/function_pre_tb.sch
**.subckt function_pre_tb A B C D E F E F C D B A VDD VDD Fn
*.ipin A
*.ipin B
*.ipin C
*.ipin D
*.ipin E
*.ipin F
*.ipin E
*.ipin F
*.ipin C
*.ipin D
*.ipin B
*.ipin A
*.iopin VDD
*.iopin VDD
*.opin Fn
V1 A GND pulse(0 1.8 0ns 10ps 10ps 1ns 2ns)
.save i(v1)
V2 B GND pulse(0 1.8 0ns 10ps 10ps 2ns 4ns)
.save i(v2)
V3 C GND pulse(0 1.8 0ns 10ps 10ps 3ns 6ns)
.save i(v3)
V4 D GND pulse(0 1.8 0ns 10ps 10ps 4ns 8ns)
.save i(v4)
V5 E GND pulse(0 1.8 0ns 10ps 10ps 5ns 10ns)
.save i(v5)
V6 F GND pulse(0 1.8 0ns 10ps 10ps 6ns 12ns)
.save i(v6)
V7 VDD GND 1.8
.save i(v7)
x1 VDD A B D C F E Fn GND function_pre_sym
**** begin user architecture code

.tran 0.1n 24n
.control
run
plot A+30 B+25 C+20 D+15 E+10 F+5 Fn
.save all
.endc
.end


.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/swagatika/Desktop/Circuits/function_pre_sym.sym # of pins=9
** sym_path: /home/swagatika/Desktop/Circuits/function_pre_sym.sym
** sch_path: /home/swagatika/Desktop/Circuits/function_pre_sym.sch
.subckt function_pre_sym VDD A B D C F E Fn Gnd
*.ipin A
*.ipin B
*.ipin C
*.ipin D
*.ipin E
*.ipin F
*.opin Fn
*.iopin VDD
*.iopin Gnd
XM1 net3 A VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net1 B VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net2 C net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net2 D net1 net1 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 Fn E net2 net2 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 Fn F net2 net2 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 Fn A net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 Fn C net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 Fn E net5 net5 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 net4 B Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 net4 D Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 net5 F Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.end
```
* **NgSpice Plot :**

![AL10](https://user-images.githubusercontent.com/114692581/219740253-6e5c411d-d8a4-45b5-a62b-1757263ae5c8.PNG)

![AL11](https://user-images.githubusercontent.com/114692581/219740297-b4cfb1cb-a158-44a1-92e6-317070777e14.PNG)


    

