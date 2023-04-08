# INDEX
* [Week 5](#Week-5)
  * [OpenFASOC flow for 4-Bit Asynchronous Up Counter](#OpenFASOC-flow-for-4-Bit-Asynchronous-Up-Counter)
    * [Steps for OpenFASOC flow](#Steps-for-OpenFASOC-flow)
    * [OpenROAD GUI view](#OpenROAD-GUI-view)
    * [Final .gds file in KLayout (without power connection)](#Final-.gds-file-in-KLayout-without-power-connection)
    * [Power Delivery Network (VDD and GND connection)](#Power-Delivery-Network-VDD-and-GND-connection)
    * [Final .gds file in KLayout (with power connection)](#Final-.gds-file-in-KLayout-with-power-connection)
  * [Conclusion](#Conclusion)
  
  
# OpenFASOC flow for 4-Bit Asynchronous Up Counter
Refer this [repo](https://github.com/syedimaduddin/4-bit_Asynchronous_Up_Counter_using_Mixed-Signal). In this design, the analog block contains ring oscillator and 1-bit analog to digital converter and the digital block contains four T-flipflops.

The pre-layout and post-layout of analog block ([Ring Oscillator](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_3) and [1-bit ADC](https://github.com/Swagatika-Meher/msvsd2bitcomp/tree/main/Week_4)) is already discussed in previous weeks. In this section, we are going to explain OpenFASOC flow for 4-Bit Asynchronous Up Counter.

The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:
1. RINGOSCILLATOR
2. ONE_BIT_ADC

First, we need to create **dummy verilog code** for TOP-LEVEL design.
```ruby
module asyn_up_counter
(
	input Vn_Vref, output OUT_ADC
	);

	wire RO_ADC;
	
	//Instantiating ring oscillator
	RINGOSCILLATOR ring_osci(
		.INP(RO_ADC)
	);

        //Instantiating 1-bit ADC
	ONE_BIT_ADC adc(
	        .INN(Vn_Vref),
	        .INP(RO_ADC),
	        .OUT(OUT_ADC)
	);

endmodule
```

**RingOscillator**

```js
//Define ring oscillator module
module RINGOSCILLATOR
(
        output INP,
	);
endmodule
```

**1 bit ADC**

```js
//Define 1-bit adc module
module ONE_BIT_ADC
(
        input INN,
	input INP,
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
 
![P4](https://user-images.githubusercontent.com/114692581/229140056-c14ec7dc-1408-4b1c-83a6-bfac08a8eb4d.PNG)
 
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
```ruby
export DESIGN_NICKNAME = asyn_up_counter
export DESIGN_NAME = asyn_up_counter

export PLATFORM    = sky130hd

export VERILOG_FILES 		= $(sort $(wildcard ./design/src/$(DESIGN_NICKNAME)/*.v)) \
#			  	  ../blocks/$(PLATFORM)/asyn_up_counter.blackbox.v
export SDC_FILE    		= ./design/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export DIE_AREA   	 	= 0 0 90 80
export CORE_AREA   		= 10 10 80 70

# area of the smaller voltage domain
#export VD1_AREA                 = 50 40 200 190

# power delivery network config file
export PDN_TCL 			= ../blocks/$(PLATFORM)/pdn.tcl

export ADDITIONAL_LEFS  	= ../blocks/$(PLATFORM)/lef/RINGOSCILLATOR.lef \
                        	  ../blocks/$(PLATFORM)/lef/ONE_BIT_ADC.lef

export ADDITIONAL_GDS_FILES 	= ../blocks/$(PLATFORM)/gds/RINGOSCILLATOR.gds \
			      	  ../blocks/$(PLATFORM)/gds/ONE_BIT_ADC.gds

# informs what cells should be placed in the smaller voltage domain
export DOMAIN_INSTS_LIST 	= ../blocks/$(PLATFORM)/asyn_up_counter_domain_insts.txt

# configuration for placement
export MACRO_PLACE_HALO         = 1 1
export MACRO_PLACE_CHANNEL      = 15 15
export MACRO_PLACEMENT          = ../blocks/$(PLATFORM)/manual_macro.tcl

# export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 1
# export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 0
# don't run global place w/o IOs
#export HAS_IO_CONSTRAINTS = 1
# don't run non-random IO placement (step 3_2)
export PLACE_PINS_ARGS = -random

export GPL_ROUTABILITY_DRIVEN = 1

# DPO optimization currently fails on the asyn_up_counter
export ENABLE_DPO = 0

# export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 4
# export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2

# configuration for routing

#export PRE_GLOBAL_ROUTE = $(SCRIPTS_DIR)/openfasoc/pre_global_route.tcl

# informs any short circuits that should be forced during routing
export CUSTOM_CONNECTION 	= ../blocks/$(PLATFORM)/asyn_up_counter_custom_net.txt

# indicates with how many connections the VIN route from the HEADER cells connects to the VIN power ring
export VIN_ROUTE_CONNECTION_POINTS = 3
```

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

![P6](https://user-images.githubusercontent.com/114692581/229141482-9e0dd784-493a-41f1-95ef-e556e5cf5060.PNG)

This command is only used to copy the verilog files from `/src` directory to `/flow/design/src/asyn_up_counter/`.

For completeing the process like floorplan, routing, placement and the like, OpenRoad Flow is used. The OpenROAD Flow starts with a flow configuration file `config.mk`, the chosen platform (sky130hd) and the Verilog files are generated from the previous part. 

Either execute the `make sky130hd_AUC_build` command in `openfasoc/generators/asynchronous-up-counter-gen/` or you can check the entire flow in each step by going to `/flow` directory and execute the below commands. 

**2. SYNTHESIS**

Go to `/flow` directory and execute the below command.
```
$ make synth
```

![P7](https://user-images.githubusercontent.com/114692581/229142727-789e59b2-560d-4875-8e11-4fee1d5ceda4.PNG)

![P8](https://user-images.githubusercontent.com/114692581/229142781-e30530c5-f31b-4ca1-898f-cb766e486f65.PNG)

This command is used to generate synthesized verilog code. Go to `/results/` directory and check the generated synthesized verilog code.
```ruby
/* Generated by Yosys 0.26+53 (git sha1 8216b23fb, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module asyn_up_counter(Vn_Vref, OUT_ADC);
  output OUT_ADC;
  wire OUT_ADC;
  wire RO_ADC;
  input Vn_Vref;
  wire Vn_Vref;
  ONE_BIT_ADC adc (
    .INN(Vn_Vref),
    .INP(RO_ADC),
    .OUT(OUT_ADC)
  );
  RINGOSCILLATOR ring_osci (
    .INP(RO_ADC)
  );
endmodule
```
**3. FLOORPLAN**

Execute the below command in the same `/flow` directory.
```
$ make floorplan
```

![P9](https://user-images.githubusercontent.com/114692581/229144571-8edcddc5-c4db-435f-a224-e7eb92a50cf1.PNG)

![P10](https://user-images.githubusercontent.com/114692581/229144607-34a38a23-006e-4722-8ccb-429f5eb2aec4.PNG)

![P11](https://user-images.githubusercontent.com/114692581/229144640-fa258126-07dd-4f30-bae5-ed83cf0fb55d.PNG)

Execute `make gui_floorplan` command to open the design in OpenROAD GUI after floorplan.

![P12](https://user-images.githubusercontent.com/114692581/229147650-ad8ff737-0398-4cd9-afd5-3af0a2b784b6.PNG)

**4. GLOBAL PLACE**

Execute the below command for placement.
```
$ make place
```

![P13](https://user-images.githubusercontent.com/114692581/229149002-fe8276cb-1031-448d-9d70-399596174ea5.PNG)

![P14](https://user-images.githubusercontent.com/114692581/229149056-b52173ef-464e-40c6-8888-d29f3a512947.PNG)

![P15](https://user-images.githubusercontent.com/114692581/229149107-bfd16f90-5131-4835-b55c-ead83f456c8e.PNG)

![P16](https://user-images.githubusercontent.com/114692581/229149153-1b3d5a81-6c60-4d6b-ad93-21fe09ba9220.PNG)

Execute `make gui_place` command to open the design in OpenROAD GUI after placement.

![P17](https://user-images.githubusercontent.com/114692581/229149786-923f42ba-80ad-4865-b2eb-40a278303984.PNG)

**5. GLOBAL ROUTE**

Execute the below command for routing.
```
$ make route
```

![P18](https://user-images.githubusercontent.com/114692581/229152368-27cdb21c-ae69-43c5-9e57-928b10c0ddeb.PNG)

![P19](https://user-images.githubusercontent.com/114692581/229152409-4751d515-61c9-4064-a9f0-1ae7a9e4b494.PNG)

![P20](https://user-images.githubusercontent.com/114692581/229152433-b36074ee-66b4-4e1e-9e3a-97bb9a0cdbd2.PNG)

Execute `make gui_route` command to open the design in OpenROAD GUI after routing.

![P21](https://user-images.githubusercontent.com/114692581/229153019-fd6d2f91-0c7e-4770-a49b-a01116b82f29.PNG)

**6. Finish OpenFasoc flow**

Execute the below command to run the whole RTL-to-GDS flow.
```
$ make finish
```

![P22](https://user-images.githubusercontent.com/114692581/229157957-9afc9c03-d8b1-444e-a14a-0561be2813fb.PNG)

![P23](https://user-images.githubusercontent.com/114692581/229158010-524ac6fd-1ea9-4e14-8c19-6d24d35f9084.PNG)

**7. DRC Check**

DRC is clean.

![P24](https://user-images.githubusercontent.com/114692581/229158869-e49eb68d-e059-47cd-9254-0e78856256dc.PNG)

After successful completion of OpenFasoc flow, final files are generated in `/flow/results/` and `/work` directories.

![P25](https://user-images.githubusercontent.com/114692581/229159866-5dbd54de-05fb-4876-86fc-aab0ef0a0518.PNG)

![P26](https://user-images.githubusercontent.com/114692581/229159913-863d1e16-de63-4238-bb1c-f3890eeb8bf6.PNG)

## OpenROAD GUI view

![P27](https://user-images.githubusercontent.com/114692581/229161502-56b68b53-430d-4c04-8175-6167fe5c772e.PNG)

## Final .gds file in KLayout (without power connection)

![P28](https://user-images.githubusercontent.com/114692581/229161633-6dc613bb-bb48-4d7d-b326-0a27f4f44bad.PNG)

> **NOTE :**
> 1. For .lef files, remove the hierarchy and place the whole layout in (0,0) origin. Then, regenerate the .lef files for correct placement in OpenFasoc flow.
> 2. Before macro placement, initially the die area was `0 0 400 400` and core area was `10 10 380 380`. Then, macros are placed that is, ring_osci in [27, 25] and adc in [52, 40] co-ordinates. After successfull placement of macros, the final die area and core area reduced to `0 0 90 80` and `10 10 80 70`.
> 3. For power delivery network, `pdn.tcl` file needs to be set up correctly. This step is yet to be figured out.

# Power Delivery Network (VDD and GND connection)
For making the power pins connection to the macros, `pdn.tcl`, `config.mk`, `pre_global_route.tcl` files need to be editted manually. After setting up power connections and layout dimensions, final layout has been observed in KLayout.

For entire OpenFasoc flow, all the files for final `.gds` layout can be found [here](https://github.com/Swagatika-Meher/msvsd2bitcomp/blob/main/Week_5/OpenFasoc_flow/asynchronous-up-counter-gen.zip).

## Final .gds file in KLayout (with power connection)

**DRC Clean**

![P29](https://user-images.githubusercontent.com/114692581/230717228-33f09d6e-6948-4144-ad40-6f11f84a75cc.PNG)

**Final GDS**

![P30](https://user-images.githubusercontent.com/114692581/230717235-e2fde639-1f5f-4a73-8b4c-061401935e61.PNG)

## Conclusion
RTL to GDS flow is successfully completed using OpenFasoc.
















