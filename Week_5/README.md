# OpenFASOC flow for 4-Bit Asynchronous Up Counter
Refer this [repo](https://github.com/syedimaduddin/4-bit_Asynchronous_Up_Counter_using_Mixed-Signal). In this design, the analog block contains ring oscillator and 1-bit analog to digital converter and the digital block contains four T-flipflops.

The pre-layout and post-layout of analog block ([Ring Oscillator](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_3) and [1-bit ADC](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_4)) is already discussed in previous weeks. In this section, we are going to explain OpenFASOC flow for 4-Bit Asynchronous Up Counter.

The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:
1. RINGOSCILLATOR
2. 1BITADC

The `.gds` and `.lef` files of RINGOSCILLATOR and 1BITADC cells are created and discussed in previous weeks before the start of the Generator flow.

First, we need to create **dummy verilog code** for TOP-LEVEL design.
```
module asyn_up_counter
(
	input Vn_Vref, output adc_OUT
	);

	wire ring_adc;
	
	//Instantiating ring oscillator
	ANALOG_ring_osci ring_osci(
		.ring(ring_adc),
	);

        //Instantiating 1-bit ADC
	ANALOG_1bit_adc adc(
	        .Vp(ring_adc),
	        .Vn(Vn_Vref),
	        .OUT(adc_OUT)
	);

endmodule

//Define ring oscillator module
module ANALOG_ring_osci
(
        inout ring
	);
endmodule

//Define 1-bit adc module
module ANALOG_1bit_adc
(
        input Vp,
	input Vn,
	output OUT
	);
endmodule
```

To configure circuit specifications, modify the `test.json` specfile in the `generators/asynchronous-up-counter-gen/` folder.

**test.json**

```
{
    "module_name": "asyn_up_counter",
    "generator": "asynchronous-up-counter-gen",
    "specifications": {
    	"frequency": { "min": 5, "max": 50 },
    	"model" :"modelfile.csv"
	}
}
```
The default circuit’s physical design generation can be divided into three parts,
1. Verilog generation
2. RTL-to-GDS flow (OpenROAD)
3. Post-layout verification (DRC and LVS)

## 1. Verilog Generation
To run verilog generation, `cd` into `openfasoc/generators/asynchronous-up-counter-gen/` and execute the following command.
```
$ export PDK_ROOT=/usr/local/share/pdk
$ make sky130hd_AUC_verilog
```

![Q1](https://user-images.githubusercontent.com/114692581/225987253-098a613b-fb0c-412f-8812-2544d5e7eb3f.PNG)

**SYNTHESIS**

For completeing the process like floorplan, routing, placement and the like, OpenRoad Flow is used. The OpenROAD Flow starts with a flow configuration file `config.mk`, the chosen platform (sky130hd) and the Verilog files are generated from the previous part. Execute the below command.
```
$ make sky130hd_AUC
```
I am getting the below mentioned error in synthesis step. [work in progress]

![Q2](https://user-images.githubusercontent.com/114692581/225999844-45f235d0-326d-4299-80a6-1ed89ce4c01b.PNG)

