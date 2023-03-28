v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1730 -1860 1730 -1820 {
lab=VDD}
N 1730 -1760 1730 -1710 {
lab=GND}
N 2130 -1820 2180 -1820 {
lab=VDD}
N 2180 -1860 2180 -1820 {
lab=VDD}
N 2130 -1780 2180 -1780 {
lab=GND}
N 2180 -1780 2180 -1710 {
lab=GND}
N 2130 -1800 2220 -1800 {
lab=out}
C {devices/code.sym} 2270 -2000 0 0 {name=TT_MODEL only_toplevel=false value="
.lib /home/swagatika/open_pdks/sky130/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.save all

"}
C {devices/code_shown.sym} 2290 -1670 0 0 {name=SPICE only_toplevel=false value="
.tran 1p 5n
.control
run
plot out
.save all
.endc
.end
"}
C {/home/swagatika/Desktop/Circuits/RingOscillator_sym.sym} 1980 -1800 0 0 {name=x1}
C {devices/vsource.sym} 1730 -1790 0 0 {name=V1 value=1.8}
C {devices/gnd.sym} 1730 -1710 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 1730 -1860 0 0 {name=l3 lab=VDD}
C {devices/vdd.sym} 2180 -1860 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 2180 -1710 0 0 {name=l4 lab=GND}
C {devices/opin.sym} 2220 -1800 0 0 {name=p1 lab=out}
