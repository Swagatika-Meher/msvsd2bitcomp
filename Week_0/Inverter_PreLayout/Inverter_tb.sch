v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -1110 -430 -1110 -390 {
lab=GND}
N -1370 -440 -1370 -380 {
lab=GND}
N -1460 -630 -1110 -630 {
lab=VDD}
N -1460 -340 -1300 -340 {
lab=GND}
N -1300 -340 -1110 -340 {
lab=GND}
N -1110 -390 -1110 -340 {
lab=GND}
N -1370 -380 -1370 -340 {
lab=GND}
N -1460 -630 -1460 -490 {
lab=VDD}
N -1370 -530 -1370 -500 {
lab=Vin}
N -1460 -430 -1460 -340 {
lab=GND}
N -1110 -340 -1070 -340 {
lab=GND}
N -1250 -560 -1250 -530 {
lab=Vin}
N -1140 -650 -1140 -630 {
lab=VDD}
N -1140 -670 -1140 -650 {
lab=VDD}
N -910 -510 -840 -510 {
lab=Vout}
N -1110 -630 -910 -630 {
lab=VDD}
N -910 -490 -910 -430 {
lab=GND}
N -1110 -430 -910 -430 {
lab=GND}
N -1370 -530 -1210 -530 {
lab=Vin}
N -910 -630 -910 -530 {
lab=VDD}
C {devices/code.sym} -910 -770 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/code_shown.sym} -770 -770 0 0 {name=SPICE only_toplevel=false value="
.tran 1n 30n
.control
run
set color0=white
set color1=black
plot Vin Vout
set xbrushwidth=3
.save all
.endc
.end
"}
C {devices/vsource.sym} -1370 -470 0 0 {name=V1
value="pulse(0 1.8 0ns 1ns 1ns 5ns 10ns)"}
C {devices/vsource.sym} -1460 -460 0 0 {name=VDD value=1.8}
C {devices/gnd.sym} -1070 -340 0 0 {name=l1 lab=GND}
C {devices/ipin.sym} -1250 -560 1 0 {name=Vin lab=Vin}
C {devices/vdd.sym} -1140 -670 0 0 {name=l2 lab=VDD}
C {devices/opin.sym} -840 -510 0 0 {name=Vout lab=Vout}
C {/home/swagatika/Desktop/Circuits/Inverter_sym.sym} -1060 -510 0 0 {name=x1}
