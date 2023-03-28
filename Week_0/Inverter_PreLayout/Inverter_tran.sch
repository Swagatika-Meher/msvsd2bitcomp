v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -660 -390 -600 -390 {
lab=Vin}
N -660 -390 -660 -260 {
lab=Vin}
N -660 -260 -600 -260 {
lab=Vin}
N -560 -360 -560 -290 {
lab=Vout}
N -560 -320 -510 -320 {
lab=Vout}
N -710 -320 -660 -320 {
lab=Vin}
N -560 -450 -560 -420 {
lab=VDD}
N -560 -390 -480 -390 {
lab=VDD}
N -480 -430 -480 -390 {
lab=VDD}
N -560 -430 -480 -430 {
lab=VDD}
N -560 -260 -480 -260 {
lab=GND}
N -480 -260 -480 -210 {
lab=GND}
N -560 -210 -480 -210 {
lab=GND}
N -560 -230 -560 -190 {
lab=GND}
N -750 -320 -710 -320 {
lab=Vin}
N -770 -320 -750 -320 {
lab=Vin}
N -510 -320 -490 -320 {
lab=Vout}
N -790 -320 -770 -320 {
lab=Vin}
N -490 -320 -470 -320 {
lab=Vout}
N -920 -310 -920 -260 {
lab=Vin}
N -920 -200 -920 -160 {
lab=GND}
N -960 -310 -920 -310 {
lab=Vin}
N -970 -310 -960 -310 {
lab=Vin}
N -1060 -300 -1060 -250 {
lab=VDD}
N -1060 -190 -1060 -150 {
lab=GND}
N -560 -480 -560 -450 {
lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} -580 -390 0 0 {name=PMOS
L=0.15
W=1
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -580 -260 0 0 {name=NMOS
L=0.15
W=1
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/opin.sym} -470 -320 0 0 {name=p1 lab=Vout}
C {devices/ipin.sym} -790 -320 0 0 {name=p2 lab=Vin}
C {devices/code_shown.sym} -820 -170 0 0 {name=SPICE only_toplevel=false value="
**.dc Vin 0 1.8 0.01
.tran 0.01n 100n
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
C {devices/code.sym} -1010 -500 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/vsource.sym} -920 -230 0 0 {name=Vin 
value="pulse(0 1.8 0.1ns 0.1ns 0.1ns 5ns 10ns)"}
C {devices/ipin.sym} -970 -310 0 0 {name=p3 lab=Vin}
C {devices/vsource.sym} -1060 -220 0 0 {name=VDD value=1.8}
C {devices/iopin.sym} -560 -480 3 0 {name=p4 lab=VDD}
C {devices/iopin.sym} -560 -190 1 0 {name=p5 lab=GND}
C {devices/iopin.sym} -920 -160 1 0 {name=p6 lab=GND}
C {devices/iopin.sym} -1060 -150 1 0 {name=p7 lab=GND}
C {devices/iopin.sym} -1060 -300 3 0 {name=p8 lab=VDD}
