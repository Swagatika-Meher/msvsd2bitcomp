# INDEX
* [Week 4](#Week-4)
  * [Xschem: Pre-layout simulation for 1-bit Analog to Digital Converter](#Xschem-Pre-layout-simulation-for-1-bit-Analog-to-Digital-Converter)
    * Netlist of pre-layout testbench schematic
    * NgSpice plot
  * [ALIGN: Post-layout simulation for 1-bit ADC](#ALIGN-Post-layout-simulation-for-1-bit-ADC)
    * Generated .gds and .lef files in KLayout
    * Extracted Post-layout spice netlist
    * NgSpice Plot
  * [Comparison between Pre-layout and Post-layout testbench of 1-bit ADC schematic](#Comparison-between-Pre-layout-and-Post-layout-testbench-of-1-bit-ADC-schematic)
  * [Xschem: Pre-layout simulation of 1-bit Analog to Digital Converter with Ring Oscillator](#Xschem-Pre-layout-simulation-of-1-bit-Analog-to-Digital-Converter-with-Ring-Oscillator)
  * [Conclusion](#Conclusion)
  
# Xschem: Pre-layout simulation for 1-bit Analog to Digital Converter
A 1-bit ADC (analog-to-digital converter) is the simplest form of ADC. It works by comparing the analog input signal to a fixed reference voltage and producing a digital output that indicates whether the input signal is above or below the reference voltage.

The 1-bit ADC can be implemented using a comparator circuit. A comparator is an electronic circuit that compares two voltages and produces a binary output (0 or 1) depending on which voltage is higher.

In the case of a 1-bit ADC, the comparator compares the analog input signal with a fixed reference voltage. If the input voltage is greater than the reference voltage, the comparator outputs a logic "1". If the input voltage is less than the reference voltage, the comparator outputs a logic "0". This digital output represents the result of the analog-to-digital conversion.

The output of a 1-bit ADC is a single bit, which means it can only represent two possible states: high (1) or low (0). This limited resolution makes the 1-bit ADC unsuitable for many applications that require higher precision, but it can be useful in some cases where simplicity and low cost are more important than accuracy.

The following figure depicts 1-bit ADC using two stage CMOS OP-AMP technique in Xschem.

![001](https://user-images.githubusercontent.com/114692581/224245132-132912be-13cb-4354-9d6f-6f6f3bde3948.PNG)

1-bit ADC shown as a symbol in following figure.

![0000](https://user-images.githubusercontent.com/114692581/224245329-8bff0b3c-def3-487f-ad94-ac033ec75124.PNG)

![002](https://user-images.githubusercontent.com/114692581/224245493-b0969872-6a86-497b-a90d-f68db814d587.PNG)

1-bit ADC shown as a testbench schematic in following figure.

![003](https://user-images.githubusercontent.com/114692581/224246007-669653ba-a9fb-43d2-a3ee-e094f4d9cf9a.PNG)

**Netlist of pre-layout testbench schematic :**
```
** sch_path: /home/swagatika/Desktop/Circuits/1_bit_ADC_tb.sch
**.subckt 1_bit_ADC_tb Vdd IN2 IN1 Vdd IN1 IN2 OUT
*.iopin Vdd
*.iopin IN2
*.iopin IN1
*.iopin Vdd
*.iopin IN1
*.iopin IN2
*.iopin OUT
V2 Vdd GND 1.8
.save i(v2)
V3 IN2 GND sin(0.9 0.9 50Meg)
.save i(v3)
V1 IN1 GND 0.9
.save i(v1)
x1 Vdd OUT IN1 IN2 GND 1_bit_ADC_sym
**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all

.tran 0.1n 100n
.control
run
plot IN1+2 IN2+2 OUT
.save all
.endc
.end

**** end user architecture code
**.ends

* expanding   symbol:  /home/swagatika/Desktop/Circuits/1_bit_ADC_sym.sym # of pins=5
** sym_path: /home/swagatika/Desktop/Circuits/1_bit_ADC_sym.sym
** sch_path: /home/swagatika/Desktop/Circuits/1_bit_ADC_sym.sch
.subckt 1_bit_ADC_sym Vdd OUT IN1 IN2 Gnd
*.opin OUT
*.iopin Vdd
*.iopin IN1
*.iopin IN2
*.iopin Gnd
XM2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net3 IN1 net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 IN2 net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.end
```
After successfully running for 100ns with 0.1ns steps, the generated NgSpice plot shown below.

![004](https://user-images.githubusercontent.com/114692581/224246755-f7be927f-7ae3-4aff-96aa-4cd6caa0bed1.PNG)

![005](https://user-images.githubusercontent.com/114692581/224246801-a437e279-2e3f-4afa-b49e-f5ce6dfaa18b.PNG)

# ALIGN: Post-layout simulation for 1-bit ADC
A simple SPICE Netlist for 1 bit ADC is generated by modifying the pre-layout testbench netlist and saved in `.sp` format to generate `.lef` and `.gds` files.

Input netlist for ALIGN tool,
```
.subckt 1bitadc OUT Vdd INN INP Gnd

M1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M3 net3 INN net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
.ends 1bitadc
```
Run the ALIGN tool using below commands.
```
$ python3 -m venv general
$ source general/bin/activate
```
Go to ALIGN-public directory,
```
$ cd work
$ schematic2layout.py ../ALIGN-pdk-sky130/examples/1bitadc -p ../pdks/SKY130_PDK/
```
After running the above `.sp` file as input netlist to ALIGN tool, got the following error.

![AA](https://user-images.githubusercontent.com/114692581/224280543-47d3d20d-acdf-433b-82e5-1c19cac3588a.PNG)

This issue is arising when we connect bulk connections both in the NMOS transistors (M3 & M4) to either GND or the closest low voltage terminal. To solve this problem, we have to connect either one of the NMOS transistors (M3 & M4) to GND and other one to closest low voltage terminal as shown in the circuit below.

![Y1](https://user-images.githubusercontent.com/114692581/225518049-5a90e737-23ce-4559-8924-1216c3cc08cf.PNG)

Then, regenerate and modify the input netlist for ALIGN.
```
.subckt 1bitadc Vdd INN INP Gnd OUT
M1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M3 net3 INN net2 Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
.ends 1bitadc
```
Successfully generated `.gds` and `.lef` files.

![Y2](https://user-images.githubusercontent.com/114692581/225521188-ee5f925d-071e-44c6-bdc8-9c756c53dccc.PNG)

![Y3](https://user-images.githubusercontent.com/114692581/225521209-855053a2-8bd7-47a8-aa83-b773703da7e5.PNG)

## Generated .gds and .lef files in KLayout
* **.gds**

  ![Y4](https://user-images.githubusercontent.com/114692581/225521466-350ec40d-7b88-408a-b414-09ee3f97d5d2.PNG)
  
* **.lef**

  ![Y5](https://user-images.githubusercontent.com/114692581/225521527-da45ce60-0667-4f27-b8b5-3e170743467a.PNG)

To extract the spice netlist of above post-layout go to MAGIC tool and read the `.gds` file. Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![Y6](https://user-images.githubusercontent.com/114692581/225521772-4e22d1bf-f6c0-4add-8225-7fed1d89fafe.PNG)

Now, click `i` and go to `Tkcon.tcl` command window. Type the following command to extract the netlist.
```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
**Align post layout .spice file is created in magic working directory,**
```
* SPICE3 file created from 1BITADC_0.ext - technology: sky130A

X0 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.1256e+12p pd=1.376e+07u as=0p ps=0u w=420000u l=150000u
X1 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 OUT m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X3 VSUBS m1_398_1484# OUT VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 m1_398_1484# m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 VSUBS m1_398_1484# m1_398_1484# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 li_405_1831# NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# li_405_1831# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 m1_398_1484# m1_398_1484# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=1.9635e+12p ps=1.844e+07u w=1.05e+06u l=150000u
X9 VDD m1_398_1484# m1_398_1484# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 VDD m1_1430_1400# li_405_1831# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.94e+11p ps=2.66e+06u w=1.05e+06u l=150000u
X11 m1_1430_1400# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X12 VDD m1_1430_1400# m1_1430_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 li_405_1831# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 OUT li_405_1831# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X15 VDD li_405_1831# OUT VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 m1_1430_1400# INN VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X17 VSUBS INN m1_1430_1400# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 m1_398_1484# VDD 2.61fF
C1 m1_1430_1400# m1_398_1484# 0.06fF
C2 INP OUT 0.00fF
C3 m1_1430_1400# VDD 2.46fF
C4 INP INN 0.01fF
C5 OUT li_405_1831# 0.12fF
C6 GND OUT 0.02fF
C7 li_405_1831# INN 0.00fF
C8 GND INN 0.05fF
C9 m1_398_1484# OUT 0.44fF
C10 OUT VDD 0.88fF
C11 m1_398_1484# INN 0.05fF
C12 GND INP 0.10fF
C13 m1_1430_1400# OUT 0.00fF
C14 VDD INN 0.00fF
C15 m1_1430_1400# INN 0.12fF
C16 GND li_405_1831# 0.08fF
C17 INP m1_398_1484# 0.00fF
C18 m1_1430_1400# INP 0.00fF
C19 m1_398_1484# li_405_1831# 0.28fF
C20 GND m1_398_1484# 0.02fF
C21 VDD li_405_1831# 4.06fF
C22 GND VDD 0.27fF
C23 m1_1430_1400# li_405_1831# 0.48fF
C24 m1_1430_1400# GND 0.15fF
C25 NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# li_405_1831# 0.12fF
C26 m1_1430_1400# VSUBS 0.61fF **FLOATING
C27 INN VSUBS 0.86fF **FLOATING
C28 OUT VSUBS 0.66fF **FLOATING
C29 VDD VSUBS 6.11fF **FLOATING
C30 NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# VSUBS 0.97fF **FLOATING
C31 m1_398_1484# VSUBS 3.31fF **FLOATING
```
After exporting `.gds` file generated by Align to magic and extract '.spice' file, manually the `.control` statements are added and the postlayout (generated by ALIGN tool) compared with pre-layout testbench 1 bit ADC schematic.
```
* SPICE3 file created from 1BITADC_0.ext - technology: sky130A

.subckt 1_bit_ADC Vdd OUT INP INN Gnd
X0 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.1256e+12p pd=1.376e+07u as=0p ps=0u w=420000u l=150000u
X1 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 OUT m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X3 VSUBS m1_398_1484# OUT VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 m1_398_1484# m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 VSUBS m1_398_1484# m1_398_1484# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 li_405_1831# NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# li_405_1831# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 m1_398_1484# m1_398_1484# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=1.9635e+12p ps=1.844e+07u w=1.05e+06u l=150000u
X9 VDD m1_398_1484# m1_398_1484# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 VDD m1_1430_1400# li_405_1831# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.94e+11p ps=2.66e+06u w=1.05e+06u l=150000u
X11 m1_1430_1400# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X12 VDD m1_1430_1400# m1_1430_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 li_405_1831# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 OUT li_405_1831# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X15 VDD li_405_1831# OUT VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 m1_1430_1400# INN VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X17 VSUBS INN m1_1430_1400# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 m1_398_1484# VDD 2.61fF
C1 m1_1430_1400# m1_398_1484# 0.06fF
C2 INP OUT 0.00fF
C3 m1_1430_1400# VDD 2.46fF
C4 INP INN 0.01fF
C5 OUT li_405_1831# 0.12fF
C6 GND OUT 0.02fF
C7 li_405_1831# INN 0.00fF
C8 GND INN 0.05fF
C9 m1_398_1484# OUT 0.44fF
C10 OUT VDD 0.88fF
C11 m1_398_1484# INN 0.05fF
C12 GND INP 0.10fF
C13 m1_1430_1400# OUT 0.00fF
C14 VDD INN 0.00fF
C15 m1_1430_1400# INN 0.12fF
C16 GND li_405_1831# 0.08fF
C17 INP m1_398_1484# 0.00fF
C18 m1_1430_1400# INP 0.00fF
C19 m1_398_1484# li_405_1831# 0.28fF
C20 GND m1_398_1484# 0.02fF
C21 VDD li_405_1831# 4.06fF
C22 GND VDD 0.27fF
C23 m1_1430_1400# li_405_1831# 0.48fF
C24 m1_1430_1400# GND 0.15fF
C25 NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# li_405_1831# 0.12fF
C26 m1_1430_1400# VSUBS 0.61fF
C27 INN VSUBS 0.86fF
C28 OUT VSUBS 0.66fF
C29 VDD VSUBS 6.11fF
C30 NMOS_S_96839798_X1_Y1_1678951902_0/a_200_252# VSUBS 0.97fF
C31 m1_398_1484# VSUBS 3.31fF
.ends


*========manually added==========
V2 Vdd GND 1.8
.save i(v2)
V3 INP GND sin(0.9 0.9 50Meg)
.save i(v3)
V1 INN GND 0.9
.save i(v1)
x1 Vdd OUT INP INN GND 1_bit_ADC
**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all
.tran 0.1n 100n
.control
run
plot INN+2 INP+2 OUT
.save all
.endc
.GLOBAL GND
.end
**** end user architecture code
**.ends
```
**NgSpice Plot**

We can see the post-layout output is not same as pre-layout.

![AAAA1](https://user-images.githubusercontent.com/114692581/227124269-b1250679-92c9-4d94-9bb7-113b67c9d492.PNG)

As we can observe, in the post-layout extracted netlist **GND** and **INP** pins are not reflected properly. **GND** terminal is shown as **VSUBS**. So, a little modification has been done in the netlist to reflect proper terminal and to get correct output.

**Modified post layout spice netlist of 1 bit ADC :**

```
* SPICE3 file created from 1BITADC_0.ext - technology: sky130A

.subckt 1_bit_ADC Vdd OUT INP INN GND
X0 GND m1_398_1484# GND GND sky130_fd_pr__nfet_01v8 ad=1.1256e+12p pd=1.376e+07u as=0p ps=0u w=420000u l=150000u
X1 GND m1_398_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 OUT m1_398_1484# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X3 GND m1_398_1484# OUT GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 m1_398_1484# m1_398_1484# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 GND m1_398_1484# m1_398_1484# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 li_405_1831# INP GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 GND INP li_405_1831# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 m1_398_1484# m1_398_1484# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=1.9635e+12p ps=1.844e+07u w=1.05e+06u l=150000u
X9 VDD m1_398_1484# m1_398_1484# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 VDD m1_1430_1400# li_405_1831# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.94e+11p ps=2.66e+06u w=1.05e+06u l=150000u
X11 m1_1430_1400# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X12 VDD m1_1430_1400# m1_1430_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 li_405_1831# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 OUT li_405_1831# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X15 VDD li_405_1831# OUT VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 m1_1430_1400# INN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X17 GND INN m1_1430_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 m1_398_1484# VDD 2.61fF
C1 m1_1430_1400# m1_398_1484# 0.06fF
C2 INP OUT 0.00fF
C3 m1_1430_1400# VDD 2.46fF
C4 INP INN 0.01fF
C5 OUT li_405_1831# 0.12fF
C6 GND OUT 0.02fF
C7 li_405_1831# INN 0.00fF
C8 GND INN 0.05fF
C9 m1_398_1484# OUT 0.44fF
C10 OUT VDD 0.88fF
C11 m1_398_1484# INN 0.05fF
C12 GND INP 0.10fF
C13 m1_1430_1400# OUT 0.00fF
C14 VDD INN 0.00fF
C15 m1_1430_1400# INN 0.12fF
C16 GND li_405_1831# 0.08fF
C17 INP m1_398_1484# 0.00fF
C18 m1_1430_1400# INP 0.00fF
C19 m1_398_1484# li_405_1831# 0.28fF
C20 GND m1_398_1484# 0.02fF
C21 VDD li_405_1831# 4.06fF
C22 GND VDD 0.27fF
C23 m1_1430_1400# li_405_1831# 0.48fF
C24 m1_1430_1400# GND 0.15fF
C25 INP li_405_1831# 0.12fF
C26 m1_1430_1400# GND 0.61fF 
C27 INN GND 0.86fF
C28 OUT GND 0.66fF
C29 VDD GND 6.11fF
C30 INP GND 0.97fF
C31 m1_398_1484# GND 3.31fF
.ends

*========manually added==========
V2 Vdd GND 1.8
.save i(v2)
V3 INP GND sin(0.9 0.9 50Meg)
.save i(v3)
V1 INN GND 0.9
.save i(v1)
x1 Vdd OUT INP INN GND 1_bit_ADC
**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all
.tran 0.1n 100n
.control
run
plot INN+2 INP+2 OUT
.save all
.endc
.GLOBAL GND
.end

**** end user architecture code
**.ends
```

![Y7](https://user-images.githubusercontent.com/114692581/227126488-548c7e96-967e-4b97-a9db-08d80f74bee9.PNG)

# Comparison between Pre-layout and Post-layout testbench of 1-bit ADC schematic
| 1-bit ADC | Pre-layout [Xschem] | Post-layout [ALIGN] |
| --------- | ------------------- | ------------------- |
| Output | ![Y9](https://user-images.githubusercontent.com/114692581/225524968-d07f3c72-97cd-4d2e-b6c6-7071db4eb7cb.PNG) | ![Y8](https://user-images.githubusercontent.com/114692581/227127180-be090fe1-7b29-4737-9dc9-0cbf6d66dbf9.PNG) |


It has been noticed that the post-layout simulation [using ALIGN] result is **same** as the pre-layout simulation result of 1-bit ADC. Though because of capacitance parasitics in the post-layout simulation, it is observed that less voltage swing as compare to pre-layout simulation. 

# Xschem: Pre-layout simulation of 1-bit Analog to Digital Converter with Ring Oscillator
The following schematic depicts 1-bit ADC with analog input from [ring oscillator](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_3) in Xschem. Here, to non-inverting teminal analog input is applied from ring oscillator with amplitude 1.8V and to the inverting terminal, 0.9V of reference voltage(Vref) is given.

![Y10](https://user-images.githubusercontent.com/114692581/225542271-a7b778aa-a69f-45fa-a768-cc3dcfb07233.PNG)

**Netlist of pre-layout schematic**
```
** sch_path: /home/swagatika/Desktop/Circuits/RO_ADC_pre.sch
**.subckt RO_ADC_pre INP Vdd INN INP OUT INN Vdd Vdd
*.opin INP
*.iopin Vdd
*.iopin INN
*.iopin INP
*.opin OUT
*.iopin INN
*.iopin Vdd
*.iopin Vdd
XM1 net1 INP Vdd Vdd sky130_fd_pr__pfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 INP net2 Vdd Vdd sky130_fd_pr__pfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 INP GND GND sky130_fd_pr__nfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net2 net1 GND GND sky130_fd_pr__nfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 INP net2 GND GND sky130_fd_pr__nfet_01v8 L=1 W=16.8 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net3 net5 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net5 INN net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 net3 INP net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 net5 net5 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 OUT net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 OUT net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM13 net4 net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM14 net6 net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM15 net6 net6 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
V1 INN GND 0.9
.save i(v1)
V2 Vdd GND 1.8
.save i(v2)
**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all
.tran 0.1n 50n
.control
run
plot INN+2 INP+2 OUT
.save all
.endc
.end

**** end user architecture code
**.ends
.GLOBAL GND
.end
```
After successfully running for 50ns with 0.1ns steps, the generated NgSpice plot shown below.

![Y11](https://user-images.githubusercontent.com/114692581/225544052-93e82728-ac99-419c-a549-31cfb422d02a.PNG)

![Y12](https://user-images.githubusercontent.com/114692581/225544088-a5f0c3bd-aa55-4f0c-bfd3-e80b7aa1c481.PNG)

# Conclusion
For pre-layout simulations, XScheme and NgSpice tools have been used. For post layout simulation using ALIGN, first '.gds' and '.lef' has been created and observed in KLayout tool. Then, the post layout spice netlist has been extracted from GDS file using magic vlsi tool. Both the pre and post layouts are same but due to presence of paracitics in post layout, there are some delay in post layout waveforms.    
