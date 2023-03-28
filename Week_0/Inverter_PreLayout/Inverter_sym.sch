v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -660 -390 -600 -390 {
lab=IN}
N -660 -390 -660 -260 {
lab=IN}
N -660 -260 -600 -260 {
lab=IN}
N -560 -360 -560 -290 {
lab=OUT}
N -560 -320 -510 -320 {
lab=OUT}
N -710 -320 -660 -320 {
lab=IN}
N -560 -450 -560 -420 {
lab=vdd}
N -560 -390 -480 -390 {
lab=vdd}
N -480 -430 -480 -390 {
lab=vdd}
N -560 -430 -480 -430 {
lab=vdd}
N -560 -260 -480 -260 {
lab=gnd}
N -480 -260 -480 -210 {
lab=gnd}
N -560 -210 -480 -210 {
lab=gnd}
N -560 -230 -560 -190 {
lab=gnd}
N -750 -320 -710 -320 {
lab=IN}
N -770 -320 -750 -320 {
lab=IN}
N -510 -320 -490 -320 {
lab=OUT}
N -790 -320 -770 -320 {
lab=IN}
N -490 -320 -470 -320 {
lab=OUT}
N -560 -480 -560 -450 {
lab=vdd}
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
C {devices/opin.sym} -470 -320 0 0 {name=Vout lab=OUT}
C {devices/ipin.sym} -790 -320 0 0 {name=Vin lab=IN}
C {devices/iopin.sym} -560 -480 3 0 {name=p3 lab=vdd}
C {devices/iopin.sym} -560 -190 1 0 {name=p4 lab=gnd}
