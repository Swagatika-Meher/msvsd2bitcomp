# OpenFASOC flow for 4-Bit Asynchronous Up Counter
Refer this [repo](https://github.com/syedimaduddin/4-bit_Asynchronous_Up_Counter_using_Mixed-Signal). In this design, the analog block contains ring oscillator and 1-bit analog to digital converter and the digital block contains four T-flipflops.

The pre-layout and post-layout of analog block ([Ring Oscillator](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_3) and [1-bit ADC](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_4)) is already discussed in previous weeks. In this section, we are going to explain OpenFASOC flow for 4-Bit Asynchronous Up Counter.

The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:
1. RINGOSCILLATOR
2. 1BITADC

First, we need to create **dummy verilog code** for TOP-LEVEL design.
```ruby
module asyn_up_counter
(
	input Vn_Vref, output OUT_ADC
	);

	wire RO_ADC;
	
	//Instantiating ring oscillator
	RINGOSCILLATOR ring_osci(
		.INP(RO_ADC),
	);

        //Instantiating 1-bit ADC
	ADC comparator(
	        .INP(RO_ADC),
	        .INN(Vn_Vref),
	        .OUT(OUT_ADC)
	);

endmodule
```

**RingOscillator**

```js
//Define ring oscillator module
module RINGOSCILLATOR
(
        output INP
	);
endmodule
```

**1 bit ADC**

```js
//Define 1-bit adc module
module ADC
(
        input INP,
	input INN,
	output OUT
	);
endmodule
```
# Steps for OpenFASOC flow

Go to OpenFASOC install directory `~/openfasoc/openfasoc/generators`. Create a new folder with your design name. Here, my design name is `asynchronous-up-counter-gen`.

![P1](https://user-images.githubusercontent.com/114692581/227555974-3442a287-9392-4b8e-9835-f8059f73d5f0.PNG)

These folders are inside the `asynchronous-up-counter-gen`. 

![P2](https://user-images.githubusercontent.com/114692581/227556539-e6aef913-f16e-4562-8889-88e79d64358c.PNG)

> **NOTE :**
> 
Your folder name and the `.py` file name should be same, which are located inside `/asynchronous-up-counter-gen/tools/`.

![P3](https://user-images.githubusercontent.com/114692581/227557754-bfe0b8ce-59b1-4b22-8d48-f9c1325335a2.PNG)
 
Place your dummy verilog code inside `/asynchronous-up-counter-gen/src/`.
 
![P4](https://user-images.githubusercontent.com/114692581/227558388-bf9d7454-dae3-41f2-aa1b-34a7498e7178.PNG)
 
To configure circuit specifications, modify the `test.json` specfile in the `/asynchronous-up-counter-gen/` folder. 
```ruby
{
"module_name": "asyn_up_counter",
"generator": "asynchronous-up-counter-gen",
"specifications": {
"frequency": { "min": 5, "max": 50 },
"model" :"modelfile.csv"
}
}
```
Go to `/asynchronous-up-counter-gen/flow/design/sky130hd/asyn_up_counter/config.mk/` and keep your design name **same** as your top level module name.

![P5](https://user-images.githubusercontent.com/114692581/227561227-59e99604-9a04-4e90-9d90-e9530b871a04.PNG)

Once set the files as mentioned above, first run below commands to avoid **PDK_ROOT** path errors.
```
$ export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
$ export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
$ export PDK_ROOT=/home/swagatika/open_pdks/sky130/
``` 
**1. Verilog Generation**

To run verilog generation, `cd` into `openfasoc/generators/asynchronous-up-counter-gen/` and execute the following command.
```
$ make sky130hd_AUC_verilog
```

![P6](https://user-images.githubusercontent.com/114692581/227569913-5cee64e5-778d-4e6e-b5c6-ef889ba2e5e6.PNG)

**2. SYNTHESIS**

For completeing the process like floorplan, routing, placement and the like, OpenRoad Flow is used. The OpenROAD Flow starts with a flow configuration file `config.mk`, the chosen platform (sky130hd) and the Verilog files are generated from the previous part. Go to `/flow` directory and execute the below command.
```
$ make synth
```


