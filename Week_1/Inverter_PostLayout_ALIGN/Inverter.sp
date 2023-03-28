.subckt Inverter vdd OUT IN gnd

XPMOS OUT IN vdd vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
XNMOS OUT IN gnd gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2
.ends Inverter
