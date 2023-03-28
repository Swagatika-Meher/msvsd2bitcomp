v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1180 -710 1180 -560 {
lab=#net1}
N 900 -500 900 -460 {
lab=#net2}
N 900 -460 1180 -460 {
lab=#net2}
N 1180 -500 1180 -460 {
lab=#net2}
N 1180 -820 1180 -770 {
lab=Vdd}
N 1180 -740 1220 -740 {
lab=Vdd}
N 1220 -800 1220 -740 {
lab=Vdd}
N 1180 -800 1220 -800 {
lab=Vdd}
N 900 -530 930 -530 {
lab=#net2}
N 930 -530 930 -470 {
lab=#net2}
N 900 -470 930 -470 {
lab=#net2}
N 1180 -530 1220 -530 {
lab=#net2}
N 1220 -530 1220 -480 {
lab=#net2}
N 1180 -480 1220 -480 {
lab=#net2}
N 840 -530 860 -530 {
lab=INN}
N 1040 -460 1040 -410 {
lab=#net2}
N 1050 -840 1050 -820 {
lab=Vdd}
N 1180 -630 1320 -630 {
lab=#net1}
N 900 -820 1180 -820 {
lab=Vdd}
N 900 -640 1040 -640 {
lab=#net3}
N 1040 -740 1040 -640 {
lab=#net3}
N 1110 -530 1140 -530 {
lab=INP}
N 1180 -820 1490 -820 {
lab=Vdd}
N 1490 -820 1490 -770 {
lab=Vdd}
N 1490 -710 1490 -390 {
lab=OUT}
N 1330 -740 1450 -740 {
lab=#net1}
N 1330 -740 1330 -630 {
lab=#net1}
N 1490 -740 1530 -740 {
lab=Vdd}
N 1530 -790 1530 -740 {
lab=Vdd}
N 1490 -790 1530 -790 {
lab=Vdd}
N 1040 -410 1040 -390 {
lab=#net2}
N 650 -280 1490 -280 {
lab=Gnd}
N 1490 -330 1490 -280 {
lab=Gnd}
N 1040 -280 1040 -260 {
lab=Gnd}
N 1040 -330 1040 -280 {
lab=Gnd}
N 620 -360 620 -300 {
lab=Gnd}
N 620 -300 650 -300 {
lab=Gnd}
N 1490 -360 1520 -360 {
lab=Gnd}
N 1520 -360 1520 -300 {
lab=Gnd}
N 1490 -300 1520 -300 {
lab=Gnd}
N 650 -490 750 -490 {
lab=#net4}
N 750 -490 750 -360 {
lab=#net4}
N 650 -820 900 -820 {
lab=Vdd}
N 1040 -360 1090 -360 {
lab=Gnd}
N 1090 -360 1090 -310 {
lab=Gnd}
N 1040 -310 1090 -310 {
lab=Gnd}
N 940 -430 940 -360 {
lab=#net4}
N 940 -430 1340 -430 {
lab=#net4}
N 1340 -430 1340 -360 {
lab=#net4}
N 1340 -360 1450 -360 {
lab=#net4}
N 650 -660 650 -600 {
lab=#net4}
N 720 -740 720 -660 {
lab=#net4}
N 650 -660 720 -660 {
lab=#net4}
N 1320 -630 1330 -630 {
lab=#net1}
N 650 -820 650 -770 {
lab=Vdd}
N 650 -710 650 -660 {
lab=#net4}
N 630 -740 650 -740 {
lab=Vdd}
N 630 -800 630 -740 {
lab=Vdd}
N 630 -800 650 -800 {
lab=Vdd}
N 690 -740 720 -740 {
lab=#net4}
N 940 -740 1140 -740 {
lab=#net3}
N 900 -710 900 -560 {
lab=#net3}
N 900 -820 900 -770 {
lab=Vdd}
N 880 -740 900 -740 {
lab=Vdd}
N 880 -790 880 -740 {
lab=Vdd}
N 880 -790 900 -790 {
lab=Vdd}
N 650 -600 650 -390 {
lab=#net4}
N 650 -330 650 -280 {
lab=Gnd}
N 620 -360 650 -360 {
lab=Gnd}
N 690 -360 1000 -360 {
lab=#net4}
N 1490 -540 1580 -540 {
lab=OUT}
C {sky130_fd_pr/pfet_01v8.sym} 1160 -740 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 880 -530 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} 1160 -530 0 0 {name=M4
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
C {devices/iopin.sym} 1050 -840 2 0 {name=p4 lab=Vdd}
C {sky130_fd_pr/pfet_01v8.sym} 920 -740 0 1 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 1470 -740 0 0 {name=M5
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
C {sky130_fd_pr/nfet_01v8.sym} 1470 -360 0 0 {name=M6
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
C {sky130_fd_pr/nfet_01v8.sym} 1020 -360 0 0 {name=M7
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
C {sky130_fd_pr/nfet_01v8.sym} 670 -360 0 1 {name=M8
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
C {devices/iopin.sym} 840 -530 2 0 {name=p1 lab=INN}
C {devices/iopin.sym} 1110 -530 2 0 {name=p3 lab=INP}
C {sky130_fd_pr/pfet_01v8.sym} 670 -740 0 1 {name=M9
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
C {devices/iopin.sym} 1040 -260 2 0 {name=p2 lab=Gnd}
C {devices/opin.sym} 1580 -540 0 0 {name=p5 lab=OUT}
