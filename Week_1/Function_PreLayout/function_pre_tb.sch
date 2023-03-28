v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -320 -1220 -320 -1190 {
lab=A}
N -320 -1130 -320 -1090 {
lab=GND}
N -250 -1060 -250 -1030 {
lab=B}
N -250 -970 -250 -930 {
lab=GND}
N -190 -920 -190 -890 {
lab=C}
N -190 -830 -190 -790 {
lab=GND}
N -130 -770 -130 -740 {
lab=D}
N -130 -680 -130 -640 {
lab=GND}
N 40 -1210 40 -1180 {
lab=E}
N 40 -1120 40 -1080 {
lab=GND}
N 100 -1070 100 -1040 {
lab=F}
N 100 -980 100 -940 {
lab=GND}
N 170 -810 170 -760 {
lab=GND}
N 170 -910 170 -870 {
lab=VDD}
N 830 -1070 830 -1040 {
lab=VDD}
N 390 -1040 530 -1040 {
lab=A}
N 390 -1020 530 -1020 {
lab=B}
N 390 -1000 530 -1000 {
lab=D}
N 390 -980 530 -980 {
lab=C}
N 390 -960 530 -960 {
lab=F}
N 390 -940 530 -940 {
lab=E}
N 830 -1020 870 -1020 {
lab=Fn}
N 830 -1000 830 -960 {
lab=GND}
C {devices/code_shown.sym} 1020 -870 0 0 {name=SPICE only_toplevel=false value="
.tran 10p 4n
.control
run
plot A+3 B+3 C+3 D+3 E+3 F+3 Fn
.save all
.endc
.end
"}
C {devices/vsource.sym} -320 -1160 0 0 {name=V1 value="pulse(0 1.8 0.1n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -320 -1090 0 0 {name=l3 lab=GND}
C {devices/ipin.sym} -320 -1220 1 0 {name=p14 lab=A}
C {devices/vsource.sym} -250 -1000 0 0 {name=V2 value="pulse(0 1.8 0.2n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -250 -930 0 0 {name=l4 lab=GND}
C {devices/ipin.sym} -250 -1060 1 0 {name=p15 lab=B}
C {devices/vsource.sym} -190 -860 0 0 {name=V3 value="pulse(0 1.8 0.3n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -190 -790 0 0 {name=l5 lab=GND}
C {devices/ipin.sym} -190 -920 1 0 {name=p16 lab=C}
C {devices/vsource.sym} -130 -710 0 0 {name=V4 value="pulse(0 1.8 0.4n 10p 10p 1n 2n)"}
C {devices/gnd.sym} -130 -640 0 0 {name=l6 lab=GND}
C {devices/ipin.sym} -130 -770 1 0 {name=p17 lab=D}
C {devices/vsource.sym} 40 -1150 0 0 {name=V5 value="pulse(0 1.8 0.5n 10p 10p 1n 2n)"}
C {devices/gnd.sym} 40 -1080 0 0 {name=l7 lab=GND}
C {devices/ipin.sym} 40 -1210 1 0 {name=p18 lab=E}
C {devices/vsource.sym} 100 -1010 0 0 {name=V6 value="pulse(0 1.8 0.6n 10p 10p 1n 2n)"}
C {devices/gnd.sym} 100 -940 0 0 {name=l8 lab=GND}
C {devices/ipin.sym} 100 -1070 1 0 {name=p19 lab=F}
C {devices/vsource.sym} 170 -840 0 0 {name=V7 value=1.8}
C {devices/gnd.sym} 170 -760 0 0 {name=l9 lab=GND}
C {devices/code.sym} 1000 -1100 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/ipin.sym} 390 -940 0 0 {name=p7 lab=E}
C {devices/ipin.sym} 390 -960 0 0 {name=p8 lab=F}
C {devices/ipin.sym} 390 -980 0 0 {name=p9 lab=C}
C {devices/ipin.sym} 390 -1000 0 0 {name=p10 lab=D}
C {devices/ipin.sym} 390 -1020 0 0 {name=p11 lab=B}
C {devices/ipin.sym} 390 -1040 0 0 {name=p12 lab=A}
C {devices/iopin.sym} 170 -910 3 0 {name=p13 lab=VDD}
C {devices/iopin.sym} 830 -1070 3 0 {name=p20 lab=VDD}
C {devices/opin.sym} 870 -1020 0 0 {name=p21 lab=Fn}
C {devices/gnd.sym} 830 -960 0 0 {name=l1 lab=GND}
C {/home/swagatika/Desktop/Circuits/function_pre_sym.sym} 680 -990 0 0 {name=x1}
