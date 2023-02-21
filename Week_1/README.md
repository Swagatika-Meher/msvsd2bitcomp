* [Week 1](#Week-1)
  - [Inverter Post-layout characterization using ALIGN tool](#Inverter-Post-layout-characterization-using-ALIGN-tool)
    - [Generated .lef and .gds files in KLayout](#Generated-.lef-and-.gds-files-in-KLayout)
  - [Pre-layout simulation of a function using Xschem, NgSpice and sky130 PDKs](#Pre-layout-simulation-of-a-function-using-Xschem,-NgSpice-and-sky130-PDKs)
    - [Make Symbol from Schematic and an independent testbench circuit to simulate](#Make-Symbol-from-Schematic-and-an-independent-testbench-circuit-to-simulate)
  - [Post-layout using given function Schematic in Magic VLSI tool and sky130 PDKs](#Post-layout-using-given-function-Schematic-in-Magic-VLSI-tool-and-sky130-PDKs)
    - [Comparison between Pre-layout and Post-layout testbench of function schematic :](#Comparison-between-Pre-layout-and-Post-layout-testbench-of-function-schematic)
  - [Post-layout characterization of given function using ALIGN tool](#Post-layout-characterization-of-given-function-using-ALIGN-tool)
    - [Generated .lef and .gds files in KLayout](#Generated-.lef-and-.gds-files-in-KLayout)
    
    
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
.subckt Inverter vdd OUT IN gnd

XPMOS OUT IN vdd vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2 m=1
XNMOS OUT IN gnd gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
.ends Inverter
```

![AL1](https://user-images.githubusercontent.com/114692581/220003250-a22ae0f0-72db-4fc7-9a3f-7d8c7476eb97.PNG)

![AL2](https://user-images.githubusercontent.com/114692581/220003271-e09c7570-7918-4acf-89bf-b6bb9c6330ab.PNG)

## Generated .lef and .gds files in KLayout
* **.gds**
  
  ![AL3](https://user-images.githubusercontent.com/114692581/220005343-14d89aa9-326f-4172-8da9-b43b92993445.PNG)
  
* **.lef**
  
  ![AL4](https://user-images.githubusercontent.com/114692581/220005370-9aad1091-c8ab-46bd-8645-9389c645ecf5.PNG)
  

To extract the spice netlist of above post-layout go to MAGIC tool and read the .gds file.
Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![AL5](https://user-images.githubusercontent.com/114692581/219689580-306a729e-0dfb-4744-944d-cc0e319591a2.PNG)

Now, click `i` and go to `Tkcon.tcl` command window. Type the following command to extract the netlist.
```
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0 rthresh 0
ext2spice
```
* Align post layout spice file is created in work directory,
```
* NGSPICE file created from INVERTER_SYM_0.ext - technology: sky130A

.subckt PMOS_S_48783884_X1_Y1_1676643947_1676643947 a_200_252# w_0_0# a_230_525# VSUBS
X0 a_230_525# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=2.226e+11p ps=2.74e+06u w=420000u l=150000u
X1 w_0_0# a_200_252# a_230_525# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 a_200_252# a_230_525# 0.12fF
C1 w_0_0# a_230_525# 0.78fF
C2 a_200_252# w_0_0# 0.87fF
C3 a_230_525# VSUBS -0.05fF
C4 a_200_252# VSUBS 0.10fF
C5 w_0_0# VSUBS 2.97fF
.ends

.subckt NMOS_S_71820045_X1_Y1_1676643946_1676643947 a_147_504# a_200_252# a_230_504#
X0 a_230_504# a_200_252# a_147_504# a_147_504# sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=3.339e+11p ps=3.58e+06u w=630000u l=150000u
X1 a_147_504# a_200_252# a_230_504# a_147_504# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
C0 a_230_504# a_200_252# 0.11fF
C1 a_230_504# a_147_504# 0.73fF
C2 a_200_252# a_147_504# 0.93fF
.ends

.subckt INV_85967302_0_0_1676643947 m1_312_1400# VSUBS li_405_571#
XPMOS_S_48783884_X1_Y1_1676643947_1676643947_0 li_405_571# PMOS_S_48783884_X1_Y1_1676643947_1676643947_0/w_0_0#
+ m1_312_1400# VSUBS PMOS_S_48783884_X1_Y1_1676643947_1676643947
XNMOS_S_71820045_X1_Y1_1676643946_1676643947_0 VSUBS li_405_571# m1_312_1400# NMOS_S_71820045_X1_Y1_1676643946_1676643947
C0 PMOS_S_48783884_X1_Y1_1676643947_1676643947_0/w_0_0# li_405_571# 0.34fF
C1 li_405_571# m1_312_1400# 0.09fF
C2 PMOS_S_48783884_X1_Y1_1676643947_1676643947_0/w_0_0# m1_312_1400# 0.01fF
C3 m1_312_1400# VSUBS 0.68fF
C4 li_405_571# VSUBS 1.57fF
C5 PMOS_S_48783884_X1_Y1_1676643947_1676643947_0/w_0_0# VSUBS 3.02fF
.ends

.subckt INVERTER_SYM_0
XINV_85967302_0_0_1676643947_0 OUT GND IN INV_85967302_0_0_1676643947
C0 OUT GND 0.67fF
C1 IN GND 1.35fF
C2 INV_85967302_0_0_1676643947_0/PMOS_S_48783884_X1_Y1_1676643947_1676643947_0/w_0_0# GND 2.97fF
.ends
```
THIS IS NOT COMPLETED YET AS POST LAYOUT SIMULATIONS ARE NOT EXACTLY MATCHING. HAVE TO DEBUG AT EVERY TRANSISTOR AND IDENTFY WHERE IT IS FAILING.





# Pre-layout simulation of a function using Xschem, NgSpice and sky130 PDKs
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

# Post-layout using given function Schematic in Magic VLSI tool and sky130 PDKs
Open Magic VLSI tool using below command.
```
$ magic -d XR
```
OR
```
$ magic -T sky130A.tech
```
Once import the `.spice` file, an empty inverter cell will be visible with black bounding box. Move cursor over the cell and press `s`. Then press `x`. Save the `.mag` files in the same working directory. Navigate to `.mag` file using the terminal and rename the files to match the missing cell name displayed on the `tkcon` window. Reload the renamed `.mag` file in magic layout and expand the cell. NFET, PFET and the metal contacts will be visible. Place the cells and route the metal1 and metal2 layer such that the layout should be DRC free as shown below.

![AL12](https://user-images.githubusercontent.com/114692581/219744268-2553f31d-b60c-4594-86cf-3a7dc4068a52.PNG)

The above layout is designed using Euler's path. For the given function, the Euler's path is `A-C-E-F-D-B`. Here, the inputs are conneted in this manner. Vdd is given to A & B inputs of PMOS, while GND is given to B, D, F inputs of NMOS transistors. 
Now, `go to File --> save and select autowrite`. Then, go to the Tkcon.tcl command window and type the following.
```
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0 rthresh 0
ext2spice
```
Now, we can close magic.

The generated post-layout function netlist extracts the interconnect parasitics, that were absent in pre-layout netlist.
```
* NGSPICE file created from function_post.ext - technology: sky130A

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_n73_n100# a_n33_n188# 0.03fF
C1 a_15_n100# a_n73_n100# 0.16fF
C2 a_15_n100# a_n33_n188# 0.03fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_15_n100# a_n33_n197# 0.03fF
C1 a_n33_n197# w_n211_n319# 0.26fF
C2 a_n73_n100# a_n33_n197# 0.03fF
C3 a_15_n100# w_n211_n319# 0.06fF
C4 a_15_n100# a_n73_n100# 0.16fF
C5 a_n73_n100# w_n211_n319# 0.09fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt function_post VDD A B D C F E Fn Gnd
XXM12 m1_n4122_n2248# F Gnd VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM1 VDD m1_n6798_n26# XM1/w_n211_n319# A VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM2 m1_n638_22# VDD XM2/w_n211_n319# B VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM3 m1_n6798_n26# m1_n5500_n14# XM3/w_n211_n319# C VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM4 m1_n5500_n14# m1_n638_22# XM4/w_n211_n319# D VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM5 m1_n5500_n14# Fn XM5/w_n211_n319# E VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM6 Fn m1_n5500_n14# XM6/w_n211_n319# F VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM7 Fn A m1_n7132_n2270# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM9 Fn E m1_n4122_n2248# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM8 m1_n7132_n2270# C Fn VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM10 m1_n7132_n2270# B Gnd VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM11 Gnd D m1_n7132_n2270# VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 XM2/w_n211_n319# B 0.10fF
C1 XM6/w_n211_n319# D 0.00fF
C2 XM4/w_n211_n319# m1_n5500_n14# 0.07fF
C3 VDD C 0.01fF
C4 m1_n5500_n14# XM3/w_n211_n319# 0.08fF
C5 Fn m1_n7132_n2270# 0.10fF
C6 m1_n7132_n2270# F 0.00fF
C7 Fn E 0.29fF
C8 F E 0.01fF
C9 VDD XM5/w_n211_n319# 0.04fF
C10 XM1/w_n211_n319# A 0.12fF
C11 A Fn 0.17fF
C12 VDD m1_n5500_n14# 1.48fF
C13 C m1_n7132_n2270# 0.01fF
C14 C E 0.07fF
C15 XM1/w_n211_n319# m1_n6798_n26# 0.08fF
C16 Fn m1_n6798_n26# 0.00fF
C17 m1_n638_22# B 0.01fF
C18 VDD XM4/w_n211_n319# 0.03fF
C19 C A 0.07fF
C20 VDD XM3/w_n211_n319# 0.04fF
C21 XM5/w_n211_n319# E 0.10fF
C22 XM2/w_n211_n319# D 0.00fF
C23 C m1_n6798_n26# 0.01fF
C24 m1_n5500_n14# E 0.01fF
C25 XM6/w_n211_n319# Fn 0.09fF
C26 XM6/w_n211_n319# F 0.05fF
C27 A m1_n5500_n14# 0.00fF
C28 XM3/w_n211_n319# E 0.00fF
C29 m1_n5500_n14# m1_n6798_n26# 0.00fF
C30 A XM3/w_n211_n319# 0.00fF
C31 XM6/w_n211_n319# XM5/w_n211_n319# 0.01fF
C32 m1_n638_22# D 0.01fF
C33 Gnd m1_n7132_n2270# 0.83fF
C34 D F 0.01fF
C35 XM4/w_n211_n319# B 0.00fF
C36 XM3/w_n211_n319# m1_n6798_n26# 0.07fF
C37 VDD E 0.01fF
C38 XM6/w_n211_n319# m1_n5500_n14# 0.12fF
C39 VDD A 0.03fF
C40 m1_n638_22# XM2/w_n211_n319# 0.07fF
C41 XM6/w_n211_n319# XM4/w_n211_n319# 0.01fF
C42 Gnd B 0.02fF
C43 VDD m1_n6798_n26# 0.06fF
C44 VDD B 0.02fF
C45 m1_n7132_n2270# E 0.00fF
C46 Fn m1_n4122_n2248# 0.04fF
C47 F m1_n4122_n2248# 0.00fF
C48 A m1_n7132_n2270# 0.02fF
C49 m1_n5500_n14# D 0.01fF
C50 VDD XM6/w_n211_n319# 0.04fF
C51 C m1_n4122_n2248# 0.00fF
C52 XM4/w_n211_n319# D 0.10fF
C53 XM1/w_n211_n319# Fn 0.00fF
C54 m1_n7132_n2270# B 0.00fF
C55 m1_n6798_n26# E 0.00fF
C56 Fn F 0.04fF
C57 A m1_n6798_n26# 0.01fF
C58 XM4/w_n211_n319# XM2/w_n211_n319# 0.01fF
C59 XM1/w_n211_n319# C 0.00fF
C60 C Fn 0.20fF
C61 XM6/w_n211_n319# E 0.00fF
C62 Gnd D 0.02fF
C63 VDD D 0.01fF
C64 Fn XM5/w_n211_n319# 0.08fF
C65 XM5/w_n211_n319# F 0.00fF
C66 XM1/w_n211_n319# m1_n5500_n14# 0.00fF
C67 VDD XM2/w_n211_n319# 0.11fF
C68 m1_n638_22# m1_n5500_n14# 0.00fF
C69 m1_n5500_n14# Fn 0.07fF
C70 m1_n5500_n14# F 0.01fF
C71 C XM5/w_n211_n319# 0.00fF
C72 m1_n7132_n2270# D 0.01fF
C73 m1_n638_22# XM4/w_n211_n319# 0.07fF
C74 Gnd m1_n4122_n2248# 0.00fF
C75 XM4/w_n211_n319# F 0.00fF
C76 XM1/w_n211_n319# XM3/w_n211_n319# 0.01fF
C77 XM3/w_n211_n319# Fn 0.01fF
C78 C m1_n5500_n14# 0.01fF
C79 m1_n5500_n14# XM5/w_n211_n319# 0.09fF
C80 C XM3/w_n211_n319# 0.14fF
C81 D B 0.06fF
C82 Gnd F 0.01fF
C83 VDD XM1/w_n211_n319# 0.11fF
C84 VDD m1_n638_22# 0.08fF
C85 VDD Fn 0.08fF
C86 VDD F 0.01fF
C87 m1_n7132_n2270# m1_n4122_n2248# 0.00fF
C88 E m1_n4122_n2248# 0.00fF
C89 XM3/w_n211_n319# XM5/w_n211_n319# 0.01fF
C90 D VSUBS 1.06fF
C91 B VSUBS 1.06fF
C92 F VSUBS 1.13fF
C93 E VSUBS 1.00fF
C94 C VSUBS 0.91fF
C95 A VSUBS 1.12fF
C96 m1_n4122_n2248# VSUBS 0.66fF
C97 m1_n7132_n2270# VSUBS 2.52fF
C98 Fn VSUBS 3.63fF
C99 XM6/w_n211_n319# VSUBS 1.07fF
C100 XM5/w_n211_n319# VSUBS 1.07fF
C101 m1_n638_22# VSUBS -0.27fF
C102 XM4/w_n211_n319# VSUBS 1.07fF
C103 m1_n5500_n14# VSUBS 1.43fF
C104 XM3/w_n211_n319# VSUBS 1.07fF
C105 XM2/w_n211_n319# VSUBS 1.07fF
C106 m1_n6798_n26# VSUBS 0.00fF
C107 VDD VSUBS 0.53fF
C108 XM1/w_n211_n319# VSUBS 1.07fF
C109 Gnd VSUBS 2.79fF
.ends
```
**Post-layout Netlist of testbench function schematic :**

Selectively paste the pre-layout netlist of function testbench into the magic generated inverter spice netlist. The final post-layout netlist (Magic tool) of inverter testbench is shown as following.

```* NGSPICE file created from function_post.ext - technology: sky130A

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_n73_n100# a_n33_n188# 0.03fF
C1 a_15_n100# a_n73_n100# 0.16fF
C2 a_15_n100# a_n33_n188# 0.03fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_15_n100# a_n33_n197# 0.03fF
C1 a_n33_n197# w_n211_n319# 0.26fF
C2 a_n73_n100# a_n33_n197# 0.03fF
C3 a_15_n100# w_n211_n319# 0.06fF
C4 a_15_n100# a_n73_n100# 0.16fF
C5 a_n73_n100# w_n211_n319# 0.09fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt function_post VDD A B D C F E Fn Gnd
XXM12 m1_n4122_n2248# F Gnd VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM1 VDD m1_n6798_n26# XM1/w_n211_n319# A VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM2 m1_n638_22# VDD XM2/w_n211_n319# B VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM3 m1_n6798_n26# m1_n5500_n14# XM3/w_n211_n319# C VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM4 m1_n5500_n14# m1_n638_22# XM4/w_n211_n319# D VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM5 m1_n5500_n14# Fn XM5/w_n211_n319# E VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM6 Fn m1_n5500_n14# XM6/w_n211_n319# F VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM7 Fn A m1_n7132_n2270# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM9 Fn E m1_n4122_n2248# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM8 m1_n7132_n2270# C Fn VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM10 m1_n7132_n2270# B Gnd VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM11 Gnd D m1_n7132_n2270# VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 XM2/w_n211_n319# B 0.10fF
C1 XM6/w_n211_n319# D 0.00fF
C2 XM4/w_n211_n319# m1_n5500_n14# 0.07fF
C3 VDD C 0.01fF
C4 m1_n5500_n14# XM3/w_n211_n319# 0.08fF
C5 Fn m1_n7132_n2270# 0.10fF
C6 m1_n7132_n2270# F 0.00fF
C7 Fn E 0.29fF
C8 F E 0.01fF
C9 VDD XM5/w_n211_n319# 0.04fF
C10 XM1/w_n211_n319# A 0.12fF
C11 A Fn 0.17fF
C12 VDD m1_n5500_n14# 1.48fF
C13 C m1_n7132_n2270# 0.01fF
C14 C E 0.07fF
C15 XM1/w_n211_n319# m1_n6798_n26# 0.08fF
C16 Fn m1_n6798_n26# 0.00fF
C17 m1_n638_22# B 0.01fF
C18 VDD XM4/w_n211_n319# 0.03fF
C19 C A 0.07fF
C20 VDD XM3/w_n211_n319# 0.04fF
C21 XM5/w_n211_n319# E 0.10fF
C22 XM2/w_n211_n319# D 0.00fF
C23 C m1_n6798_n26# 0.01fF
C24 m1_n5500_n14# E 0.01fF
C25 XM6/w_n211_n319# Fn 0.09fF
C26 XM6/w_n211_n319# F 0.05fF
C27 A m1_n5500_n14# 0.00fF
C28 XM3/w_n211_n319# E 0.00fF
C29 m1_n5500_n14# m1_n6798_n26# 0.00fF
C30 A XM3/w_n211_n319# 0.00fF
C31 XM6/w_n211_n319# XM5/w_n211_n319# 0.01fF
C32 m1_n638_22# D 0.01fF
C33 Gnd m1_n7132_n2270# 0.83fF
C34 D F 0.01fF
C35 XM4/w_n211_n319# B 0.00fF
C36 XM3/w_n211_n319# m1_n6798_n26# 0.07fF
C37 VDD E 0.01fF
C38 XM6/w_n211_n319# m1_n5500_n14# 0.12fF
C39 VDD A 0.03fF
C40 m1_n638_22# XM2/w_n211_n319# 0.07fF
C41 XM6/w_n211_n319# XM4/w_n211_n319# 0.01fF
C42 Gnd B 0.02fF
C43 VDD m1_n6798_n26# 0.06fF
C44 VDD B 0.02fF
C45 m1_n7132_n2270# E 0.00fF
C46 Fn m1_n4122_n2248# 0.04fF
C47 F m1_n4122_n2248# 0.00fF
C48 A m1_n7132_n2270# 0.02fF
C49 m1_n5500_n14# D 0.01fF
C50 VDD XM6/w_n211_n319# 0.04fF
C51 C m1_n4122_n2248# 0.00fF
C52 XM4/w_n211_n319# D 0.10fF
C53 XM1/w_n211_n319# Fn 0.00fF
C54 m1_n7132_n2270# B 0.00fF
C55 m1_n6798_n26# E 0.00fF
C56 Fn F 0.04fF
C57 A m1_n6798_n26# 0.01fF
C58 XM4/w_n211_n319# XM2/w_n211_n319# 0.01fF
C59 XM1/w_n211_n319# C 0.00fF
C60 C Fn 0.20fF
C61 XM6/w_n211_n319# E 0.00fF
C62 Gnd D 0.02fF
C63 VDD D 0.01fF
C64 Fn XM5/w_n211_n319# 0.08fF
C65 XM5/w_n211_n319# F 0.00fF
C66 XM1/w_n211_n319# m1_n5500_n14# 0.00fF
C67 VDD XM2/w_n211_n319# 0.11fF
C68 m1_n638_22# m1_n5500_n14# 0.00fF
C69 m1_n5500_n14# Fn 0.07fF
C70 m1_n5500_n14# F 0.01fF
C71 C XM5/w_n211_n319# 0.00fF
C72 m1_n7132_n2270# D 0.01fF
C73 m1_n638_22# XM4/w_n211_n319# 0.07fF
C74 Gnd m1_n4122_n2248# 0.00fF
C75 XM4/w_n211_n319# F 0.00fF
C76 XM1/w_n211_n319# XM3/w_n211_n319# 0.01fF
C77 XM3/w_n211_n319# Fn 0.01fF
C78 C m1_n5500_n14# 0.01fF
C79 m1_n5500_n14# XM5/w_n211_n319# 0.09fF
C80 C XM3/w_n211_n319# 0.14fF
C81 D B 0.06fF
C82 Gnd F 0.01fF
C83 VDD XM1/w_n211_n319# 0.11fF
C84 VDD m1_n638_22# 0.08fF
C85 VDD Fn 0.08fF
C86 VDD F 0.01fF
C87 m1_n7132_n2270# m1_n4122_n2248# 0.00fF
C88 E m1_n4122_n2248# 0.00fF
C89 XM3/w_n211_n319# XM5/w_n211_n319# 0.01fF
C90 D VSUBS 1.06fF
C91 B VSUBS 1.06fF
C92 F VSUBS 1.13fF
C93 E VSUBS 1.00fF
C94 C VSUBS 0.91fF
C95 A VSUBS 1.12fF
C96 m1_n4122_n2248# VSUBS 0.66fF
C97 m1_n7132_n2270# VSUBS 2.52fF
C98 Fn VSUBS 3.63fF
C99 XM6/w_n211_n319# VSUBS 1.07fF
C100 XM5/w_n211_n319# VSUBS 1.07fF
C101 m1_n638_22# VSUBS -0.27fF
C102 XM4/w_n211_n319# VSUBS 1.07fF
C103 m1_n5500_n14# VSUBS 1.43fF
C104 XM3/w_n211_n319# VSUBS 1.07fF
C105 XM2/w_n211_n319# VSUBS 1.07fF
C106 m1_n6798_n26# VSUBS 0.00fF
C107 VDD VSUBS 0.53fF
C108 XM1/w_n211_n319# VSUBS 1.07fF
C109 Gnd VSUBS 2.79fF
.ends


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
x1 VDD A B D C F E Fn GND function_post
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
.GLOBAL GND
.end
```
Save the final post-layout magic netlist in the xschem directory and open the command window in the same directory. Type ngspice `<post-layout_file-name>.spice` in the command window.

![AL13](https://user-images.githubusercontent.com/114692581/219753040-1a9f3846-5d0b-45f6-a9cd-4b63b3980bb8.PNG)

**NgSpice Plot :**

![AL14](https://user-images.githubusercontent.com/114692581/219753668-373b8523-0724-44c1-826f-aca7de075041.PNG)

* **Comparison between Pre-layout and Post-layout testbench of function schematic :**

| Function | Pre-layout | Post-layout |
| -------- | ---------- | ----------- |
| Output [Fn] | ![AL15](https://user-images.githubusercontent.com/114692581/219757542-b727fba6-980b-46d7-acf4-f64cc116a057.PNG) | ![AL16](https://user-images.githubusercontent.com/114692581/219757731-f4809208-c9fe-4b14-8024-1a1d5e34ba97.PNG) |

# Post-layout characterization of given function using ALIGN tool
Go to ALIGN-public directory,
```
$ mkdir work
$ cd work
```
Running the function pre-layout spice netlist on Sky130pdk,
```
schematic2layout.py ../ALIGN-pdk-sky130/examples/function -p ../pdks/SKY130_PDK/
```
A simple SPICE Netlist for given function is written to generate .lef and .gds files,
```
** sch_path: /home/swagatika/Desktop/Circuits/function_pre_sym.sch
.subckt function_pre_sym A B C D E F Fn VDD Gnd
XM1 net3 A VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM2 net1 B VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM3 net2 C net3 net3 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM4 net2 D net1 net1 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM5 Fn E net2 net2 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM6 Fn F net2 net2 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=6 m=1
XM7 Fn A net4 net4 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
XM8 Fn C net4 net4 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
XM9 Fn E net5 net5 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
XM10 net4 B Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
XM11 net4 D Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
XM12 net5 F Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=6 m=1
**.ends
.end
```

![AL17](https://user-images.githubusercontent.com/114692581/219784961-621c7287-7fd6-436f-b8ae-4cfc9e1e047b.PNG)

![AL18](https://user-images.githubusercontent.com/114692581/219784978-c3006d87-6b5d-4eb0-8555-75db46a5697e.PNG)

## Generated .lef and .gds files in KLayout
* **.gds**
  
  ![AL19](https://user-images.githubusercontent.com/114692581/219785353-a681ed65-a3f5-4868-ad03-f90a1a1d4c11.PNG)
  
* **.lef**
  
  ![AL20](https://user-images.githubusercontent.com/114692581/219785406-0411dfa0-8448-46a6-88e1-560bffe014fd.PNG)

To extract the spice netlist of above post-layout go to MAGIC tool and read the .gds file.
Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![AL21](https://user-images.githubusercontent.com/114692581/219785732-cb30aeda-9005-46b7-8bb7-c2d3007b6ef6.PNG)


![AL22](https://user-images.githubusercontent.com/114692581/219785964-e36596bf-1da4-4ada-a696-479e38227777.PNG)

As we can see DRC=2 and also there are some cells, which are unable to read by magic. 






    

