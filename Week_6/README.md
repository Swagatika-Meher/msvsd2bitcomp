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

XM1 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM2 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=2520n nf=2
XM3 TIQ_1 net1 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM4 TIQ_1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=2520n nf=2
XM5 net2 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM6 net2 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1260n nf=2
XM7 TIQ_2 net2 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM8 TIQ_2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1260n nf=2
XM9 net3 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM10 net3 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1680n nf=2
XM11 TIQ_3 net3 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM12 TIQ_3 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1680n nf=2
XM13 net4 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=1680n nf=2
XM14 net4 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM15 TIQ_4 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1680n nf=2
XM16 TIQ_4 net4 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM17 net5 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=2520n nf=2
XM18 net5 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM19 TIQ_5 net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=2520n nf=2
XM20 TIQ_5 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM21 net6 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=630n nf=2
XM22 net6 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM23 TIQ_6 net6 GND GND sky130_fd_pr__nfet_01v8 L=150n W=630n nf=2
XM24 TIQ_6 net6 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM25 net7 VIN GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM26 net7 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM27 TIQ_7 net7 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM28 TIQ_7 net7 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
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

![Y1](https://user-images.githubusercontent.com/114692581/230715549-57d0605f-4db2-487e-891d-bdb21ea9eeb0.PNG)

## Generated .gds and .lef files in KLayout

**.gds**

![Y2](https://user-images.githubusercontent.com/114692581/230715572-27a18822-efa9-440d-8424-26c8c8b9e32f.PNG)

**.lef**

![Y3](https://user-images.githubusercontent.com/114692581/230715583-fa2ee0cd-4a72-4e19-991c-3c76e66e8e68.PNG)

To extract the spice netlist of above post-layout go to MAGIC tool and read the `.gds` file. Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.

![Y4](https://user-images.githubusercontent.com/114692581/230715997-3cb73d53-781f-4fce-b69c-e9a5dbf4dd84.PNG)

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

X0 VDD STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=8.0136e+12p pd=7.532e+07u as=3.528e+11p ps=3.08e+06u w=1.26e+06u l=150000u
X1 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X2 VDD VIN STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=3.528e+11p ps=3.08e+06u w=1.26e+06u l=150000u
X3 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X4 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=7.3458e+12p ps=7.028e+07u w=420000u l=150000u
X5 GND VIN STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 GND STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 TIQ_6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VDD STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X11 VDD VIN STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X12 TIQ_6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X13 GND STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X14 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X15 GND VIN STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X16 TIQ_4 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X17 GND STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X18 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X19 GND VIN STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X20 TIQ_4 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X21 VDD STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X22 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X23 VDD VIN STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X24 STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X25 VDD STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X26 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X27 VDD VIN STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X28 STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X29 GND STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X30 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X31 GND VIN STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X32 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X33 VDD VIN STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X34 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X35 VDD STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X36 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X37 GND STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X38 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X39 GND VIN STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X40 STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X41 GND STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X42 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X43 GND VIN STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X44 STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X45 VDD STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X46 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X47 VDD VIN STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X48 TIQ_7 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X49 GND STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X50 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X51 GND VIN STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X52 TIQ_7 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X53 VDD STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X54 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X55 VDD VIN STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 0.01fF
C1 TIQ_3 VIN 0.01fF
C2 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN 0.63fF
C3 TIQ_3 VDD 0.84fF
C4 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD 3.44fF
C5 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# 0.25fF
C6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN 0.62fF
C7 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD 3.44fF
C8 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN 0.59fF
C9 VDD STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 3.44fF
C10 TIQ_7 VIN 0.01fF
C11 TIQ_7 VDD 0.87fF
C12 TIQ_5 VDD 0.00fF
C13 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.01fF
C14 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 0.26fF
C15 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 0.01fF
C16 VIN STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# 0.01fF
C17 STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# VIN 0.01fF
C18 VDD STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# 0.84fF
C19 STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# VDD 0.84fF
C20 TIQ_6 VIN 0.01fF
C21 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# 0.24fF
C22 VDD TIQ_6 0.85fF
C23 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.01fF
C24 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN 0.54fF
C25 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN 0.59fF
C26 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD 3.58fF
C27 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD 3.29fF
C28 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# 0.01fF
C29 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.23fF
C30 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 0.23fF
C31 TIQ_2 VIN 0.01fF
C32 TIQ_4 VIN 0.01fF
C33 TIQ_2 VDD 0.84fF
C34 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN 0.61fF
C35 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# 0.26fF
C36 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 0.25fF
C37 TIQ_4 VDD 0.83fF
C38 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD 3.29fF
C39 TIQ_1 VDD 0.01fF
C40 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# 0.01fF
C41 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN 0.59fF
C42 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD 3.33fF
C43 VDD VIN 11.08fF
C44 TIQ_5 GND 0.09fF
C45 TIQ_1 GND 0.13fF
C46 TIQ_7 GND 0.64fF **FLOATING
C47 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND 1.15fF **FLOATING
C48 STAGE2_INV_95373668_0_0_1680948070_0/m1_140_1400# GND 0.68fF **FLOATING
C49 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND 0.58fF **FLOATING
C50 TIQ_3 GND 0.73fF **FLOATING
C51 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND 0.86fF **FLOATING
C52 STAGE2_INV_33726594_0_0_1680948066_0/m1_140_1400# GND 0.68fF **FLOATING
C53 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND 0.32fF **FLOATING
C54 VIN GND 11.03fF **FLOATING
C55 TIQ_4 GND 0.73fF **FLOATING
C56 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND 0.74fF **FLOATING
C57 VDD GND 42.34fF **FLOATING
C58 TIQ_6 GND 0.77fF **FLOATING
C59 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND 1.28fF **FLOATING
C60 TIQ_2 GND 0.75fF **FLOATING
C61 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND 1.05fF **FLOATING
```
If we can see carefully, in the above netlist 'TIQ_1' and 'TIQ_5' pins were not reflected in FETs instances. So, manually added these two pins to get the correct plots.

After exporting `.gds` file generated by Align to magic and extract '.spice' file, manually the `.control` statements are added and the postlayout (generated by ALIGN tool) compared with pre-layout testbench 1 bit ADC schematic.
```
* SPICE3 file created from FLASH_ADC_TB_0.ext - technology: sky130A

.subckt flash_adc_tb VIN GND VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7
X0 VDD STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# TIQ_2 VDD sky130_fd_pr__pfet_01v8 ad=8.0136e+12p pd=7.532e+07u as=3.528e+11p ps=3.08e+06u w=1.26e+06u l=150000u
X1 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X2 VDD VIN STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=3.528e+11p ps=3.08e+06u w=1.26e+06u l=150000u
X3 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X4 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=7.3458e+12p ps=7.028e+07u w=420000u l=150000u
X5 GND VIN STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 GND STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# TIQ_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 TIQ_6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VDD STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X11 VDD VIN STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X12 TIQ_6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X13 GND STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X14 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X15 GND VIN STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X16 TIQ_4 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X17 GND STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X18 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X19 GND VIN STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X20 TIQ_4 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X21 VDD STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X22 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X23 VDD VIN STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X24 TIQ_1 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X25 VDD STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# TIQ_1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X26 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X27 VDD VIN STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X28 TIQ_1 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X29 GND STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# TIQ_1 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X30 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X31 GND VIN STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X32 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X33 VDD VIN STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X34 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X35 VDD STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# TIQ_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X36 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X37 GND STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# TIQ_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X38 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X39 GND VIN STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X40 TIQ_5 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X41 GND STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# TIQ_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X42 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X43 GND VIN STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X44 TIQ_5 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X45 VDD STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# TIQ_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X46 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X47 VDD VIN STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X48 TIQ_7 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X49 GND STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X50 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X51 GND VIN STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X52 TIQ_7 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X53 VDD STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X54 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X55 VDD VIN STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 0.01fF
C1 TIQ_3 VIN 0.01fF
C2 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VIN 0.63fF
C3 TIQ_3 VDD 0.84fF
C4 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# VDD 3.44fF
C5 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# TIQ_5 0.25fF
C6 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VIN 0.62fF
C7 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# VDD 3.44fF
C8 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# VIN 0.59fF
C9 VDD STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 3.44fF
C10 TIQ_7 VIN 0.01fF
C11 TIQ_7 VDD 0.87fF
C12 TIQ_5 VDD 0.00fF
C13 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.01fF
C14 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# TIQ_7 0.26fF
C15 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# 0.01fF
C16 VIN TIQ_1 0.01fF
C17 TIQ_5 VIN 0.01fF
C18 VDD TIQ_1 0.84fF
C19 TIQ_5 VDD 0.84fF
C20 TIQ_6 VIN 0.01fF
C21 TIQ_2 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# 0.24fF
C22 VDD TIQ_6 0.85fF
C23 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.01fF
C24 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VIN 0.54fF
C25 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VIN 0.59fF
C26 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# VDD 3.58fF
C27 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# VDD 3.29fF
C28 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# 0.01fF
C29 TIQ_3 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# 0.23fF
C30 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# TIQ_4 0.23fF
C31 TIQ_2 VIN 0.01fF
C32 TIQ_4 VIN 0.01fF
C33 TIQ_2 VDD 0.84fF
C34 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VIN 0.61fF
C35 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# TIQ_1 0.26fF
C36 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# TIQ_6 0.25fF
C37 TIQ_4 VDD 0.83fF
C38 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# VDD 3.29fF
C39 TIQ_1 VDD 0.01fF
C40 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# 0.01fF
C41 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VIN 0.59fF
C42 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# VDD 3.33fF
C43 VDD VIN 11.08fF
C44 TIQ_5 GND 0.09fF
C45 TIQ_1 GND 0.13fF
C46 TIQ_7 GND 0.64fF
C47 STAGE2_INV_71678170_0_0_1680948068_0/li_491_571# GND 1.15fF
C48 TIQ_5 GND 0.68fF
C49 STAGE2_INV_95373668_0_0_1680948070_0/li_491_571# GND 0.58fF
C50 TIQ_3 GND 0.73fF
C51 STAGE2_INV_27873531_0_0_1680948065_0/li_491_571# GND 0.86fF
C52 TIQ_1 GND 0.68fF
C53 STAGE2_INV_33726594_0_0_1680948066_0/li_491_571# GND 0.32fF
C54 VIN GND 11.03fF
C55 TIQ_4 GND 0.73fF
C56 STAGE2_INV_68286290_0_0_1680948067_0/li_491_571# GND 0.74fF
C57 VDD GND 42.34fF
C58 TIQ_6 GND 0.77fF
C59 STAGE2_INV_27831186_0_0_1680948064_0/li_491_571# GND 1.28fF
C60 TIQ_2 GND 0.75fF
C61 STAGE2_INV_92269094_0_0_1680948069_0/li_491_571# GND 1.05fF
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







