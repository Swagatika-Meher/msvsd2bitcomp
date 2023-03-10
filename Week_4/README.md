# Xschem: Pre-layout simulation for 1-bit Analog to Digital Converter
A 1-bit ADC (analog-to-digital converter) is the simplest form of ADC. It works by comparing the analog input signal to a fixed reference voltage and producing a digital output that indicates whether the input signal is above or below the reference voltage.

The 1-bit ADC can be implemented using a comparator circuit. A comparator is an electronic circuit that compares two voltages and produces a binary output (0 or 1) depending on which voltage is higher.

In the case of a 1-bit ADC, the comparator compares the analog input signal with a fixed reference voltage. If the input voltage is greater than the reference voltage, the comparator outputs a logic "1". If the input voltage is less than the reference voltage, the comparator outputs a logic "0". This digital output represents the result of the analog-to-digital conversion.

The output of a 1-bit ADC is a single bit, which means it can only represent two possible states: high (1) or low (0). This limited resolution makes the 1-bit ADC unsuitable for many applications that require higher precision, but it can be useful in some cases where simplicity and low cost are more important than accuracy.

The following figure depicts 1-bit ADC using two stage CMOS OP-AMP technique in Xschem.

![001](https://user-images.githubusercontent.com/114692581/224232409-24083ee0-eed0-45c2-b42f-e8efda5df53b.PNG)

1-bit ADC shown as a symbol in following figure.

![002](https://user-images.githubusercontent.com/114692581/224232587-0b7e31a2-94b4-422f-877c-90182d711075.PNG)

1-bit ADC shown as a testbench schematic in following figure.

![003](https://user-images.githubusercontent.com/114692581/224232790-7b831ab4-e343-416c-8e9e-3e11cba9dea7.PNG)

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
x1 Vdd OUT IN1 IN2 GND 1_bit_ADC_sym
V2 Vdd GND 1.8
.save i(v2)
V3 IN2 GND sin(0.9 0.9 50Meg)
.save i(v3)
V1 IN1 GND 0.9
.save i(v1)
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
XM1 Vdd net3 net3 Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM8 Gnd net4 net4 Gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 Vdd net4 net4 Vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.end
```
After successfully running for 100ns with 0.1ns steps, the generated NgSpice plot shown below.

![004](https://user-images.githubusercontent.com/114692581/224233986-1f9799a8-1bc0-4c5e-b505-bcfe5afdd1ab.PNG)

![005](https://user-images.githubusercontent.com/114692581/224234031-54381869-0b4e-496b-a748-948f5afcc80b.PNG)

