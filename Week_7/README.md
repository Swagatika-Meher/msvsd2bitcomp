# Post-Layout: OpenFASOC flow for 3-bit Flash ADC using TIQ comparator
For pre-layout simulation, refer this [repo](https://github.com/Swagatika-Meher/3-bit-CMOS-based-TIQ-comparator-Flash-ADC). 

## Reference Circuit Diagram
Given attached is the block diagram for TIQ comparator based 3-bit Flash type ADC.

![diagram](https://user-images.githubusercontent.com/114692581/194697017-283623c1-a901-4f7f-9798-6264ac4d1deb.png)

The TIQ (Threshold Inverter Quantization) technique utilizes a pair of CMOS inverters in series as a comparator. The first inverter generates an internal reference voltage (Vref), while the second inverter acts as a gain booster. By adjusting the size of the CMOS, different switching and reference voltages are created, which can be used as reference voltages. The goal of the TIQ comparator is to convert an input voltage (Vin) into a logic '1' or '0' by comparing it with the estimated reference voltage (Vref). If Vin is greater than Vref, the output of the comparator is '1'; otherwise, it is '0'. This is achieved by varying the transistor width while maintaining the transistor length constant. The gain boosters increase the gain of the comparator and create sharper threshold voltages, resulting in a complete digital output voltage swing. The comparator generates a thermometer code, which is converted to a binary code using an 8:3 priority encoder. In this particular design, a sine wave with a frequency of 40MHz is used as the input voltage.

## TIQ Comparator
Two inverters are linked in series on the TIQ Comparator for comparing and balancing. The threshold voltage of the inverter circuits can be modified to provide different reference voltages by adjusting the width of PMOS and NMOS transistors. In analog section of 3-bit ADC, $\[{2^n} - 1\]$ comparators that is, 7 TIQ comparators are connected parallelly using CMOS inverters. Where, n is the number of output binary bits.
 
![images](https://user-images.githubusercontent.com/114692581/194702441-2e6e4ff6-7534-437c-b5da-8171514baa5d.png)

## Truth Table

![Capture](https://user-images.githubusercontent.com/114692581/194705103-fb21f514-ca59-4f26-9e4e-8a998e3640c9.PNG)

# Steps for OpenFASOC flow
The physical implementation of the analog blocks in the circuit is treated as macros and the digital block that is, 8 to 3 priority encoder is placed as standard cell.

**Verilog Generation**

First, we need to create dummy verilog code for **TOP-LEVEL** design.
```ruby
module flash_adc
(
	input vin, output T_1, T_2, T_3, T_4, T_5, T_6, T_7, Y1, Y2, Y3
	);
	
	//wire a,b,c,d,e,f,g;
	//Instantiating TIQ comparators
	
	FLASH_ADC_SYM_1 FA_1(
		.VIN(vin),
		.TIQ_1(T_1)
	);
	
	FLASH_ADC_SYM_2 FA_2(
		.VIN(vin),
		.TIQ_2(T_2)
	);
	
	FLASH_ADC_SYM_3 FA_3(
		.VIN(vin),
		.TIQ_3(T_3)
	);
	
	FLASH_ADC_SYM_4 FA_4(
		.VIN(vin),
		.TIQ_4(T_4)
	);
	
	FLASH_ADC_SYM_5 FA_5(
		.VIN(vin),
		.TIQ_5(T_5)
	);
	
	FLASH_ADC_SYM_6 FA_6(
		.VIN(vin),
		.TIQ_6(T_6)
	);
	
	FLASH_ADC_SYM_7 FA_7(
		.VIN(vin),
		.TIQ_7(T_7)
	);
	
	priority_encoder PE(
	.IN1(T_1),
	.IN2(T_2),
	.IN3(T_3),
	.IN4(T_4),
	.IN5(T_5),
	.IN6(T_6),
	.IN7(T_7),
	.O3(Y3),
	.O2(Y2),
	.O1(Y1)
	);

endmodule
```
All the files related to this flow can be found [here].

> **NOTE**

Once set the files as mentioned above, first run below commands to avoid **PDK_ROOT** path errors.
```
$ export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
$ export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
$ export PDK_ROOT=/home/swagatika/open_pdks/sky130/
```

1. Go to OpenFASOC install directory `~/openfasoc/openfasoc/generators`. Create a new folder with your design name. Here, my design name is `flash-adc-gen`.
2. Place your dummy verilog code inside `/flash-adc-gen/src/`.
3. To run verilog generation, `cd` into `openfasoc/generators/flash-adc-gen/` and execute the command `$ make sky130hd_ADC_verilog`.

   ![Z1](https://user-images.githubusercontent.com/114692581/233766494-dac76022-bf9c-4bc3-8af7-260505d8bc70.PNG)

4. Either execute the `make sky130hd_ADC_build` command in `openfasoc/generators/flash-adc-gen/` or you can check the entire flow in each step by going to `/flow` directory and execute the below commands.

   **SYNTHESIS**

   `$ make synth`

   ![Z2](https://user-images.githubusercontent.com/114692581/233766662-e1fcfc13-60d2-4960-a749-2da6957380ae.PNG)

   **FLOORPLAN**

   `$ make floorplan`

   Design area 563 u^2 13% utilization.

   ![Z3](https://user-images.githubusercontent.com/114692581/233767054-5991101a-7169-4450-9298-502c280245e8.PNG)

   ![Z4](https://user-images.githubusercontent.com/114692581/233767060-78f0866b-6a35-4a1d-8752-61c6fb0cd5f6.PNG)

   `$ make gui_floorplan`

   ![Z5](https://user-images.githubusercontent.com/114692581/233767123-68fffc81-dbdf-4a99-a7f8-198321ad4cf4.PNG)

   **GLOBAL PLACE**

   `$ make place`

   ![Z6](https://user-images.githubusercontent.com/114692581/233767184-be54b6eb-0351-4a8c-9677-cdff8ea10bab.PNG)

   **GLOBAL ROUTE**

   `$ make route`

   ![Z7](https://user-images.githubusercontent.com/114692581/233767352-679d5efc-1843-4a44-bfe2-344f68421f18.PNG)

   `$ make gui_route`

   ![Z8](https://user-images.githubusercontent.com/114692581/233767439-6318717a-2979-4247-82ec-147142cb7b03.PNG)

   **FINISH**

   `$ make finish`
 
   ![Z9](https://user-images.githubusercontent.com/114692581/233767530-9975e622-7bc3-4cad-ba1f-0a814d764c9a.PNG)

   **DRC CHECK**

   DRC is clean.

   ![Z10](https://user-images.githubusercontent.com/114692581/233767758-32e37c33-1d17-46e8-8ce7-6a7a3d60e4ad.PNG)

## OpenROAD GUI view

![Z8](https://user-images.githubusercontent.com/114692581/233767439-6318717a-2979-4247-82ec-147142cb7b03.PNG)

## Final .gds file in KLayout

![Z11](https://user-images.githubusercontent.com/114692581/233767930-c382bf0d-cad9-4d43-8153-4eb468b15869.PNG)

## Final .gds file in MAGIC VLSI tool

![Z12](https://user-images.githubusercontent.com/114692581/233768064-2de5ee44-a8d0-402b-b1dd-4a2b9853476f.PNG)

Select the entire cell by clicking `i` and extract the post-layout netlist by following the below commands.
```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

**Post layout .spice file is created in magic working directory,**

```
* SPICE3 file created from flash_adc.ext - technology: sky130A

.subckt flash_adc T_1 T_6 T_7 vin T_2 T_3 T_4 T_5 Y1 Y2 Y3 VDD VSS
X0 T_4 FLASH_ADC_SYM_4_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.41903e+13p ps=4.3592e+08u w=840000u l=150000u
X1 VDD vin FLASH_ADC_SYM_4_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.24e+06u w=840000u l=150000u
X2 VDD FLASH_ADC_SYM_4_0/a_200_531# T_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X3 T_4 FLASH_ADC_SYM_4_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=3.09329e+13p ps=3.3716e+08u w=1.68e+06u l=150000u
X4 VSS FLASH_ADC_SYM_4_0/a_200_531# T_4 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X5 FLASH_ADC_SYM_4_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X6 VSS vin FLASH_ADC_SYM_4_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X7 FLASH_ADC_SYM_4_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X8 FLASH_ADC_SYM_2_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VSS vin FLASH_ADC_SYM_2_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 FLASH_ADC_SYM_2_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=3.528e+11p pd=3.08e+06u as=0p ps=0u w=1.26e+06u l=150000u
X11 T_2 FLASH_ADC_SYM_2_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=3.528e+11p pd=3.08e+06u as=0p ps=0u w=1.26e+06u l=150000u
X12 VDD vin FLASH_ADC_SYM_2_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X13 VDD FLASH_ADC_SYM_2_0/a_200_531# T_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X14 T_2 FLASH_ADC_SYM_2_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X15 VSS FLASH_ADC_SYM_2_0/a_200_531# T_2 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X16 FLASH_ADC_SYM_7_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X17 FLASH_ADC_SYM_7_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X18 T_7 FLASH_ADC_SYM_7_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X19 VSS vin FLASH_ADC_SYM_7_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X20 VDD vin FLASH_ADC_SYM_7_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X21 VDD FLASH_ADC_SYM_7_0/a_200_531# T_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X22 T_7 FLASH_ADC_SYM_7_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X23 VSS FLASH_ADC_SYM_7_0/a_200_531# T_7 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X24 VSS vin FLASH_ADC_SYM_5_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=7.056e+11p ps=5.6e+06u w=2.52e+06u l=150000u
X25 FLASH_ADC_SYM_5_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X26 T_5 FLASH_ADC_SYM_5_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X27 VDD vin FLASH_ADC_SYM_5_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X28 VDD FLASH_ADC_SYM_5_0/a_200_531# T_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X29 T_5 FLASH_ADC_SYM_5_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X30 VSS FLASH_ADC_SYM_5_0/a_200_531# T_5 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X31 FLASH_ADC_SYM_5_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X32 T_3 FLASH_ADC_SYM_3_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X33 FLASH_ADC_SYM_3_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X34 VSS FLASH_ADC_SYM_3_0/a_200_531# T_3 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X35 T_3 FLASH_ADC_SYM_3_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X36 VDD vin FLASH_ADC_SYM_3_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X37 VDD FLASH_ADC_SYM_3_0/a_200_531# T_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X38 FLASH_ADC_SYM_3_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X39 VSS vin FLASH_ADC_SYM_3_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X40 FLASH_ADC_SYM_1_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X41 VSS vin FLASH_ADC_SYM_1_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X42 FLASH_ADC_SYM_1_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X43 T_1 FLASH_ADC_SYM_1_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X44 VDD vin FLASH_ADC_SYM_1_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X45 VDD FLASH_ADC_SYM_1_0/a_200_531# T_1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X46 T_1 FLASH_ADC_SYM_1_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X47 VSS FLASH_ADC_SYM_1_0/a_200_531# T_1 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X48 VSS FLASH_ADC_SYM_6_0/a_200_531# T_6 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=1.764e+11p ps=1.82e+06u w=630000u l=150000u
X49 FLASH_ADC_SYM_6_0/a_200_531# vin VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X50 T_6 FLASH_ADC_SYM_6_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X51 VDD vin FLASH_ADC_SYM_6_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X52 FLASH_ADC_SYM_6_0/a_200_531# vin VSS VSS sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X53 VDD FLASH_ADC_SYM_6_0/a_200_531# T_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X54 VSS vin FLASH_ADC_SYM_6_0/a_200_531# VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X55 T_6 FLASH_ADC_SYM_6_0/a_200_531# VSS VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
C0 T_1 FLASH_ADC_SYM_7_0/a_200_531# 0.05fF
C1 FLASH_ADC_SYM_4_0/a_200_531# sky130_fd_sc_hd__fill_8_8/VPB 0.00fF
C2 VDD Y1 2.10fF
C3 sky130_fd_sc_hd__fill_2_7/VPB T_2 0.09fF
C4 T_6 T_2 0.33fF
C5 VDD sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C6 Y2 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.00fF
C7 T_3 T_5 0.21fF
C8 Y2 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C9 sky130_fd_sc_hd__fill_8_92/VPB VSS 1.18fF
C10 T_6 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C11 T_3 T_7 0.44fF
C12 VDD sky130_fd_sc_hd__fill_8_8/VPB 1.64fF
C13 T_5 T_2 0.15fF
C14 sky130_fd_sc_hd__fill_8_93/VPB VDD 1.39fF
C15 T_7 T_2 0.12fF
C16 FLASH_ADC_SYM_6_0/a_200_531# VDD 2.93fF
C17 T_5 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C18 VDD FLASH_ADC_SYM_5_0/a_200_531# 3.17fF
C19 T_3 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C20 T_7 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C21 vin T_3 0.51fF
C22 T_4 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C23 VSS Y3 0.50fF
C24 Y2 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C25 Y2 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.09fF
C26 Y1 sky130_fd_sc_hd__fill_2_7/VPB 0.03fF
C27 Y1 T_6 0.01fF
C28 vin T_2 0.45fF
C29 T_4 T_1 0.08fF
C30 sky130_fd_sc_hd__or4_1_0/a_277_297# T_6 0.00fF
C31 Y1 T_5 0.12fF
C32 VDD Y2 3.12fF
C33 Y1 T_7 0.01fF
C34 sky130_fd_sc_hd__fill_8_93/VPB T_6 0.00fF
C35 sky130_fd_sc_hd__or4_1_0/a_277_297# T_7 0.00fF
C36 FLASH_ADC_SYM_6_0/a_200_531# T_6 0.39fF
C37 sky130_fd_sc_hd__fill_8_1/VPB T_3 0.00fF
C38 T_3 sky130_fd_sc_hd__fill_8_4/VPB 0.01fF
C39 T_6 FLASH_ADC_SYM_5_0/a_200_531# 0.30fF
C40 VSS T_3 4.20fF
C41 sky130_fd_sc_hd__fill_8_1/VPB T_2 0.08fF
C42 T_2 sky130_fd_sc_hd__fill_8_4/VPB 0.07fF
C43 VSS T_2 2.40fF
C44 FLASH_ADC_SYM_6_0/a_200_531# T_5 0.11fF
C45 T_5 FLASH_ADC_SYM_5_0/a_200_531# 0.47fF
C46 vin Y1 0.07fF
C47 FLASH_ADC_SYM_6_0/a_200_531# T_7 0.00fF
C48 T_4 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C49 VSS sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C50 vin sky130_fd_sc_hd__fill_8_8/VPB 0.34fF
C51 VDD FLASH_ADC_SYM_7_0/a_200_531# 2.95fF
C52 sky130_fd_sc_hd__or4_1_2/a_109_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C53 T_6 Y2 0.26fF
C54 sky130_fd_sc_hd__fill_8_87/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.01fF
C55 T_4 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.32fF
C56 FLASH_ADC_SYM_6_0/a_200_531# vin 1.11fF
C57 T_1 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.06fF
C58 vin FLASH_ADC_SYM_5_0/a_200_531# 0.57fF
C59 T_5 Y2 0.00fF
C60 sky130_fd_sc_hd__fill_8_1/VPB Y1 0.02fF
C61 Y1 sky130_fd_sc_hd__fill_8_4/VPB 0.01fF
C62 VSS Y1 2.13fF
C63 Y2 T_7 0.32fF
C64 VSS sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C65 VSS sky130_fd_sc_hd__fill_8_8/VPB 1.40fF
C66 T_4 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C67 T_4 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.00fF
C68 FLASH_ADC_SYM_4_0/a_200_531# T_4 0.26fF
C69 sky130_fd_sc_hd__fill_8_93/VPB VSS 1.18fF
C70 FLASH_ADC_SYM_6_0/a_200_531# VSS 0.06fF
C71 T_6 FLASH_ADC_SYM_7_0/a_200_531# 0.05fF
C72 sky130_fd_sc_hd__or4_1_2/a_205_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.01fF
C73 VDD T_4 7.07fF
C74 T_5 FLASH_ADC_SYM_7_0/a_200_531# 0.11fF
C75 VDD T_1 5.19fF
C76 T_4 FLASH_ADC_SYM_3_0/a_200_531# 0.20fF
C77 T_3 T_2 3.00fF
C78 FLASH_ADC_SYM_7_0/a_200_531# T_7 0.37fF
C79 T_4 FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C80 sky130_fd_sc_hd__fill_8_92/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.01fF
C81 T_3 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C82 VSS Y2 0.56fF
C83 T_2 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C84 vin FLASH_ADC_SYM_7_0/a_200_531# 0.96fF
C85 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_1/a_27_297# 0.01fF
C86 T_6 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C87 T_4 T_6 0.36fF
C88 sky130_fd_sc_hd__or4_1_2/a_277_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C89 FLASH_ADC_SYM_1_0/a_200_531# T_1 0.32fF
C90 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C91 T_3 Y1 1.41fF
C92 T_6 T_1 4.17fF
C93 T_5 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C94 T_4 T_5 0.47fF
C95 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_109_297# 0.02fF
C96 T_3 sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C97 Y1 T_2 2.56fF
C98 T_7 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.01fF
C99 VDD sky130_fd_sc_hd__or4_1_1/a_27_297# 0.27fF
C100 T_4 T_7 0.39fF
C101 sky130_fd_sc_hd__or4_1_0/a_277_297# T_2 0.00fF
C102 VDD sky130_fd_sc_hd__or4_1_2/a_27_297# 0.25fF
C103 T_5 T_1 1.30fF
C104 T_3 sky130_fd_sc_hd__fill_8_8/VPB 0.01fF
C105 Y1 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C106 VSS FLASH_ADC_SYM_7_0/a_200_531# 0.02fF
C107 T_1 T_7 0.30fF
C108 sky130_fd_sc_hd__fill_8_8/VPB T_2 0.07fF
C109 Y2 Y3 1.66fF
C110 vin T_4 1.00fF
C111 sky130_fd_sc_hd__fill_8_87/VPB T_1 0.11fF
C112 T_6 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C113 VDD sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C114 vin T_1 0.38fF
C115 VDD sky130_fd_sc_hd__or4_1_0/a_27_297# 0.36fF
C116 VDD FLASH_ADC_SYM_4_0/a_200_531# 2.90fF
C117 T_5 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C118 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_205_297# 0.01fF
C119 T_6 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.03fF
C120 FLASH_ADC_SYM_4_0/a_200_531# FLASH_ADC_SYM_3_0/a_200_531# 0.00fF
C121 T_7 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C122 VDD sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C123 T_6 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.26fF
C124 T_3 Y2 0.11fF
C125 Y1 sky130_fd_sc_hd__fill_8_8/VPB 0.01fF
C126 T_5 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.32fF
C127 VSS sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C128 Y2 T_2 0.01fF
C129 VSS T_4 1.26fF
C130 T_5 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.08fF
C131 T_7 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.21fF
C132 VDD FLASH_ADC_SYM_3_0/a_200_531# 2.72fF
C133 T_7 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.47fF
C134 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_0/a_109_297# 0.02fF
C135 VSS T_1 2.99fF
C136 VDD FLASH_ADC_SYM_2_0/a_200_531# 2.87fF
C137 FLASH_ADC_SYM_3_0/a_200_531# FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C138 T_6 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C139 T_6 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.22fF
C140 VDD sky130_fd_sc_hd__or4_1_0/a_109_297# 0.01fF
C141 sky130_fd_sc_hd__fill_8_93/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.00fF
C142 T_5 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C143 VDD FLASH_ADC_SYM_1_0/a_200_531# 3.11fF
C144 FLASH_ADC_SYM_6_0/a_200_531# FLASH_ADC_SYM_5_0/a_200_531# 0.00fF
C145 T_5 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.01fF
C146 T_6 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C147 FLASH_ADC_SYM_4_0/a_200_531# T_5 0.01fF
C148 sky130_fd_sc_hd__fill_8_92/VPB T_1 0.14fF
C149 T_7 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C150 VDD sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C151 VDD sky130_fd_sc_hd__fill_2_7/VPB 1.31fF
C152 sky130_fd_sc_hd__or4_1_0/a_27_297# T_7 0.22fF
C153 VDD T_6 4.93fF
C154 T_5 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.01fF
C155 sky130_fd_sc_hd__or4_1_0/a_277_297# Y2 0.00fF
C156 FLASH_ADC_SYM_1_0/a_200_531# FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C157 VSS sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C158 VDD T_5 5.05fF
C159 T_7 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C160 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_0/a_205_297# 0.01fF
C161 T_4 Y3 0.15fF
C162 VDD T_7 7.85fF
C163 T_5 FLASH_ADC_SYM_3_0/a_200_531# 0.02fF
C164 VSS sky130_fd_sc_hd__or4_1_1/a_27_297# 0.36fF
C165 vin FLASH_ADC_SYM_4_0/a_200_531# 1.11fF
C166 VSS sky130_fd_sc_hd__or4_1_2/a_27_297# 0.36fF
C167 T_6 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C168 VDD sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C169 VDD sky130_fd_sc_hd__fill_8_87/VPB 1.82fF
C170 VDD vin 19.19fF
C171 T_5 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C172 T_6 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C173 sky130_fd_sc_hd__or4_1_0/a_109_297# T_7 0.00fF
C174 T_3 T_4 0.11fF
C175 vin FLASH_ADC_SYM_3_0/a_200_531# 1.09fF
C176 T_2 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C177 T_5 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C178 T_4 T_2 0.08fF
C179 vin FLASH_ADC_SYM_2_0/a_200_531# 1.18fF
C180 VSS sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C181 T_5 T_6 1.33fF
C182 T_3 T_1 0.00fF
C183 VSS sky130_fd_sc_hd__or4_1_0/a_27_297# 0.28fF
C184 VSS FLASH_ADC_SYM_4_0/a_200_531# 0.05fF
C185 T_7 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C186 T_6 T_7 0.87fF
C187 T_1 T_2 0.00fF
C188 FLASH_ADC_SYM_6_0/a_200_531# FLASH_ADC_SYM_7_0/a_200_531# 0.00fF
C189 VSS sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C190 T_5 T_7 1.77fF
C191 sky130_fd_sc_hd__fill_8_1/VPB VDD 1.89fF
C192 VDD sky130_fd_sc_hd__fill_8_4/VPB 1.25fF
C193 VDD VSS 146.38fF
C194 T_6 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C195 FLASH_ADC_SYM_1_0/a_200_531# vin 0.56fF
C196 sky130_fd_sc_hd__fill_8_87/VPB T_6 0.20fF
C197 Y3 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.09fF
C198 vin sky130_fd_sc_hd__fill_2_7/VPB 0.17fF
C199 VSS FLASH_ADC_SYM_3_0/a_200_531# 0.06fF
C200 vin T_6 0.42fF
C201 VSS FLASH_ADC_SYM_2_0/a_200_531# 0.04fF
C202 T_5 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C203 Y1 T_4 0.00fF
C204 sky130_fd_sc_hd__or4_1_0/a_205_297# T_7 0.00fF
C205 vin T_5 0.70fF
C206 sky130_fd_sc_hd__fill_8_92/VPB VDD 1.36fF
C207 vin T_7 0.10fF
C208 Y1 T_1 0.00fF
C209 VSS sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C210 T_3 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.23fF
C211 T_4 sky130_fd_sc_hd__fill_8_8/VPB 0.00fF
C212 Y3 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C213 FLASH_ADC_SYM_1_0/a_200_531# VSS 0.15fF
C214 T_3 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C215 T_2 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.01fF
C216 VSS sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C217 VSS sky130_fd_sc_hd__fill_2_7/VPB 1.39fF
C218 vin sky130_fd_sc_hd__fill_8_87/VPB 0.00fF
C219 T_2 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C220 VSS T_6 5.50fF
C221 sky130_fd_sc_hd__fill_8_93/VPB T_1 0.11fF
C222 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_277_297# 0.01fF
C223 FLASH_ADC_SYM_6_0/a_200_531# T_1 0.05fF
C224 VDD Y3 0.64fF
C225 VSS T_5 1.72fF
C226 T_1 FLASH_ADC_SYM_5_0/a_200_531# 0.10fF
C227 VSS T_7 5.04fF
C228 T_3 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.28fF
C229 T_3 FLASH_ADC_SYM_4_0/a_200_531# 0.09fF
C230 sky130_fd_sc_hd__fill_8_92/VPB T_6 0.05fF
C231 sky130_fd_sc_hd__or4_1_0/a_27_297# T_2 0.23fF
C232 FLASH_ADC_SYM_4_0/a_200_531# T_2 0.10fF
C233 VSS sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C234 VSS sky130_fd_sc_hd__fill_8_87/VPB 1.17fF
C235 Y2 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C236 T_4 Y2 0.89fF
C237 T_3 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C238 Y1 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.09fF
C239 sky130_fd_sc_hd__fill_8_92/VPB T_5 0.02fF
C240 sky130_fd_sc_hd__fill_8_1/VPB vin 0.35fF
C241 vin sky130_fd_sc_hd__fill_8_4/VPB 0.04fF
C242 vin VSS 6.71fF
C243 VDD T_3 4.60fF
C244 Y2 T_1 0.64fF
C245 VDD T_2 3.57fF
C246 T_3 FLASH_ADC_SYM_3_0/a_200_531# 0.34fF
C247 T_6 Y3 0.01fF
C248 T_3 FLASH_ADC_SYM_2_0/a_200_531# 0.24fF
C249 T_2 FLASH_ADC_SYM_3_0/a_200_531# 0.10fF
C250 VDD sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C251 T_2 FLASH_ADC_SYM_2_0/a_200_531# 0.39fF
C252 T_5 Y3 0.00fF
C253 sky130_fd_sc_hd__fill_8_92/VPB vin 0.00fF
C254 T_3 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C255 Y1 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.00fF
C256 Y3 T_7 0.03fF
C257 sky130_fd_sc_hd__fill_8_1/VPB VSS 1.25fF
C258 VSS sky130_fd_sc_hd__fill_8_4/VPB 1.46fF
C259 Y1 FLASH_ADC_SYM_4_0/a_200_531# 0.00fF
C260 sky130_fd_sc_hd__or4_1_0/a_277_297# sky130_fd_sc_hd__or4_1_0/a_27_297# 0.01fF
C261 FLASH_ADC_SYM_1_0/a_200_531# T_3 0.00fF
C262 T_4 FLASH_ADC_SYM_7_0/a_200_531# 0.01fF
C263 Y2 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C264 T_3 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C265 T_3 sky130_fd_sc_hd__fill_2_7/VPB 0.00fF
C266 FLASH_ADC_SYM_1_0/a_200_531# T_2 0.00fF
C267 T_3 T_6 0.19fF
Xsky130_fd_sc_hd__fill_8_97 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_86 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_42 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_53 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_31 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_64 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_75 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_20 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_44 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_33 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_11 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_22 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_1 VSS sky130_fd_sc_hd__fill_2_7/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_98 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_87 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_10 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_21 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_43 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_32 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_54 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_76 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_65 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_45 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_34 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_12 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_23 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_2 VSS sky130_fd_sc_hd__fill_8_4/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_88 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_11 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_44 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_33 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_55 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_77 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_66 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_22 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_99 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_70 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_2_46 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_35 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_13 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_24 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_3 VSS sky130_fd_sc_hd__fill_8_8/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_89 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_23 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_45 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_34 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_56 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_78 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_67 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_12 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_60 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_71 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_2_47 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_36 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_14 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_25 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_4 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_35 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_57 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_46 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_24 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_13 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_68 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_79 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_72 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_50 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_61 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_2_26 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_37 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_48 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_15 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_5 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_36 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_25 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_47 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_14 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_58 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_69 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_73 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_51 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_62 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_40 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_200 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_27 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_38 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_49 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_16 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_6 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_37 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_48 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_59 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_15 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_26 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_52 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_63 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_74 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_41 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_30 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_201 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_39 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_28 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_8_0 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_17 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_7 VSS sky130_fd_sc_hd__fill_8_1/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_38 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_49 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_27 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_16 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_75 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_64 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_42 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_31 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_20 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_53 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_202 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_1 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_29 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_18 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_8 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_17 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_28 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_39 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__decap_4_43 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_54 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_10 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_65 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_21 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_32 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_76 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_0 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_203 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_2 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_19 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_9 VSS sky130_fd_sc_hd__fill_2_7/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_18 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_29 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_30 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_66 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_55 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_77 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_22 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_33 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_11 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_44 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_1 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_204 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_3 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_19 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_31 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_20 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_67 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_45 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_56 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_23 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_34 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_12 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_2 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_205 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_4 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_10 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_21 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_32 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_46 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_68 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_57 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_35 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_13 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_24 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_3 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_206 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_5 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_22 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_33 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_11 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_69 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_58 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_47 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_14 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_25 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_36 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_4 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_207 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_6 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_0 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_23 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_12 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_59 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_26 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_37 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_15 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_48 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_5 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_7 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_1 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_24 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_13 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_38 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_49 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_16 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_27 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_6 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_8 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_2 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_25 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_14 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_39 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_17 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_28 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_7 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_8_9 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_3 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_190 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_0 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__tapvpwrvgnd_1_26 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_15 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_18 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__decap_4_29 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_8 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_4_4 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_180 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_191 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_1 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__tapvpwrvgnd_1_27 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_16 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__decap_4_19 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__tapvpwrvgnd_1_9 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_4_5 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_181 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_170 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_2 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_8_192 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_28 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_17 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_4_6 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_193 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_160 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_171 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_182 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_3 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__tapvpwrvgnd_1_29 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__tapvpwrvgnd_1_18 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_4_7 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_150 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_161 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_172 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_183 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_194 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__tapvpwrvgnd_1_19 VDD VSS sky130_fd_sc_hd__tapvpwrvgnd_1
Xsky130_fd_sc_hd__fill_2_4 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_40 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_4_8 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_184 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_151 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_162 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_173 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_140 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_195 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_5 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_41 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_30 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_4_9 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_163 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_152 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_174 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_141 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_130 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_196 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_185 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_6 VSS sky130_fd_sc_hd__fill_8_4/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_42 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_31 VSS sky130_fd_sc_hd__fill_8_93/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_20 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_8_164 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_153 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_20 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_120 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_131 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_175 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_142 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_186 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_197 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_7 VSS sky130_fd_sc_hd__fill_2_7/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_43 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_10 VSS sky130_fd_sc_hd__fill_8_4/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_32 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_21 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_4_21 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_4_10 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_165 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_154 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_143 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_176 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_132 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_110 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_121 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_8 VSS sky130_fd_sc_hd__fill_8_1/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_8_187 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_198 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_33 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_22 VSS sky130_fd_sc_hd__fill_8_92/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_44 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_11 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_0 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_155 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_166 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_22 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_100 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_177 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_122 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_144 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_199 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_133 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_111 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_188 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_11 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_2_9 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__or4_1_0 VDD VSS T_3 T_7 T_6 T_2 Y2 sky130_fd_sc_hd__or4_1
Xsky130_fd_sc_hd__fill_1_34 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_23 VSS sky130_fd_sc_hd__fill_8_87/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_12 VSS sky130_fd_sc_hd__fill_8_8/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_1 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_167 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_156 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_145 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_112 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_101 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_178 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_134 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_123 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_12 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_189 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__or4_1_1 VDD VSS T_7 T_1 T_5 T_3 Y1 sky130_fd_sc_hd__or4_1
Xsky130_fd_sc_hd__fill_1_24 VSS sky130_fd_sc_hd__fill_8_87/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_13 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_35 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_2 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_168 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_157 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_146 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_13 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_102 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_179 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_135 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_124 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_113 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__or4_1_2 VDD VSS T_7 T_5 T_4 T_6 Y3 sky130_fd_sc_hd__or4_1
Xsky130_fd_sc_hd__fill_1_25 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_36 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_14 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_3 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_158 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_169 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_14 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_103 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_125 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_147 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_136 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_114 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_37 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_15 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_26 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_4 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_90 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_15 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_159 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_148 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_104 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_126 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_137 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_115 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_38 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_27 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_16 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_5 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_91 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_80 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_149 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_116 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_16 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_127 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_138 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_105 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_39 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_28 VSS sky130_fd_sc_hd__fill_8_93/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_17 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_6 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_92 VSS sky130_fd_sc_hd__fill_8_92/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_81 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_70 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_128 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_117 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_17 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_106 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_139 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_29 VSS sky130_fd_sc_hd__fill_8_92/VPB VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_1_18 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__decap_4_7 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_82 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_93 VSS sky130_fd_sc_hd__fill_8_93/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_71 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_60 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_118 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_129 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_18 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_107 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_1_19 VSS VDD VDD VSS sky130_fd_sc_hd__fill_1
Xsky130_fd_sc_hd__fill_2_40 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__decap_4_8 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_94 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_83 VSS sky130_fd_sc_hd__fill_8_87/VPB VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_50 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_72 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_61 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_4_19 VSS VDD VSS VDD sky130_fd_sc_hd__fill_4
Xsky130_fd_sc_hd__fill_8_119 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_108 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_41 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_30 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__decap_4_9 VSS VDD sky130_fd_sc_hd__decap_4
Xsky130_fd_sc_hd__fill_8_84 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_95 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_40 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_51 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_62 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_73 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_109 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_42 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_31 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_20 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_8_41 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_52 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_30 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_85 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_63 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_96 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_8_74 VSS VDD VSS VDD sky130_fd_sc_hd__fill_8
Xsky130_fd_sc_hd__fill_2_43 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_10 VSS sky130_fd_sc_hd__fill_8_8/VPB VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_21 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_2_32 VSS VDD VSS VDD sky130_fd_sc_hd__fill_2
Xsky130_fd_sc_hd__fill_1_0 VSS sky130_fd_sc_hd__fill_8_1/VPB VDD VSS sky130_fd_sc_hd__fill_1
C268 VDD 0 217.43fF
C269 T_5 0 3.93fF
C270 Y1 0 3.10fF
C271 T_3 0 3.73fF
C272 VSS 0 43.12fF
C273 T_2 0 3.03fF
C274 T_4 0 0.73fF
C275 Y3 0 2.17fF
C276 T_1 0 2.12fF
C277 Y2 0 0.55fF
C278 FLASH_ADC_SYM_6_0/a_200_531# 0 1.07fF **FLOATING
C279 sky130_fd_sc_hd__fill_8_93/VPB 0 4.35fF
C280 sky130_fd_sc_hd__fill_8_1/VPB 0 4.35fF
C281 sky130_fd_sc_hd__fill_8_8/VPB 0 4.35fF
C282 FLASH_ADC_SYM_1_0/a_200_531# 0 0.07fF **FLOATING
C283 FLASH_ADC_SYM_3_0/a_200_531# 0 0.59fF **FLOATING
C284 FLASH_ADC_SYM_5_0/a_200_531# 0 0.42fF **FLOATING
C285 FLASH_ADC_SYM_7_0/a_200_531# 0 1.10fF **FLOATING
C286 sky130_fd_sc_hd__fill_8_92/VPB 0 4.35fF
C287 sky130_fd_sc_hd__fill_8_4/VPB 0 4.35fF
C288 sky130_fd_sc_hd__fill_8_87/VPB 0 4.35fF
C289 sky130_fd_sc_hd__fill_2_7/VPB 0 4.35fF
C290 FLASH_ADC_SYM_2_0/a_200_531# 0 0.68fF **FLOATING
C291 FLASH_ADC_SYM_4_0/a_200_531# 0 0.53fF **FLOATING
.ends
```
After extracting '.spice' file, manually **vin** and **VSS** pins are replaced with **VIN** and **GND** pins. Then, the `.control` statements are added and observed the post-layout simulation result.
```
* SPICE3 file created from flash_adc.ext - technology: sky130A

.subckt flash_adc T_1 T_6 T_7 VIN T_2 T_3 T_4 T_5 Y1 Y2 Y3 VDD GND
X0 T_4 FLASH_ADC_SYM_4_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.41903e+13p ps=4.3592e+08u w=840000u l=150000u
X1 VDD VIN FLASH_ADC_SYM_4_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=2.352e+11p ps=2.24e+06u w=840000u l=150000u
X2 VDD FLASH_ADC_SYM_4_0/a_200_531# T_4 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X3 T_4 FLASH_ADC_SYM_4_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=3.09329e+13p ps=3.3716e+08u w=1.68e+06u l=150000u
X4 GND FLASH_ADC_SYM_4_0/a_200_531# T_4 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X5 FLASH_ADC_SYM_4_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X6 GND VIN FLASH_ADC_SYM_4_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X7 FLASH_ADC_SYM_4_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X8 FLASH_ADC_SYM_2_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 GND VIN FLASH_ADC_SYM_2_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 FLASH_ADC_SYM_2_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=3.528e+11p pd=3.08e+06u as=0p ps=0u w=1.26e+06u l=150000u
X11 T_2 FLASH_ADC_SYM_2_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=3.528e+11p pd=3.08e+06u as=0p ps=0u w=1.26e+06u l=150000u
X12 VDD VIN FLASH_ADC_SYM_2_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X13 VDD FLASH_ADC_SYM_2_0/a_200_531# T_2 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.26e+06u l=150000u
X14 T_2 FLASH_ADC_SYM_2_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X15 GND FLASH_ADC_SYM_2_0/a_200_531# T_2 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X16 FLASH_ADC_SYM_7_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X17 FLASH_ADC_SYM_7_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X18 T_7 FLASH_ADC_SYM_7_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X19 GND VIN FLASH_ADC_SYM_7_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X20 VDD VIN FLASH_ADC_SYM_7_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X21 VDD FLASH_ADC_SYM_7_0/a_200_531# T_7 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X22 T_7 FLASH_ADC_SYM_7_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X23 GND FLASH_ADC_SYM_7_0/a_200_531# T_7 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X24 GND VIN FLASH_ADC_SYM_5_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=7.056e+11p ps=5.6e+06u w=2.52e+06u l=150000u
X25 FLASH_ADC_SYM_5_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X26 T_5 FLASH_ADC_SYM_5_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X27 VDD VIN FLASH_ADC_SYM_5_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X28 VDD FLASH_ADC_SYM_5_0/a_200_531# T_5 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X29 T_5 FLASH_ADC_SYM_5_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X30 GND FLASH_ADC_SYM_5_0/a_200_531# T_5 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X31 FLASH_ADC_SYM_5_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X32 T_3 FLASH_ADC_SYM_3_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X33 FLASH_ADC_SYM_3_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X34 GND FLASH_ADC_SYM_3_0/a_200_531# T_3 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X35 T_3 FLASH_ADC_SYM_3_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=4.704e+11p pd=3.92e+06u as=0p ps=0u w=1.68e+06u l=150000u
X36 VDD VIN FLASH_ADC_SYM_3_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X37 VDD FLASH_ADC_SYM_3_0/a_200_531# T_3 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.68e+06u l=150000u
X38 FLASH_ADC_SYM_3_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=0p ps=0u w=840000u l=150000u
X39 GND VIN FLASH_ADC_SYM_3_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X40 FLASH_ADC_SYM_1_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X41 GND VIN FLASH_ADC_SYM_1_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X42 FLASH_ADC_SYM_1_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X43 T_1 FLASH_ADC_SYM_1_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=7.056e+11p pd=5.6e+06u as=0p ps=0u w=2.52e+06u l=150000u
X44 VDD VIN FLASH_ADC_SYM_1_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X45 VDD FLASH_ADC_SYM_1_0/a_200_531# T_1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.52e+06u l=150000u
X46 T_1 FLASH_ADC_SYM_1_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X47 GND FLASH_ADC_SYM_1_0/a_200_531# T_1 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X48 GND FLASH_ADC_SYM_6_0/a_200_531# T_6 GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=1.764e+11p ps=1.82e+06u w=630000u l=150000u
X49 FLASH_ADC_SYM_6_0/a_200_531# VIN VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X50 T_6 FLASH_ADC_SYM_6_0/a_200_531# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X51 VDD VIN FLASH_ADC_SYM_6_0/a_200_531# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X52 FLASH_ADC_SYM_6_0/a_200_531# VIN GND GND sky130_fd_pr__nfet_01v8 ad=1.764e+11p pd=1.82e+06u as=0p ps=0u w=630000u l=150000u
X53 VDD FLASH_ADC_SYM_6_0/a_200_531# T_6 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X54 GND VIN FLASH_ADC_SYM_6_0/a_200_531# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
X55 T_6 FLASH_ADC_SYM_6_0/a_200_531# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=630000u l=150000u
C0 T_1 FLASH_ADC_SYM_7_0/a_200_531# 0.05fF
C1 FLASH_ADC_SYM_4_0/a_200_531# sky130_fd_sc_hd__fill_8_8/VPB 0.00fF
C2 VDD Y1 2.10fF
C3 sky130_fd_sc_hd__fill_2_7/VPB T_2 0.09fF
C4 T_6 T_2 0.33fF
C5 VDD sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C6 Y2 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.00fF
C7 T_3 T_5 0.21fF
C8 Y2 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C9 sky130_fd_sc_hd__fill_8_92/VPB GND 1.18fF
C10 T_6 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C11 T_3 T_7 0.44fF
C12 VDD sky130_fd_sc_hd__fill_8_8/VPB 1.64fF
C13 T_5 T_2 0.15fF
C14 sky130_fd_sc_hd__fill_8_93/VPB VDD 1.39fF
C15 T_7 T_2 0.12fF
C16 FLASH_ADC_SYM_6_0/a_200_531# VDD 2.93fF
C17 T_5 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C18 VDD FLASH_ADC_SYM_5_0/a_200_531# 3.17fF
C19 T_3 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C20 T_7 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C21 VIN T_3 0.51fF
C22 T_4 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C23 GND Y3 0.50fF
C24 Y2 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C25 Y2 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.09fF
C26 Y1 sky130_fd_sc_hd__fill_2_7/VPB 0.03fF
C27 Y1 T_6 0.01fF
C28 VIN T_2 0.45fF
C29 T_4 T_1 0.08fF
C30 sky130_fd_sc_hd__or4_1_0/a_277_297# T_6 0.00fF
C31 Y1 T_5 0.12fF
C32 VDD Y2 3.12fF
C33 Y1 T_7 0.01fF
C34 sky130_fd_sc_hd__fill_8_93/VPB T_6 0.00fF
C35 sky130_fd_sc_hd__or4_1_0/a_277_297# T_7 0.00fF
C36 FLASH_ADC_SYM_6_0/a_200_531# T_6 0.39fF
C37 sky130_fd_sc_hd__fill_8_1/VPB T_3 0.00fF
C38 T_3 sky130_fd_sc_hd__fill_8_4/VPB 0.01fF
C39 T_6 FLASH_ADC_SYM_5_0/a_200_531# 0.30fF
C40 GND T_3 4.20fF
C41 sky130_fd_sc_hd__fill_8_1/VPB T_2 0.08fF
C42 T_2 sky130_fd_sc_hd__fill_8_4/VPB 0.07fF
C43 GND T_2 2.40fF
C44 FLASH_ADC_SYM_6_0/a_200_531# T_5 0.11fF
C45 T_5 FLASH_ADC_SYM_5_0/a_200_531# 0.47fF
C46 VIN Y1 0.07fF
C47 FLASH_ADC_SYM_6_0/a_200_531# T_7 0.00fF
C48 T_4 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C49 GND sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C50 VIN sky130_fd_sc_hd__fill_8_8/VPB 0.34fF
C51 VDD FLASH_ADC_SYM_7_0/a_200_531# 2.95fF
C52 sky130_fd_sc_hd__or4_1_2/a_109_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C53 T_6 Y2 0.26fF
C54 sky130_fd_sc_hd__fill_8_87/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.01fF
C55 T_4 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.32fF
C56 FLASH_ADC_SYM_6_0/a_200_531# VIN 1.11fF
C57 T_1 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.06fF
C58 VIN FLASH_ADC_SYM_5_0/a_200_531# 0.57fF
C59 T_5 Y2 0.00fF
C60 sky130_fd_sc_hd__fill_8_1/VPB Y1 0.02fF
C61 Y1 sky130_fd_sc_hd__fill_8_4/VPB 0.01fF
C62 GND Y1 2.13fF
C63 Y2 T_7 0.32fF
C64 GND sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C65 GND sky130_fd_sc_hd__fill_8_8/VPB 1.40fF
C66 T_4 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C67 T_4 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.00fF
C68 FLASH_ADC_SYM_4_0/a_200_531# T_4 0.26fF
C69 sky130_fd_sc_hd__fill_8_93/VPB GND 1.18fF
C70 FLASH_ADC_SYM_6_0/a_200_531# GND 0.06fF
C71 T_6 FLASH_ADC_SYM_7_0/a_200_531# 0.05fF
C72 sky130_fd_sc_hd__or4_1_2/a_205_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.01fF
C73 VDD T_4 7.07fF
C74 T_5 FLASH_ADC_SYM_7_0/a_200_531# 0.11fF
C75 VDD T_1 5.19fF
C76 T_4 FLASH_ADC_SYM_3_0/a_200_531# 0.20fF
C77 T_3 T_2 3.00fF
C78 FLASH_ADC_SYM_7_0/a_200_531# T_7 0.37fF
C79 T_4 FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C80 sky130_fd_sc_hd__fill_8_92/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.01fF
C81 T_3 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C82 GND Y2 0.56fF
C83 T_2 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C84 VIN FLASH_ADC_SYM_7_0/a_200_531# 0.96fF
C85 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_1/a_27_297# 0.01fF
C86 T_6 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C87 T_4 T_6 0.36fF
C88 sky130_fd_sc_hd__or4_1_2/a_277_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.02fF
C89 FLASH_ADC_SYM_1_0/a_200_531# T_1 0.32fF
C90 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C91 T_3 Y1 1.41fF
C92 T_6 T_1 4.17fF
C93 T_5 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C94 T_4 T_5 0.47fF
C95 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_109_297# 0.02fF
C96 T_3 sky130_fd_sc_hd__or4_1_0/a_277_297# 0.00fF
C97 Y1 T_2 2.56fF
C98 T_7 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.01fF
C99 VDD sky130_fd_sc_hd__or4_1_1/a_27_297# 0.27fF
C100 T_4 T_7 0.39fF
C101 sky130_fd_sc_hd__or4_1_0/a_277_297# T_2 0.00fF
C102 VDD sky130_fd_sc_hd__or4_1_2/a_27_297# 0.25fF
C103 T_5 T_1 1.30fF
C104 T_3 sky130_fd_sc_hd__fill_8_8/VPB 0.01fF
C105 Y1 sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C106 GND FLASH_ADC_SYM_7_0/a_200_531# 0.02fF
C107 T_1 T_7 0.30fF
C108 sky130_fd_sc_hd__fill_8_8/VPB T_2 0.07fF
C109 Y2 Y3 1.66fF
C110 VIN T_4 1.00fF
C111 sky130_fd_sc_hd__fill_8_87/VPB T_1 0.11fF
C112 T_6 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C113 VDD sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C114 VIN T_1 0.38fF
C115 VDD sky130_fd_sc_hd__or4_1_0/a_27_297# 0.36fF
C116 VDD FLASH_ADC_SYM_4_0/a_200_531# 2.90fF
C117 T_5 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C118 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_205_297# 0.01fF
C119 T_6 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.03fF
C120 FLASH_ADC_SYM_4_0/a_200_531# FLASH_ADC_SYM_3_0/a_200_531# 0.00fF
C121 T_7 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C122 VDD sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C123 T_6 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.26fF
C124 T_3 Y2 0.11fF
C125 Y1 sky130_fd_sc_hd__fill_8_8/VPB 0.01fF
C126 T_5 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.32fF
C127 GND sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C128 Y2 T_2 0.01fF
C129 GND T_4 1.26fF
C130 T_5 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.08fF
C131 T_7 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.21fF
C132 VDD FLASH_ADC_SYM_3_0/a_200_531# 2.72fF
C133 T_7 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.47fF
C134 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_0/a_109_297# 0.02fF
C135 GND T_1 2.99fF
C136 VDD FLASH_ADC_SYM_2_0/a_200_531# 2.87fF
C137 FLASH_ADC_SYM_3_0/a_200_531# FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C138 T_6 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C139 T_6 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.22fF
C140 VDD sky130_fd_sc_hd__or4_1_0/a_109_297# 0.01fF
C141 sky130_fd_sc_hd__fill_8_93/VPB FLASH_ADC_SYM_5_0/a_200_531# 0.00fF
C142 T_5 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C143 VDD FLASH_ADC_SYM_1_0/a_200_531# 3.11fF
C144 FLASH_ADC_SYM_6_0/a_200_531# FLASH_ADC_SYM_5_0/a_200_531# 0.00fF
C145 T_5 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.01fF
C146 T_6 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C147 FLASH_ADC_SYM_4_0/a_200_531# T_5 0.01fF
C148 sky130_fd_sc_hd__fill_8_92/VPB T_1 0.14fF
C149 T_7 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C150 VDD sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C151 VDD sky130_fd_sc_hd__fill_2_7/VPB 1.31fF
C152 sky130_fd_sc_hd__or4_1_0/a_27_297# T_7 0.22fF
C153 VDD T_6 4.93fF
C154 T_5 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.01fF
C155 sky130_fd_sc_hd__or4_1_0/a_277_297# Y2 0.00fF
C156 FLASH_ADC_SYM_1_0/a_200_531# FLASH_ADC_SYM_2_0/a_200_531# 0.00fF
C157 GND sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C158 VDD T_5 5.05fF
C159 T_7 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C160 sky130_fd_sc_hd__or4_1_0/a_27_297# sky130_fd_sc_hd__or4_1_0/a_205_297# 0.01fF
C161 T_4 Y3 0.15fF
C162 VDD T_7 7.85fF
C163 T_5 FLASH_ADC_SYM_3_0/a_200_531# 0.02fF
C164 GND sky130_fd_sc_hd__or4_1_1/a_27_297# 0.36fF
C165 VIN FLASH_ADC_SYM_4_0/a_200_531# 1.11fF
C166 GND sky130_fd_sc_hd__or4_1_2/a_27_297# 0.36fF
C167 T_6 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C168 VDD sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C169 VDD sky130_fd_sc_hd__fill_8_87/VPB 1.82fF
C170 VDD VIN 19.19fF
C171 T_5 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C172 T_6 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C173 sky130_fd_sc_hd__or4_1_0/a_109_297# T_7 0.00fF
C174 T_3 T_4 0.11fF
C175 VIN FLASH_ADC_SYM_3_0/a_200_531# 1.09fF
C176 T_2 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C177 T_5 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C178 T_4 T_2 0.08fF
C179 VIN FLASH_ADC_SYM_2_0/a_200_531# 1.18fF
C180 GND sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C181 T_5 T_6 1.33fF
C182 T_3 T_1 0.00fF
C183 GND sky130_fd_sc_hd__or4_1_0/a_27_297# 0.28fF
C184 GND FLASH_ADC_SYM_4_0/a_200_531# 0.05fF
C185 T_7 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C186 T_6 T_7 0.87fF
C187 T_1 T_2 0.00fF
C188 FLASH_ADC_SYM_6_0/a_200_531# FLASH_ADC_SYM_7_0/a_200_531# 0.00fF
C189 GND sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C190 T_5 T_7 1.77fF
C191 sky130_fd_sc_hd__fill_8_1/VPB VDD 1.89fF
C192 VDD sky130_fd_sc_hd__fill_8_4/VPB 1.25fF
C193 VDD GND 146.38fF
C194 T_6 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C195 FLASH_ADC_SYM_1_0/a_200_531# VIN 0.56fF
C196 sky130_fd_sc_hd__fill_8_87/VPB T_6 0.20fF
C197 Y3 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.09fF
C198 VIN sky130_fd_sc_hd__fill_2_7/VPB 0.17fF
C199 GND FLASH_ADC_SYM_3_0/a_200_531# 0.06fF
C200 VIN T_6 0.42fF
C201 GND FLASH_ADC_SYM_2_0/a_200_531# 0.04fF
C202 T_5 sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C203 Y1 T_4 0.00fF
C204 sky130_fd_sc_hd__or4_1_0/a_205_297# T_7 0.00fF
C205 VIN T_5 0.70fF
C206 sky130_fd_sc_hd__fill_8_92/VPB VDD 1.36fF
C207 VIN T_7 0.10fF
C208 Y1 T_1 0.00fF
C209 GND sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C210 T_3 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.23fF
C211 T_4 sky130_fd_sc_hd__fill_8_8/VPB 0.00fF
C212 Y3 sky130_fd_sc_hd__or4_1_2/a_277_297# 0.00fF
C213 FLASH_ADC_SYM_1_0/a_200_531# GND 0.15fF
C214 T_3 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C215 T_2 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.01fF
C216 GND sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C217 GND sky130_fd_sc_hd__fill_2_7/VPB 1.39fF
C218 VIN sky130_fd_sc_hd__fill_8_87/VPB 0.00fF
C219 T_2 sky130_fd_sc_hd__or4_1_2/a_27_297# 0.00fF
C220 GND T_6 5.50fF
C221 sky130_fd_sc_hd__fill_8_93/VPB T_1 0.11fF
C222 sky130_fd_sc_hd__or4_1_1/a_27_297# sky130_fd_sc_hd__or4_1_1/a_277_297# 0.01fF
C223 FLASH_ADC_SYM_6_0/a_200_531# T_1 0.05fF
C224 VDD Y3 0.64fF
C225 GND T_5 1.72fF
C226 T_1 FLASH_ADC_SYM_5_0/a_200_531# 0.10fF
C227 GND T_7 5.04fF
C228 T_3 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.28fF
C229 T_3 FLASH_ADC_SYM_4_0/a_200_531# 0.09fF
C230 sky130_fd_sc_hd__fill_8_92/VPB T_6 0.05fF
C231 sky130_fd_sc_hd__or4_1_0/a_27_297# T_2 0.23fF
C232 FLASH_ADC_SYM_4_0/a_200_531# T_2 0.10fF
C233 GND sky130_fd_sc_hd__or4_1_0/a_205_297# 0.00fF
C234 GND sky130_fd_sc_hd__fill_8_87/VPB 1.17fF
C235 Y2 sky130_fd_sc_hd__or4_1_2/a_109_297# 0.00fF
C236 T_4 Y2 0.89fF
C237 T_3 sky130_fd_sc_hd__or4_1_1/a_109_297# 0.00fF
C238 Y1 sky130_fd_sc_hd__or4_1_1/a_27_297# 0.09fF
C239 sky130_fd_sc_hd__fill_8_92/VPB T_5 0.02fF
C240 sky130_fd_sc_hd__fill_8_1/VPB VIN 0.35fF
C241 VIN sky130_fd_sc_hd__fill_8_4/VPB 0.04fF
C242 VIN GND 6.71fF
C243 VDD T_3 4.60fF
C244 Y2 T_1 0.64fF
C245 VDD T_2 3.57fF
C246 T_3 FLASH_ADC_SYM_3_0/a_200_531# 0.34fF
C247 T_6 Y3 0.01fF
C248 T_3 FLASH_ADC_SYM_2_0/a_200_531# 0.24fF
C249 T_2 FLASH_ADC_SYM_3_0/a_200_531# 0.10fF
C250 VDD sky130_fd_sc_hd__or4_1_1/a_277_297# 0.00fF
C251 T_2 FLASH_ADC_SYM_2_0/a_200_531# 0.39fF
C252 T_5 Y3 0.00fF
C253 sky130_fd_sc_hd__fill_8_92/VPB VIN 0.00fF
C254 T_3 sky130_fd_sc_hd__or4_1_0/a_109_297# 0.00fF
C255 Y1 sky130_fd_sc_hd__or4_1_0/a_27_297# 0.00fF
C256 Y3 T_7 0.03fF
C257 sky130_fd_sc_hd__fill_8_1/VPB GND 1.25fF
C258 GND sky130_fd_sc_hd__fill_8_4/VPB 1.46fF
C259 Y1 FLASH_ADC_SYM_4_0/a_200_531# 0.00fF
C260 sky130_fd_sc_hd__or4_1_0/a_277_297# sky130_fd_sc_hd__or4_1_0/a_27_297# 0.01fF
C261 FLASH_ADC_SYM_1_0/a_200_531# T_3 0.00fF
C262 T_4 FLASH_ADC_SYM_7_0/a_200_531# 0.01fF
C263 Y2 sky130_fd_sc_hd__or4_1_2/a_205_297# 0.00fF
C264 T_3 sky130_fd_sc_hd__or4_1_1/a_205_297# 0.00fF
C265 T_3 sky130_fd_sc_hd__fill_2_7/VPB 0.00fF
C266 FLASH_ADC_SYM_1_0/a_200_531# T_2 0.00fF
C267 T_3 T_6 0.19fF
C268 VDD 0 217.43fF
C269 T_5 0 3.93fF
C270 Y1 0 3.10fF
C271 T_3 0 3.73fF
C272 GND 0 43.12fF
C273 T_2 0 3.03fF
C274 T_4 0 0.73fF
C275 Y3 0 2.17fF
C276 T_1 0 2.12fF
C277 Y2 0 0.55fF
C278 FLASH_ADC_SYM_6_0/a_200_531# 0 1.07fF
C279 sky130_fd_sc_hd__fill_8_93/VPB 0 4.35fF
C280 sky130_fd_sc_hd__fill_8_1/VPB 0 4.35fF
C281 sky130_fd_sc_hd__fill_8_8/VPB 0 4.35fF
C282 FLASH_ADC_SYM_1_0/a_200_531# 0 0.07fF
C283 FLASH_ADC_SYM_3_0/a_200_531# 0 0.59fF
C284 FLASH_ADC_SYM_5_0/a_200_531# 0 0.42fF
C285 FLASH_ADC_SYM_7_0/a_200_531# 0 1.10fF
C286 sky130_fd_sc_hd__fill_8_92/VPB 0 4.35fF
C287 sky130_fd_sc_hd__fill_8_4/VPB 0 4.35fF
C288 sky130_fd_sc_hd__fill_8_87/VPB 0 4.35fF
C289 sky130_fd_sc_hd__fill_2_7/VPB 0 4.35fF
C290 FLASH_ADC_SYM_2_0/a_200_531# 0 0.68fF
C291 FLASH_ADC_SYM_4_0/a_200_531# 0 0.53fF
.ends




*===============MANUALLY ADDED=========================
V1 VDD GND 1.8
.save i(v1)
V2 VIN GND sin(0 2 40Meg)
.save i(v2)
x1 T_1 T_6 T_7 VIN T_2 T_3 T_4 T_5 Y1 Y2 Y3 VDD GND flash_adc

**** begin user architecture code
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.save all

.tran 0.001n 25n
.control
run
plot VIN VDD T_1 T_2 T_3 T_4 T_5 T_6 T_7
plot Y1 Y2+1.5 Y3+3
.save all
.endc
.end

**** end user architecture code
**.ends
```

**NgSpice Plot**

![Z13](https://user-images.githubusercontent.com/114692581/233769153-f8a3603b-f3ca-45b3-83a2-a5eb97ebf529.PNG)

![Z14](https://user-images.githubusercontent.com/114692581/233769163-d462357e-e12a-46a1-9dca-d590621485e3.PNG)

Transient analysis for 60ns with 0.001ns,

![Z15](https://user-images.githubusercontent.com/114692581/233769830-81d61aa9-aaba-4abf-9970-e766baa3f08b.PNG)


