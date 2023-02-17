* [Week 1](#Week-1)
  - [Inverter Post-layout characterization using ALIGN tool](#Inverter-Post-layout-characterization-using-ALIGN-tool)
    - [Generated .lef and .gds files in KLayout](#Generated-.lef-and-.gds-files-in-KLayout)
    
    
# Inverter Post-layout characterization using ALIGN tool
Everytime start the ALIGN tool by running the following commands.
```
$ python3 -m venv general
$ source general/bin/activate
```
Then, go to ALIGN-public directory,
```
$ mkdir work
$ cd work
```
Running the inverter pre-layout spice netlist on Sky130pdk,
```
schematic2layout.py ../ALIGN-pdk-sky130/examples/Inverter -p ../pdks/SKY130_PDK/
```
A simple SPICE Netlist for inverter is written to generate .lef and .gds files,
```
.subckt Inverter_sym vdd OUT IN gnd

XPMOS OUT IN vdd vdd sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XNMOS OUT IN gnd gnd sky130_fd_pr__nfet_01v8 L=150n W=630n nf=2
.ends
.end
```

![AL1](https://user-images.githubusercontent.com/114692581/219681953-f12afe7f-9225-4fad-aa02-79ac3b1a9666.PNG)

![AL2](https://user-images.githubusercontent.com/114692581/219681985-03b70156-38d2-477a-8995-5468196b7505.PNG)

To extract the spice netlist of above post-layout go to MAGIC tool and read the .gds file.
Open magic tool and `go to file --> read GDS --> open the .gds file` and view the layout in magic tool.



## Generated .lef and .gds files in KLayout
* **.gds**
  
  ![AL3](https://user-images.githubusercontent.com/114692581/219683181-61a574ed-74c1-4856-8236-c8b3e8fadf41.PNG)
  
* **.lef**
  
  ![AL4](https://user-images.githubusercontent.com/114692581/219683450-50499c01-f503-4be7-a3dd-5f3db415785d.PNG)

    

