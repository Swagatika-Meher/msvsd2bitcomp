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
A simple SPICE Netlist for ring oscillator is generated by modifying the pre-layout testbench netlist and saved in `.sp` format to generate `.lef` and `.gds` files.

Input netlist for ALIGN tool,
```
.subckt 1bitadc OUT Vdd INN INP Gnd

M1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M3 net3 INN net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n
M4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n
M5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
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
M1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M3 net3 INN net2 Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n
M5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
M6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n
M9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n
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

X0 m1_1430_1400# INN VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=1.1256e+12p ps=1.376e+07u w=420000u l=150000u
X1 VSUBS INN m1_1430_1400# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X3 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 OUT m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 VSUBS m1_398_1484# OUT VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 m1_398_1484# m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS m1_398_1484# m1_398_1484# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 li_405_1831# NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VSUBS NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# li_405_1831# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 m1_398_1484# m1_398_1484# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=1.9635e+12p ps=1.844e+07u w=1.05e+06u l=150000u
X11 VDD m1_398_1484# m1_398_1484# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 VDD m1_1430_1400# li_405_1831# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.94e+11p ps=2.66e+06u w=1.05e+06u l=150000u
X13 m1_1430_1400# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X14 VDD m1_1430_1400# m1_1430_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 li_405_1831# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 OUT li_405_1831# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X17 VDD li_405_1831# OUT VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 INN li_405_1831# 0.00fF
C1 li_405_1831# GND 0.08fF
C2 INN m1_1430_1400# 0.12fF
C3 INP m1_1430_1400# 0.00fF
C4 VDD OUT 0.88fF
C5 m1_398_1484# li_405_1831# 0.28fF
C6 m1_1430_1400# GND 0.15fF
C7 m1_398_1484# m1_1430_1400# 0.06fF
C8 li_405_1831# OUT 0.12fF
C9 m1_1430_1400# OUT 0.00fF
C10 li_405_1831# VDD 4.06fF
C11 m1_1430_1400# VDD 2.46fF
C12 INN INP 0.01fF
C13 INN GND 0.05fF
C14 m1_1430_1400# li_405_1831# 0.48fF
C15 INP GND 0.10fF
C16 li_405_1831# NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# 0.12fF
C17 INN m1_398_1484# 0.05fF
C18 m1_398_1484# INP 0.00fF
C19 m1_398_1484# GND 0.02fF
C20 INP OUT 0.00fF
C21 GND OUT 0.02fF
C22 INN VDD 0.00fF
C23 m1_398_1484# OUT 0.44fF
C24 VDD GND 0.27fF
C25 m1_398_1484# VDD 2.61fF
C26 OUT VSUBS 0.66fF **FLOATING
C27 VDD VSUBS 6.11fF **FLOATING
C28 NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# VSUBS 0.97fF **FLOATING
C29 m1_398_1484# VSUBS 3.31fF **FLOATING
C30 m1_1430_1400# VSUBS 0.61fF **FLOATING
C31 INN VSUBS 0.86fF **FLOATING
```
After exporting `.gds` file generated by Align to magic and extract '.spice' file, manually the `.control` statements are added and the postlayout (generated by ALIGN tool) compared with pre-layout testbench ring oscillator schematic.
```
* SPICE3 file created from 1BITADC_0.ext - technology: sky130A

.subckt 1_bit_ADC Vdd OUT INP INN Gnd
X0 m1_1430_1400# INN VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=1.1256e+12p ps=1.376e+07u w=420000u l=150000u
X1 VSUBS INN m1_1430_1400# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X3 VSUBS m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 OUT m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 VSUBS m1_398_1484# OUT VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 m1_398_1484# m1_398_1484# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS m1_398_1484# m1_398_1484# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 li_405_1831# NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VSUBS NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# li_405_1831# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 m1_398_1484# m1_398_1484# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=1.9635e+12p ps=1.844e+07u w=1.05e+06u l=150000u
X11 VDD m1_398_1484# m1_398_1484# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 VDD m1_1430_1400# li_405_1831# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.94e+11p ps=2.66e+06u w=1.05e+06u l=150000u
X13 m1_1430_1400# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X14 VDD m1_1430_1400# m1_1430_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 li_405_1831# m1_1430_1400# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 OUT li_405_1831# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.94e+11p pd=2.66e+06u as=0p ps=0u w=1.05e+06u l=150000u
X17 VDD li_405_1831# OUT VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 INN li_405_1831# 0.00fF
C1 li_405_1831# GND 0.08fF
C2 INN m1_1430_1400# 0.12fF
C3 INP m1_1430_1400# 0.00fF
C4 VDD OUT 0.88fF
C5 m1_398_1484# li_405_1831# 0.28fF
C6 m1_1430_1400# GND 0.15fF
C7 m1_398_1484# m1_1430_1400# 0.06fF
C8 li_405_1831# OUT 0.12fF
C9 m1_1430_1400# OUT 0.00fF
C10 li_405_1831# VDD 4.06fF
C11 m1_1430_1400# VDD 2.46fF
C12 INN INP 0.01fF
C13 INN GND 0.05fF
C14 m1_1430_1400# li_405_1831# 0.48fF
C15 INP GND 0.10fF
C16 li_405_1831# NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# 0.12fF
C17 INN m1_398_1484# 0.05fF
C18 m1_398_1484# INP 0.00fF
C19 m1_398_1484# GND 0.02fF
C20 INP OUT 0.00fF
C21 GND OUT 0.02fF
C22 INN VDD 0.00fF
C23 m1_398_1484# OUT 0.44fF
C24 VDD GND 0.27fF
C25 m1_398_1484# VDD 2.61fF
C26 OUT VSUBS 0.66fF 
**FLOATING
C27 VDD VSUBS 6.11fF 
**FLOATING
C28 NMOS_S_96839798_X1_Y1_1678939203_0/a_200_252# VSUBS 0.97fF 
**FLOATING
C29 m1_398_1484# VSUBS 3.31fF 
**FLOATING
C30 m1_1430_1400# VSUBS 0.61fF 
**FLOATING
C31 INN VSUBS 0.86fF 
**FLOATING
.ends


*========manually added==========
XM2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net3 INN net2 Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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

![Y7](https://user-images.githubusercontent.com/114692581/225523744-f9ac7bff-a936-4cb7-97e7-f7c46cdc0d4c.PNG)

# Comparison between Pre-layout and Post-layout testbench of 1-bit ADC schematic
| 1-bit ADC | Pre-layout [Xschem] | Post-layout [ALIGN] |
| --------- | ------------------- | ------------------- |
| Output | ![Y9](https://user-images.githubusercontent.com/114692581/225524968-d07f3c72-97cd-4d2e-b6c6-7071db4eb7cb.PNG) | ![Y8](https://user-images.githubusercontent.com/114692581/225524927-90a6c329-500d-4278-b978-30e1293044a7.PNG) |

It has been noticed that the post-layout simulation [using ALIGN] result is **same** as the pre-layout simulation result of 1-bit ADC. 
