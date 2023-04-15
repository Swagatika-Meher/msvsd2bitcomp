# INDEX
* [Week 6](#Week-6)
  * [Xschem: Pre-layout simulation for 3-bit CMOS based TIQ comparator Flash ADC](#Xschem-Pre-layout-simulation-for-3-bit-CMOS-based-TIQ-comparator-Flash-ADC)
    * Netlist of pre-layout testbench schematic
    * NgSpice plot
  * [ALIGN: Post-layout simulation for 3-bit CMOS based TIQ comparator Flash ADC](#ALIGN-Post-layout-simulation-for-3-bit-CMOS-based-TIQ-comparator-Flash-ADC)
    * Generated .gds and .lef files in KLayout
    * Extracted Post-layout spice netlist
    * NgSpice Plot
  * [Comparison between Pre-layout and Post-layout testbench of 3-bit Flash ADC schematic](#Comparison-between-Pre-layout-and-Post-layout-testbench-of-3-bit-Flash-ADC-schematic)

# Xschem: Pre-layout simulation for 3-bit CMOS based TIQ comparator Flash ADC
## TIQ Comparator
In TIQ technique, it uses two cascaded CMOS inverters as a comparator. While the second inverter serves as a gain booster, the first inverter internally creates reference voltage (Vref). As we adjust the size of CMOS, the cascading inverters produce various switching/reference voltages internally which serves as reference voltages. The purpose of TIQ comparator is to transform an input voltage (Vin) toward logic '1' or '0' by estimating a reference voltage (Vref) with the Vin. If Vin is greater than Vref, the comparator output is '1', otherwise '0'. This occurs when transistor width is altered while keeping the transistor length constant. The gain boosters create sharper thresholds for comparator outputs and offer a complete digital output voltage swing.

Two inverters are linked in series on the TIQ Comparator for comparing and balancing. The threshold voltage of the inverter circuits can be modified to provide different reference voltages by adjusting the width of PMOS and NMOS transistors. In analog section of 3-bit ADC, $\[{2^n} - 1\]$ comparators that is, 7 TIQ comparators are connected parallelly using CMOS inverters. Where, n is the number of output binary bits.

![A1](https://user-images.githubusercontent.com/114692581/230714036-7e7da415-ba3c-4c46-ae73-f4011a76e487.PNG)

**Testbench Schematic :**

Here, each TIQ comparator schematic is converted into seven symbols in xschem.

![A2](https://user-images.githubusercontent.com/114692581/230714753-a46883fa-2308-4ff6-9dec-bf66a114b642.PNG)

**Netlist of pre-layout testbench schematic :**

```
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_tb.sch
**.subckt flash_adc_tb VDD GND VIN GND VIN VIN VIN VIN VIN VIN VIN VDD VDD VDD VDD VDD VDD VDD GND
*+ GND GND GND GND GND TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7 GND
*.iopin VDD
*.iopin GND
*.iopin VIN
*.iopin GND
*.iopin VIN
*.iopin VIN
*.iopin VIN
*.iopin VIN
*.iopin VIN
*.iopin VIN
*.iopin VIN
*.iopin VDD
*.iopin VDD
*.iopin VDD
*.iopin VDD
*.iopin VDD
*.iopin VDD
*.iopin VDD
*.iopin GND
*.iopin GND
*.iopin GND
*.iopin GND
*.iopin GND
*.iopin GND
*.iopin TIQ_1
*.iopin TIQ_2
*.iopin TIQ_3
*.iopin TIQ_4
*.iopin TIQ_5
*.iopin TIQ_6
*.iopin TIQ_7
*.iopin GND
V1 VDD GND 1.8
.save i(v1)
V2 VIN GND sin(0 2 20Meg)
.save i(v2)
x1 VIN GND VDD TIQ_1 flash_adc_sym_1
x2 VIN GND VDD TIQ_2 flash_adc_sym_2
x3 VIN GND VDD TIQ_3 flash_adc_sym_3
x4 VIN GND VDD TIQ_4 flash_adc_sym_4
x5 VIN GND VDD TIQ_5 flash_adc_sym_5
x6 VIN GND VDD TIQ_6 flash_adc_sym_6
x7 VIN GND VDD TIQ_7 flash_adc_sym_7
**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all

.tran 0.01n 15n
.control
run
plot VIN VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7
.save all
.endc
.end


**** end user architecture code
**.ends

* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_1.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_1.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_1.sch
.subckt flash_adc_sym_1 VIN GND VDD TIQ_1
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_1
XM1 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2.52 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 TIQ_1 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 TIQ_1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2.52 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_3.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_3.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_3.sch
.subckt flash_adc_sym_3 VIN GND VDD TIQ_3
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_3
XM9 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.84 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1.68 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 TIQ_3 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.84 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 TIQ_3 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1.68 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_4.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_4.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_4.sch
.subckt flash_adc_sym_4 VIN GND VDD TIQ_4
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_4
XM13 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1.68 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM14 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.84 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM15 TIQ_4 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1.68 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM16 TIQ_4 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.84 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_5.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_5.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_5.sch
.subckt flash_adc_sym_5 VIN GND VDD TIQ_5
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_5
XM17 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2.52 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM18 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM19 TIQ_5 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2.52 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM20 TIQ_5 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_6.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_6.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_6.sch
.subckt flash_adc_sym_6 VIN GND VDD TIQ_6
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_6
XM21 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.63 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM22 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM23 TIQ_6 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.63 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM24 TIQ_6 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_7.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_7.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_7.sch
.subckt flash_adc_sym_7 VIN GND VDD TIQ_7
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_7
XM25 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM26 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM27 TIQ_7 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM28 TIQ_7 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends


* expanding   symbol:  /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_2.sym # of
*+ pins=4
** sym_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_2.sym
** sch_path: /home/swagatika/Desktop/Circuits/3bitFLASH_ADC_TIQ/flash_adc_sym_2.sch
.subckt flash_adc_sym_2 VIN GND VDD TIQ_2
*.iopin GND
*.iopin VDD
*.iopin VIN
*.iopin TIQ_2
XM5 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1.26 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 TIQ_2 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 TIQ_2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1.26 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends
.end
```
**NgSpice Plot :**

![A3](https://user-images.githubusercontent.com/114692581/230714834-3fe74bdb-7040-4a4d-9e77-2a45ce9b8837.PNG)

# ALIGN: Post-layout simulation for 3-bit CMOS based TIQ comparator Flash ADC
A simple SPICE Netlist for 3 bit Flash ADC is generated by modifying the pre-layout testbench netlist and saved in `.sp` format to generate `.lef` and `.gds` files.

Input netlist for ALIGN tool,

```
.subckt flash_adc_tb VIN GND VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7

XM1 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM2 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=2520n nf=4
XM3 TIQ_1 net1 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM4 TIQ_1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=2520n nf=4
XM5 net2 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM6 net2 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1260n nf=4
XM7 TIQ_2 net2 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM8 TIQ_2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1260n nf=4
XM9 net3 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=4
XM10 net3 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1680n nf=4
XM11 TIQ_3 net3 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=4
XM12 TIQ_3 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1680n nf=4
XM13 net4 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=1680n nf=4
XM14 net4 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=4
XM15 TIQ_4 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1680n nf=4
XM16 TIQ_4 net4 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=4
XM17 net5 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=2520n nf=4
XM18 net5 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
XM19 TIQ_5 net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=2520n nf=4
XM20 TIQ_5 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
XM21 net6 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=630n nf=4
XM22 net6 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
XM23 TIQ_6 net6 GND GND sky130_fd_pr__nfet_01v8 L=150n W=630n nf=4
XM24 TIQ_6 net6 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
XM25 net7 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM26 net7 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
XM27 TIQ_7 net7 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=4
XM28 TIQ_7 net7 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=4
.ends flash_adc_tb
```
Run the ALIGN tool using below commands.
```
$ python3 -m venv general
$ source general/bin/activate
```
Go to ALIGN-public directory,
```
$ cd work
$ schematic2layout.py ../ALIGN-pdk-sky130/examples/flash_adc_align -p ../pdks/SKY130_PDK/
```
Successfully generated `.gds` and `.lef` files.

![Y1](https://user-images.githubusercontent.com/114692581/232181426-7cbb2847-6621-496f-9288-7bd8d3f1d658.PNG)

## Generated .gds and .lef files in KLayout

**.gds**

![Y2](https://user-images.githubusercontent.com/114692581/232181499-cce419ac-7a52-46a5-8aea-d17310f743a0.PNG)

**.lef**

![Y3](https://user-images.githubusercontent.com/114692581/232181512-1e3dbd42-4876-4a83-a62c-5392142215c7.PNG)

To extract the spice netlist of above post-layout go to MAGIC tool and read the `.gds` file. Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![Y4](https://user-images.githubusercontent.com/114692581/232181749-ac06a01b-6bda-4a8f-972e-bff2e0add0fc.PNG)

Now, click `i` and go to `Tkcon.tcl` command window. Type the following command to extract the netlist.
```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

**Align post layout .spice file is created in magic working directory,**

```
* SPICE3 file created from FLASH_ADC_TB_0.ext - technology: sky130A

X0 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=1.12266e+13p ps=1.0584e+08u w=420000u l=150000u
X1 GND STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X3 GND STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X5 GND VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X7 GND VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 VDD VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=1.22472e+13p pd=1.134e+08u as=1.4112e+12p ps=1.12e+07u w=2.52e+06u l=150000u
X9 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X10 VDD VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X11 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X12 VDD STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.4112e+12p ps=1.12e+07u w=2.52e+06u l=150000u
X13 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X14 VDD STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X15 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X16 VDD STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X17 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X18 VDD STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X19 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X20 VDD VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X21 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X22 VDD VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X23 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X24 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.4112e+12p pd=1.12e+07u as=0p ps=0u w=2.52e+06u l=150000u
X25 GND STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X26 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X27 GND STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X28 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.4112e+12p pd=1.12e+07u as=0p ps=0u w=2.52e+06u l=150000u
X29 GND VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X30 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X31 GND VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X32 VDD VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X33 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X34 VDD VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X35 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X36 VDD STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X37 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X38 VDD STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X39 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X40 GND STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=4.704e+11p ps=4.48e+06u w=840000u l=150000u
X41 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X42 GND STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X43 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X44 GND VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=4.704e+11p ps=4.48e+06u w=840000u l=150000u
X45 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X46 GND VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X47 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X48 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=4.48e+06u as=0p ps=0u w=840000u l=150000u
X49 VDD STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X50 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X51 VDD STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X52 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=4.48e+06u as=0p ps=0u w=840000u l=150000u
X53 VDD VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X54 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X55 VDD VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X56 GND STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X57 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X58 GND STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X59 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X60 GND VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X61 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X62 GND VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X63 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X64 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=3.528e+11p pd=3.64e+06u as=0p ps=0u w=630000u l=150000u
X65 GND STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X66 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X67 GND STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X68 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=3.528e+11p pd=3.64e+06u as=0p ps=0u w=630000u l=150000u
X69 GND VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X70 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X71 GND VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X72 VDD STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X73 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X74 VDD STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X75 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X76 VDD VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X77 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X78 VDD VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X79 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X80 VDD STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X81 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X82 VDD STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X83 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X84 VDD VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X85 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X86 VDD VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X87 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X88 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X89 GND VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X90 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X91 GND VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X92 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X93 GND STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X94 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X95 GND STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X96 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=7.056e+11p ps=6.16e+06u w=1.26e+06u l=150000u
X97 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X98 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X99 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X100 VDD VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=7.056e+11p ps=6.16e+06u w=1.26e+06u l=150000u
X101 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X102 VDD VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X103 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X104 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X105 GND STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X106 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X107 GND STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X108 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X109 GND VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X110 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X111 GND VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 TIQ_6 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.00fF
C1 TIQ_7 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.00fF
C2 TIQ_7 VIN 0.01fF
C3 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# 0.51fF
C4 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN 0.87fF
C5 TIQ_5 VDD 1.64fF
C6 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.51fF
C7 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD 5.19fF
C8 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# 0.01fF
C9 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# VIN 0.01fF
C10 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_2 0.00fF
C11 TIQ_6 TIQ_7 0.00fF
C12 VDD STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# 1.56fF
C13 VDD VIN 21.38fF
C14 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C15 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD 4.14fF
C16 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 4.58fF
C17 TIQ_3 VDD 1.61fF
C18 TIQ_2 VIN 0.01fF
C19 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.48fF
C20 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD 4.50fF
C21 TIQ_1 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.00fF
C22 TIQ_6 VDD 0.12fF
C23 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# VDD 1.57fF
C24 TIQ_4 TIQ_5 0.00fF
C25 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD 4.14fF
C26 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_1 0.01fF
C27 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_5 0.01fF
C28 TIQ_4 VIN 0.07fF
C29 TIQ_7 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# 0.01fF
C30 TIQ_4 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# 0.01fF
C31 TIQ_4 TIQ_3 0.00fF
C32 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN 1.60fF
C33 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# 0.01fF
C34 TIQ_7 VDD 1.76fF
C35 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_3 0.00fF
C36 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C37 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD 4.63fF
C38 TIQ_4 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# 0.00fF
C39 TIQ_7 TIQ_1 0.00fF
C40 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# VDD 1.56fF
C41 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# 0.01fF
C42 TIQ_2 VDD 1.63fF
C43 TIQ_5 VIN 0.05fF
C44 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN 0.85fF
C45 TIQ_1 VDD 0.42fF
C46 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.02fF
C47 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# VIN 0.01fF
C48 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C49 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN 0.84fF
C50 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN 0.88fF
C51 TIQ_3 VIN 0.00fF
C52 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 0.45fF
C53 TIQ_4 VDD 0.06fF
C54 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN 0.97fF
C55 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.46fF
C56 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 0.45fF
C57 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.00fF
C58 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# 0.46fF
C59 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD 3.96fF
C60 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# VIN 0.01fF
C61 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN 1.54fF
C62 TIQ_6 GND 0.16fF
C63 TIQ_4 GND 0.15fF
C64 TIQ_1 GND 0.05fF
C65 TIQ_2 GND 1.46fF **FLOATING
C66 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND 2.13fF **FLOATING
C67 TIQ_7 GND 1.46fF **FLOATING
C68 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND 2.74fF **FLOATING
C69 STAGE2_INV_99975026_PG0_0_0_1681530360_0/m1_312_1400# GND 1.26fF **FLOATING
C70 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND 2.56fF **FLOATING
C71 STAGE2_INV_35754050_PG0_0_0_1681530356_0/m1_312_1400# GND 1.30fF **FLOATING
C72 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND 1.82fF **FLOATING
C73 TIQ_3 GND 1.49fF **FLOATING
C74 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND 2.04fF **FLOATING
C75 VIN GND 7.57fF **FLOATING
C76 VDD GND 56.61fF **FLOATING
C77 TIQ_5 GND 1.38fF **FLOATING
C78 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND 1.58fF **FLOATING
C79 STAGE2_INV_50758951_PG0_0_0_1681530357_0/m1_312_1400# GND 1.32fF **FLOATING
C80 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND 1.56fF **FLOATING
```
If we can see carefully, in the above netlist 'TIQ_1', 'TIQ_4' and 'TIQ_6' pins were not reflected in FETs instances. So, manually added these two pins to get the correct plots.

After exporting `.gds` file generated by Align to magic and extract '.spice' file, manually the `.control` statements are added and the postlayout (generated by ALIGN tool) compared with pre-layout testbench schematic.
```
* SPICE3 file created from FLASH_ADC_TB_0.ext - technology: sky130A

.subckt flash_adc_tb VIN GND VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7
X0 TIQ_1 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=1.12266e+13p ps=1.0584e+08u w=420000u l=150000u
X1 GND STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_1 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 TIQ_1 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X3 GND STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_1 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X5 GND VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X7 GND VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 VDD VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=1.22472e+13p pd=1.134e+08u as=1.4112e+12p ps=1.12e+07u w=2.52e+06u l=150000u
X9 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X10 VDD VIN STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X11 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X12 VDD STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.4112e+12p ps=1.12e+07u w=2.52e+06u l=150000u
X13 TIQ_1 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X14 VDD STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X15 TIQ_1 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X16 VDD STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X17 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X18 VDD STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X19 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X20 VDD VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X21 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X22 VDD VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X23 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X24 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.4112e+12p pd=1.12e+07u as=0p ps=0u w=2.52e+06u l=150000u
X25 GND STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X26 TIQ_5 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X27 GND STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X28 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.4112e+12p pd=1.12e+07u as=0p ps=0u w=2.52e+06u l=150000u
X29 GND VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X30 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X31 GND VIN STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X32 VDD VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X33 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X34 VDD VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X35 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X36 VDD STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X37 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X38 VDD STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X39 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X40 GND STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=4.704e+11p ps=4.48e+06u w=840000u l=150000u
X41 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X42 GND STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X43 TIQ_3 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X44 GND VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=4.704e+11p ps=4.48e+06u w=840000u l=150000u
X45 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X46 GND VIN STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X47 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X48 TIQ_4 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=4.48e+06u as=0p ps=0u w=840000u l=150000u
X49 VDD STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X50 TIQ_4 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X51 VDD STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X52 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=4.48e+06u as=0p ps=0u w=840000u l=150000u
X53 VDD VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X54 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X55 VDD VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X56 GND STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_4 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X57 TIQ_4 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X58 GND STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_4 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X59 TIQ_4 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X60 GND VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=9.408e+11p ps=7.84e+06u w=1.68e+06u l=150000u
X61 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X62 GND VIN STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X63 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X64 TIQ_6 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=3.528e+11p pd=3.64e+06u as=0p ps=0u w=630000u l=150000u
X65 GND STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# TIQ_6 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X66 TIQ_6 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X67 GND STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# TIQ_6 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X68 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=3.528e+11p pd=3.64e+06u as=0p ps=0u w=630000u l=150000u
X69 GND VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X70 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X71 GND VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X72 VDD STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# TIQ_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X73 TIQ_6 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X74 VDD STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# TIQ_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X75 TIQ_6 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X76 VDD VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X77 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X78 VDD VIN STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X79 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X80 VDD STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X81 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X82 VDD STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X83 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X84 VDD VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.8e+06u w=420000u l=150000u
X85 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X86 VDD VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X87 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X88 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X89 GND VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X90 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X91 GND VIN STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X92 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X93 GND STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X94 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X95 GND STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X96 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=7.056e+11p ps=6.16e+06u w=1.26e+06u l=150000u
X97 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X98 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X99 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X100 VDD VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=7.056e+11p ps=6.16e+06u w=1.26e+06u l=150000u
X101 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X102 VDD VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X103 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X104 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X105 GND STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X106 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X107 GND STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X108 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.8e+06u as=0p ps=0u w=420000u l=150000u
X109 GND VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X110 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X111 GND VIN STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 TIQ_6 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.00fF
C1 TIQ_7 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.00fF
C2 TIQ_7 VIN 0.01fF
C3 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# TIQ_6 0.51fF
C4 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VIN 0.87fF
C5 TIQ_5 VDD 1.64fF
C6 TIQ_7 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.51fF
C7 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VDD 5.19fF
C8 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# 0.01fF
C9 TIQ_4 VIN 0.01fF
C10 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# TIQ_2 0.00fF
C11 TIQ_6 TIQ_7 0.00fF
C12 VDD TIQ_6 1.56fF
C13 VDD VIN 21.38fF
C14 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C15 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VDD 4.14fF
C16 VDD STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 4.58fF
C17 TIQ_3 VDD 1.61fF
C18 TIQ_2 VIN 0.01fF
C19 TIQ_2 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.48fF
C20 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VDD 4.50fF
C21 TIQ_1 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.00fF
C22 TIQ_6 VDD 0.12fF
C23 TIQ_1 VDD 1.57fF
C24 TIQ_4 TIQ_5 0.00fF
C25 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VDD 4.14fF
C26 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# TIQ_1 0.01fF
C27 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_5 0.01fF
C28 TIQ_4 VIN 0.07fF
C29 TIQ_7 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# 0.01fF
C30 TIQ_4 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# 0.01fF
C31 TIQ_4 TIQ_3 0.00fF
C32 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VIN 1.60fF
C33 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# 0.01fF
C34 TIQ_7 VDD 1.76fF
C35 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_3 0.00fF
C36 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C37 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# VDD 4.63fF
C38 TIQ_4 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# 0.00fF
C39 TIQ_7 TIQ_1 0.00fF
C40 TIQ_4 VDD 1.56fF
C41 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# 0.01fF
C42 TIQ_2 VDD 1.63fF
C43 TIQ_5 VIN 0.05fF
C44 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# VIN 0.85fF
C45 TIQ_1 VDD 0.42fF
C46 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# 0.02fF
C47 TIQ_6 VIN 0.01fF
C48 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# 0.01fF
C49 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# VIN 0.84fF
C50 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# VIN 0.88fF
C51 TIQ_3 VIN 0.00fF
C52 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# TIQ_3 0.45fF
C53 TIQ_4 VDD 0.06fF
C54 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# VIN 0.97fF
C55 TIQ_1 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.46fF
C56 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# TIQ_5 0.45fF
C57 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# 0.00fF
C58 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# TIQ_4 0.46fF
C59 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# VDD 3.96fF
C60 TIQ_1 VIN 0.01fF
C61 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# VIN 1.54fF
C62 TIQ_6 GND 0.16fF
C63 TIQ_4 GND 0.15fF
C64 TIQ_1 GND 0.05fF
C65 TIQ_2 GND 1.46fF
C66 STAGE2_INV_25286363_PG0_0_0_1681530354_0/li_663_571# GND 2.13fF
C67 TIQ_7 GND 1.46fF
C68 STAGE2_INV_54873308_PG0_0_0_1681530358_0/li_663_571# GND 2.74fF
C69 TIQ_6 GND 1.26fF
C70 STAGE2_INV_99975026_PG0_0_0_1681530360_0/li_663_571# GND 2.56fF
C71 TIQ_4 GND 1.30fF
C72 STAGE2_INV_35754050_PG0_0_0_1681530356_0/li_663_571# GND 1.82fF
C73 TIQ_3 GND 1.49fF
C74 STAGE2_INV_66130952_PG0_0_0_1681530359_0/li_663_571# GND 2.04fF
C75 VIN GND 7.57fF
C76 VDD GND 56.61fF
C77 TIQ_5 GND 1.38fF
C78 STAGE2_INV_30784801_PG0_0_0_1681530355_0/li_663_571# GND 1.58fF
C79 TIQ_1 GND 1.32fF
C80 STAGE2_INV_50758951_PG0_0_0_1681530357_0/li_663_571# GND 1.56fF
.ends


*===============MANUALLY ADDED=========================
V1 VDD GND 1.8
.save i(v1)
V2 VIN GND sin(0 2 20Meg)
.save i(v2)
x1 VIN GND VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7 flash_adc_tb

**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all

.tran 0.01n 15n
.control
run
plot VIN VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7
.save all
.endc
.end

**** end user architecture code
**.ends
```

**NgSpice Plot**

![Y5](https://user-images.githubusercontent.com/114692581/230716277-b9e82d4e-0eb9-4d11-a497-397ac26e1bae.PNG)

# Comparison between Pre-layout and Post-layout testbench of 3-bit Flash ADC schematic
| 3-bit Flash ADC | Pre-layout [Xschem] | Post-layout [ALIGN] |
| --------------- | ------------------- | ------------------- |
| Output | ![A3](https://user-images.githubusercontent.com/114692581/230716388-b6343f88-f443-4e10-adec-230d66a22040.PNG) | ![Y5](https://user-images.githubusercontent.com/114692581/230716277-b9e82d4e-0eb9-4d11-a497-397ac26e1bae.PNG) |


It has been noticed that the post-layout simulation [using ALIGN] result is **same** as the pre-layout simulation result of 3-bit flash ADC. Though because of capacitance parasitics, some delays are observed in post-layout simulation.







