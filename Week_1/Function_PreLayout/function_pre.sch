v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -310 -1170 -310 -1140 {
lab=A}
N -310 -1080 -310 -1040 {
lab=GND}
N -80 -1170 -80 -1140 {
lab=B}
N -80 -1080 -80 -1040 {
lab=GND}
N 530 -1210 530 -1170 {
lab=VDD}
N 530 -1210 770 -1210 {
lab=VDD}
N 770 -1210 770 -1170 {
lab=VDD}
N 770 -1110 770 -1070 {
lab=#net1}
N 770 -1010 770 -970 {
lab=#net2}
N 530 -1110 530 -1070 {
lab=#net3}
N 530 -1010 530 -970 {
lab=#net2}
N 530 -910 530 -880 {
lab=Fn}
N 530 -880 770 -880 {
lab=Fn}
N 770 -910 770 -880 {
lab=Fn}
N 530 -990 770 -990 {
lab=#net2}
N 530 -1170 530 -1140 {
lab=VDD}
N 770 -1170 770 -1140 {
lab=VDD}
N 530 -1070 530 -1040 {
lab=#net3}
N 770 -1070 770 -1040 {
lab=#net1}
N 530 -970 530 -940 {
lab=#net2}
N 770 -970 770 -940 {
lab=#net2}
N 450 -820 450 -810 {
lab=Fn}
N 450 -820 850 -820 {
lab=Fn}
N 850 -820 850 -810 {
lab=Fn}
N 660 -820 660 -810 {
lab=Fn}
N 450 -750 450 -740 {
lab=#net4}
N 450 -740 660 -740 {
lab=#net4}
N 660 -750 660 -740 {
lab=#net4}
N 450 -700 450 -690 {
lab=#net4}
N 450 -700 660 -700 {
lab=#net4}
N 660 -700 660 -690 {
lab=#net4}
N 560 -740 560 -700 {
lab=#net4}
N 640 -880 640 -820 {
lab=Fn}
N 450 -630 450 -620 {
lab=GND}
N 450 -620 850 -620 {
lab=GND}
N 850 -630 850 -620 {
lab=GND}
N 660 -630 660 -620 {
lab=GND}
N 850 -750 850 -690 {
lab=#net5}
N 450 -780 450 -750 {
lab=#net4}
N 660 -780 660 -750 {
lab=#net4}
N 850 -780 850 -750 {
lab=#net5}
N 450 -660 450 -630 {
lab=GND}
N 660 -660 660 -630 {
lab=GND}
N 850 -660 850 -630 {
lab=GND}
N 680 -620 680 -590 {
lab=GND}
N 650 -1230 650 -1210 {
lab=VDD}
N 460 -1140 490 -1140 {
lab=A}
N 460 -1040 490 -1040 {
lab=C}
N 460 -940 490 -940 {
lab=E}
N 700 -1140 730 -1140 {
lab=B}
N 700 -1040 730 -1040 {
lab=D}
N 700 -940 730 -940 {
lab=F}
N 380 -780 410 -780 {
lab=A}
N 600 -780 620 -780 {
lab=C}
N 790 -780 810 -780 {
lab=E}
N 380 -660 410 -660 {
lab=B}
N 600 -660 620 -660 {
lab=D}
N 790 -660 810 -660 {
lab=F}
N 640 -850 950 -850 {
lab=Fn}
N 950 -1100 950 -1050 {
lab=GND}
N 950 -1200 950 -1160 {
lab=VDD}
N 150 -1170 150 -1140 {
lab=C}
N 150 -1080 150 -1040 {
lab=GND}
N -310 -920 -310 -890 {
lab=D}
N -310 -830 -310 -790 {
lab=GND}
N -80 -920 -80 -890 {
lab=E}
N -80 -830 -80 -790 {
lab=GND}
N 150 -920 150 -890 {
lab=F}
N 150 -830 150 -790 {
lab=GND}
C {devices/vsource.sym} -310 -1110 0 0 {name=V1 value="pulse(0 1.8 0.1n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -310 -1040 0 0 {name=l3 lab=GND}
C {devices/ipin.sym} -310 -1170 1 0 {name=p14 lab=A}
C {devices/vsource.sym} -80 -1110 0 0 {name=V2 value="pulse(0 1.8 0.2n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -80 -1040 0 0 {name=l4 lab=GND}
C {devices/ipin.sym} -80 -1170 1 0 {name=p15 lab=B}
C {sky130_fd_pr/pfet_01v8.sym} 510 -1140 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 750 -1140 0 0 {name=M2
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
C {sky130_fd_pr/pfet_01v8.sym} 510 -1040 0 0 {name=M3
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
C {sky130_fd_pr/pfet_01v8.sym} 750 -1040 0 0 {name=M4
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
C {sky130_fd_pr/pfet_01v8.sym} 510 -940 0 0 {name=M5
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
C {sky130_fd_pr/pfet_01v8.sym} 750 -940 0 0 {name=M6
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
C {sky130_fd_pr/nfet_01v8.sym} 430 -780 0 0 {name=M7
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
C {sky130_fd_pr/nfet_01v8.sym} 640 -780 0 0 {name=M8
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
C {sky130_fd_pr/nfet_01v8.sym} 830 -780 0 0 {name=M9
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
C {sky130_fd_pr/nfet_01v8.sym} 430 -660 0 0 {name=M10
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
C {sky130_fd_pr/nfet_01v8.sym} 640 -660 0 0 {name=M11
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
C {sky130_fd_pr/nfet_01v8.sym} 830 -660 0 0 {name=M12
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
C {devices/vdd.sym} 650 -1230 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 680 -590 0 0 {name=l2 lab=GND}
C {devices/ipin.sym} 460 -1140 0 0 {name=p1 lab=A}
C {devices/ipin.sym} 700 -1140 0 0 {name=p2 lab=B}
C {devices/ipin.sym} 460 -1040 0 0 {name=p3 lab=C}
C {devices/ipin.sym} 700 -1040 0 0 {name=p4 lab=D}
C {devices/ipin.sym} 460 -940 0 0 {name=p5 lab=E}
C {devices/ipin.sym} 700 -940 0 0 {name=p6 lab=F}
C {devices/ipin.sym} 380 -780 0 0 {name=p7 lab=A}
C {devices/ipin.sym} 380 -660 0 0 {name=p8 lab=B}
C {devices/ipin.sym} 600 -780 0 0 {name=p9 lab=C}
C {devices/ipin.sym} 600 -660 0 0 {name=p10 lab=D}
C {devices/ipin.sym} 790 -780 0 0 {name=p11 lab=E}
C {devices/ipin.sym} 790 -660 0 0 {name=p12 lab=F}
C {devices/opin.sym} 950 -850 0 0 {name=p13 lab=Fn}
C {devices/vsource.sym} 950 -1130 0 0 {name=V7 value=1.8}
C {devices/gnd.sym} 950 -1050 0 0 {name=l9 lab=GND}
C {devices/vdd.sym} 950 -1200 0 0 {name=l10 lab=VDD}
C {devices/vsource.sym} 150 -1110 0 0 {name=V3 value="pulse(0 1.8 0.3n 10p 10p 1n 2n)"}
C {devices/gnd.sym} 150 -1040 0 0 {name=l5 lab=GND}
C {devices/ipin.sym} 150 -1170 1 0 {name=p16 lab=C}
C {devices/vsource.sym} -310 -860 0 0 {name=V4 value="pulse(0 1.8 0.4n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -310 -790 0 0 {name=l6 lab=GND}
C {devices/ipin.sym} -310 -920 1 0 {name=p17 lab=D}
C {devices/vsource.sym} -80 -860 0 0 {name=V5 value="pulse(0 1.8 0.5n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -80 -790 0 0 {name=l7 lab=GND}
C {devices/ipin.sym} -80 -920 1 0 {name=p18 lab=E}
C {devices/vsource.sym} 150 -860 0 0 {name=V6 value="pulse(0 1.8 0.6n 10p 10p 1n 2n)"}
C {devices/gnd.sym} 150 -790 0 0 {name=l8 lab=GND}
C {devices/ipin.sym} 150 -920 1 0 {name=p19 lab=F}
C {devices/code.sym} 1070 -1090 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/code_shown.sym} 1020 -870 0 0 {name=SPICE only_toplevel=false value="
.tran 10p 4n
.control
run
plot A+3 B+3 C+3 D+3 E+3 F+3 Fn
.save all
.endc
.end
"}
