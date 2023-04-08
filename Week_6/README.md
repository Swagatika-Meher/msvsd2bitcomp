# Xschem: Pre-layout simulation for 3-bit CMOS based TIQ comparator Flash ADC
## TIQ Comparator
In TIQ technique, it uses two cascaded CMOS inverters as a comparator. While the second inverter serves as a gain booster, the first inverter internally creates reference voltage (Vref). As we adjust the size of CMOS, the cascading inverters produce various switching/reference voltages internally which serves as reference voltages. The purpose of TIQ comparator is to transform an input voltage (Vin) toward logic '1' or '0' by estimating a reference voltage (Vref) with the Vin. If Vin is greater than Vref, the comparator output is '1', otherwise '0'. This occurs when transistor width is altered while keeping the transistor length constant. The gain boosters create sharper thresholds for comparator outputs and offer a complete digital output voltage swing.

Two inverters are linked in series on the TIQ Comparator for comparing and balancing. The threshold voltage of the inverter circuits can be modified to provide different reference voltages by adjusting the width of PMOS and NMOS transistors. In analog section of 3-bit ADC, $\[{2^n} - 1\]$ comparators that is, 7 TIQ comparators are connected parallelly using CMOS inverters. Where, n is the number of output binary bits.

![A1](https://user-images.githubusercontent.com/114692581/230714036-7e7da415-ba3c-4c46-ae73-f4011a76e487.PNG)

**Testbench Schematic :**

Here, each TIQ comparator schematic is converted into seven symbols in xschem.

![A2](https://user-images.githubusercontent.com/114692581/229279671-441296b7-2050-4df4-81cc-c10a8c70db03.PNG)

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
V2 VIN GND sin(0 3 20Meg)
.save i(v2)
x1 VIN GND VDD TIQ_1 flash_adc_sym_1
x2 VIN GND VDD TIQ_2 flash_adc_sym_2
x3 VIN GND VDD TIQ_3 flash_adc_sym_3
x4 VIN GND VDD TIQ_4 flash_adc_sym_4
x5 VIN GND VDD TIQ_5 flash_adc_sym_5
x6 VIN GND VDD TIQ_6 flash_adc_sym_6
x7 VIN GND VDD TIQ_7 flash_adc_sym_7
**** begin user architecture code
.tran 0.001n 20n
.control
run
plot VIN VDD TIQ_1 TIQ_2 TIQ_3 TIQ_4 TIQ_5 TIQ_6 TIQ_7
.save all
.endc
.end


.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all
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
XM1 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.3 W=20 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=10 W=0.5 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 TIQ_1 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 TIQ_1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM5 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=0.63 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=10 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 TIQ_2 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 TIQ_2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM10 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 TIQ_3 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 TIQ_3 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM13 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=0.18 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM14 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.18 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM15 TIQ_4 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM16 TIQ_4 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM17 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=1 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM18 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.18 W=3 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM19 TIQ_5 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM20 TIQ_5 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM21 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=10 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM22 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.18 W=15 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM23 TIQ_6 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM24 TIQ_6 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
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
XM25 net1 VIN GND GND sky130_fd_pr__nfet_01v8 L=20 W=0.42 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM26 net1 VIN VDD VDD sky130_fd_pr__pfet_01v8 L=0.18 W=30 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM27 TIQ_7 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM28 TIQ_7 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends
.end
```
**NgSpice Plot :**

![A3](https://user-images.githubusercontent.com/114692581/229279884-12b49a84-f0ff-4eac-953a-7adcef7eb2d0.PNG)




