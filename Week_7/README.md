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

