v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1830 -1860 1830 -1670 {
lab=#net1}
N 1620 -1860 1620 -1670 {
lab=out}
N 2040 -1860 2040 -1670 {
lab=#net2}
N 1660 -1830 1660 -1700 {
lab=#net1}
N 1870 -1830 1870 -1700 {
lab=#net2}
N 2080 -1830 2080 -1700 {
lab=out}
N 1660 -1940 1660 -1890 {
lab=Vdd}
N 1660 -1940 2080 -1940 {
lab=Vdd}
N 2080 -1940 2080 -1890 {
lab=Vdd}
N 1870 -1940 1870 -1890 {
lab=Vdd}
N 1660 -1640 1660 -1580 {
lab=Vdd}
N 1660 -1580 2080 -1580 {
lab=Vdd}
N 2080 -1640 2080 -1580 {
lab=Vdd}
N 1870 -1640 1870 -1580 {
lab=Vdd}
N 1660 -1860 1680 -1860 {
lab=Vdd}
N 1680 -1910 1680 -1860 {
lab=Vdd}
N 1660 -1910 1680 -1910 {
lab=Vdd}
N 1870 -1860 1890 -1860 {
lab=Vdd}
N 1890 -1910 1890 -1860 {
lab=Vdd}
N 1870 -1910 1890 -1910 {
lab=Vdd}
N 2080 -1860 2100 -1860 {
lab=Vdd}
N 2100 -1910 2100 -1860 {
lab=Vdd}
N 2080 -1910 2100 -1910 {
lab=Vdd}
N 1660 -1670 1680 -1670 {
lab=Vdd}
N 1680 -1670 1680 -1610 {
lab=Vdd}
N 1660 -1610 1680 -1610 {
lab=Vdd}
N 1870 -1670 1890 -1670 {
lab=Vdd}
N 1890 -1670 1890 -1610 {
lab=Vdd}
N 1870 -1610 1890 -1610 {
lab=Vdd}
N 2080 -1670 2100 -1670 {
lab=Vdd}
N 2100 -1670 2100 -1610 {
lab=Vdd}
N 2080 -1610 2100 -1610 {
lab=Vdd}
N 1660 -1770 1830 -1770 {
lab=#net1}
N 1870 -1770 2040 -1770 {
lab=#net2}
N 1870 -1580 1870 -1550 {
lab=Vdd}
N 1870 -1960 1870 -1940 {
lab=Vdd}
N 1540 -1770 1620 -1770 {
lab=out}
N 1540 -2050 1540 -1770 {
lab=out}
N 1540 -2050 2200 -2050 {
lab=out}
N 2200 -2050 2200 -1770 {
lab=out}
N 2080 -1770 2200 -1770 {
lab=out}
N 1870 -1970 1870 -1960 {
lab=Vdd}
N 2200 -1770 2230 -1770 {
lab=out}
C {sky130_fd_pr/pfet_01v8.sym} 1640 -1860 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 1850 -1860 0 0 {name=M2
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
C {sky130_fd_pr/pfet_01v8.sym} 2060 -1860 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} 1640 -1670 0 0 {name=M4
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
C {sky130_fd_pr/nfet_01v8.sym} 1850 -1670 0 0 {name=M5
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
C {sky130_fd_pr/nfet_01v8.sym} 2060 -1670 0 0 {name=M6
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
C {devices/opin.sym} 2230 -1770 0 0 {name=p3 lab=out}
C {devices/iopin.sym} 1870 -1970 3 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} 1870 -1550 1 0 {name=p2 lab=Gnd}
