v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1000 -310 1000 -280 {
lab=Vdd}
N 1000 -220 1000 -180 {
lab=INN}
N 980 -310 1000 -310 {
lab=Vdd}
N 1270 -310 1270 -280 {
lab=INP}
N 1270 -220 1270 -180 {
lab=GND}
N 1250 -310 1270 -310 {
lab=INP}
N 1120 -310 1120 -280 {
lab=INN}
N 1120 -220 1120 -180 {
lab=GND}
N 910 -520 1000 -520 {
lab=Vdd}
N 910 -500 1000 -500 {
lab=OUT}
N 910 -480 1000 -480 {
lab=INP}
N 910 -460 1000 -460 {
lab=INN}
N 910 -440 1000 -440 {
lab=#net1}
C {devices/code.sym} 590 -300 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/code_shown.sym} 740 -300 0 0 {name=SPICE only_toplevel=false value="
.tran 0.1n 100n
.control
run
plot INN INP OUT   
.save all
.endc
.end
"}
C {devices/vsource.sym} 1000 -250 0 0 {name=V2 value=1.8}
C {devices/iopin.sym} 980 -310 2 0 {name=p3 lab=Vdd}
C {devices/vsource.sym} 1270 -250 0 0 {name=V3 value="sin(0.9 0.9 50Meg)"}
C {devices/iopin.sym} 1250 -310 2 0 {name=p6 lab=INP}
C {devices/vsource.sym} 1120 -250 0 0 {name=V1 value=0.9}
C {devices/iopin.sym} 1120 -310 2 0 {name=p2 lab=INN}
C {devices/iopin.sym} 1000 -520 0 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} 1000 -480 0 0 {name=p4 lab=INP}
C {devices/iopin.sym} 1000 -460 0 0 {name=p5 lab=INN}
C {devices/iopin.sym} 1000 -500 0 0 {name=p7 lab=OUT}
C {/home/swagatika/Desktop/Circuits/1_bit_ADC_sym.sym} 760 -480 0 0 {name=x1}
C {devices/iopin.sym} 1000 -180 0 0 {name=p8 lab=GND}
C {devices/iopin.sym} 1120 -180 0 0 {name=p9 lab=GND}
C {devices/iopin.sym} 1270 -180 0 0 {name=p10 lab=GND}
C {devices/iopin.sym} 1000 -440 0 0 {name=p11 lab=GND}
