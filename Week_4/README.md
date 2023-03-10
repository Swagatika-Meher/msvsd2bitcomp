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
.subckt 1bitadc OUT Vdd IN1 IN2 Gnd

XM1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2 m=1
XM2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2 m=1
XM3 net3 IN1 net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
XM4 net1 IN2 net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
XM5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2 m=1
XM6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
XM7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
XM8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2 m=1
XM9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2 m=1
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
Currently I am getting the following error. This needs to be investigated.

![AA](https://user-images.githubusercontent.com/114692581/224280543-47d3d20d-acdf-433b-82e5-1c19cac3588a.PNG)

