v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1170 -700 1170 -550 {
lab=#net1}
N 890 -490 890 -450 {
lab=#net2}
N 890 -450 1170 -450 {
lab=#net2}
N 1170 -490 1170 -450 {
lab=#net2}
N 1170 -810 1170 -760 {
lab=Vdd}
N 1170 -730 1210 -730 {
lab=Vdd}
N 1210 -790 1210 -730 {
lab=Vdd}
N 1170 -790 1210 -790 {
lab=Vdd}
N 890 -520 920 -520 {
lab=#net2}
N 920 -520 920 -460 {
lab=#net2}
N 890 -460 920 -460 {
lab=#net2}
N 1170 -520 1210 -520 {
lab=#net2}
N 1210 -520 1210 -470 {
lab=#net2}
N 1170 -470 1210 -470 {
lab=#net2}
N 830 -520 850 -520 {
lab=IN1}
N 1030 -450 1030 -400 {
lab=#net2}
N 1040 -830 1040 -810 {
lab=Vdd}
N 1170 -620 1310 -620 {
lab=#net1}
N 1630 -620 1690 -620 {
lab=OUT}
N 890 -810 1170 -810 {
lab=Vdd}
N 890 -630 1030 -630 {
lab=#net3}
N 1030 -730 1030 -630 {
lab=#net3}
N 1100 -520 1130 -520 {
lab=IN2}
N 1170 -810 1480 -810 {
lab=Vdd}
N 1480 -810 1480 -760 {
lab=Vdd}
N 1480 -700 1480 -380 {
lab=OUT}
N 1320 -730 1440 -730 {
lab=#net1}
N 1320 -730 1320 -620 {
lab=#net1}
N 1480 -730 1520 -730 {
lab=Vdd}
N 1520 -780 1520 -730 {
lab=Vdd}
N 1480 -780 1520 -780 {
lab=Vdd}
N 1030 -400 1030 -380 {
lab=#net2}
N 640 -270 1480 -270 {
lab=GND}
N 1480 -320 1480 -270 {
lab=GND}
N 1030 -270 1030 -250 {
lab=GND}
N 1030 -320 1030 -270 {
lab=GND}
N 610 -350 610 -290 {
lab=GND}
N 610 -290 640 -290 {
lab=GND}
N 1480 -350 1510 -350 {
lab=GND}
N 1510 -350 1510 -290 {
lab=GND}
N 1480 -290 1510 -290 {
lab=GND}
N 640 -480 740 -480 {
lab=#net4}
N 740 -480 740 -350 {
lab=#net4}
N 640 -810 890 -810 {
lab=Vdd}
N 1480 -620 1630 -620 {
lab=OUT}
N 1030 -350 1080 -350 {
lab=GND}
N 1080 -350 1080 -300 {
lab=GND}
N 1030 -300 1080 -300 {
lab=GND}
N 930 -420 930 -350 {
lab=#net4}
N 930 -420 1330 -420 {
lab=#net4}
N 1330 -420 1330 -350 {
lab=#net4}
N 1330 -350 1440 -350 {
lab=#net4}
N 640 -650 640 -590 {
lab=#net4}
N 710 -730 710 -650 {
lab=#net4}
N 640 -650 710 -650 {
lab=#net4}
N 1310 -620 1320 -620 {
lab=#net1}
N 450 -400 450 -370 {
lab=IN2}
N 450 -310 450 -270 {
lab=GND}
N 430 -400 450 -400 {
lab=IN2}
N 440 -640 440 -610 {
lab=IN1}
N 440 -550 440 -510 {
lab=GND}
N 440 -820 440 -790 {
lab=Vdd}
N 440 -730 440 -690 {
lab=GND}
N 420 -820 440 -820 {
lab=Vdd}
N 640 -810 640 -760 {
lab=Vdd}
N 640 -700 640 -650 {
lab=#net4}
N 620 -730 640 -730 {
lab=Vdd}
N 620 -790 620 -730 {
lab=Vdd}
N 620 -790 640 -790 {
lab=Vdd}
N 680 -730 710 -730 {
lab=#net4}
N 930 -730 1130 -730 {
lab=#net3}
N 890 -700 890 -550 {
lab=#net3}
N 890 -810 890 -760 {
lab=Vdd}
N 870 -730 890 -730 {
lab=Vdd}
N 870 -780 870 -730 {
lab=Vdd}
N 870 -780 890 -780 {
lab=Vdd}
N 640 -590 640 -380 {
lab=#net4}
N 640 -320 640 -270 {
lab=GND}
N 610 -350 640 -350 {
lab=GND}
N 680 -350 990 -350 {
lab=#net4}
C {sky130_fd_pr/pfet_01v8.sym} 1150 -730 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 870 -520 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} 1150 -520 0 0 {name=M4
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
C {devices/opin.sym} 1690 -620 0 0 {name=p11 lab=OUT}
C {devices/iopin.sym} 1040 -830 2 0 {name=p4 lab=Vdd}
C {sky130_fd_pr/pfet_01v8.sym} 910 -730 0 1 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 1460 -730 0 0 {name=M5
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
C {sky130_fd_pr/nfet_01v8.sym} 1460 -350 0 0 {name=M6
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
C {devices/gnd.sym} 1030 -250 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 1010 -350 0 0 {name=M7
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
C {sky130_fd_pr/nfet_01v8.sym} 660 -350 0 1 {name=M8
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
C {devices/iopin.sym} 830 -520 2 0 {name=p1 lab=IN1}
C {devices/iopin.sym} 1100 -520 2 0 {name=p7 lab=IN2}
C {sky130_fd_pr/pfet_01v8.sym} 660 -730 0 1 {name=M9
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
C {devices/code_shown.sym} 1570 -480 0 0 {name=SPICE only_toplevel=false value="
.tran 0.1n 100n
.control
run
plot IN1+2 IN2+2 OUT   
.save all
.endc
.end
"}
C {devices/code.sym} 1580 -800 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/vsource.sym} 450 -340 0 0 {name=V3 value="sin(0.9 0.9 50Meg)"}
C {devices/gnd.sym} 450 -270 0 0 {name=l6 lab=GND}
C {devices/iopin.sym} 430 -400 2 0 {name=p6 lab=IN2}
C {devices/gnd.sym} 440 -510 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 440 -580 0 0 {name=V1 value=0.9}
C {devices/iopin.sym} 440 -640 2 0 {name=p2 lab=IN1}
C {devices/vsource.sym} 440 -760 0 0 {name=V2 value=1.8}
C {devices/gnd.sym} 440 -690 0 0 {name=l2 lab=GND}
C {devices/iopin.sym} 420 -820 2 0 {name=p3 lab=Vdd}
