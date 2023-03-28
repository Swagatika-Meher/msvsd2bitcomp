v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
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
lab=Gnd}
N 450 -620 850 -620 {
lab=Gnd}
N 850 -630 850 -620 {
lab=Gnd}
N 660 -630 660 -620 {
lab=Gnd}
N 850 -750 850 -690 {
lab=#net5}
N 450 -780 450 -750 {
lab=#net4}
N 660 -780 660 -750 {
lab=#net4}
N 850 -780 850 -750 {
lab=#net5}
N 450 -660 450 -630 {
lab=Gnd}
N 660 -660 660 -630 {
lab=Gnd}
N 850 -660 850 -630 {
lab=Gnd}
N 680 -620 680 -590 {
lab=Gnd}
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
N 350 -780 380 -780 {
lab=A}
N 350 -660 380 -660 {
lab=B}
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
C {devices/ipin.sym} 460 -1140 0 0 {name=p1 lab=A}
C {devices/ipin.sym} 700 -1140 0 0 {name=p2 lab=B}
C {devices/ipin.sym} 460 -1040 0 0 {name=p3 lab=C}
C {devices/ipin.sym} 700 -1040 0 0 {name=p4 lab=D}
C {devices/ipin.sym} 460 -940 0 0 {name=p5 lab=E}
C {devices/ipin.sym} 700 -940 0 0 {name=p6 lab=F}
C {devices/opin.sym} 950 -850 0 0 {name=p13 lab=Fn}
C {devices/iopin.sym} 650 -1230 3 0 {name=p14 lab=VDD}
C {devices/iopin.sym} 680 -590 1 0 {name=p15 lab=Gnd}
C {devices/lab_pin.sym} 350 -780 0 0 {name=p7 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 350 -660 0 0 {name=p8 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 600 -780 0 0 {name=p9 sig_type=std_logic lab=C}
C {devices/lab_pin.sym} 600 -660 0 0 {name=p10 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} 790 -780 0 0 {name=p11 sig_type=std_logic lab=E}
C {devices/lab_pin.sym} 790 -660 0 0 {name=p12 sig_type=std_logic lab=F}
