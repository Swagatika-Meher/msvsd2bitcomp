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

1. Go to OpenFASOC install directory `~/openfasoc/openfasoc/generators`. Create a new folder with your design name. Here, my design name is `flash-adc-gen`.
2. Place your dummy verilog code inside `/flash-adc-gen/src/`.
3. To run verilog generation, `cd` into `openfasoc/generators/flash-adc-gen/` and execute the command `$ make sky130hd_ADC_verilog`.
4. 
