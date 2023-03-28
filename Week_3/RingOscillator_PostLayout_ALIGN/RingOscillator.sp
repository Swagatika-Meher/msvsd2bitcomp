.subckt RingOscillator Vdd out Gnd

XM1 net1 out Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=8
XM2 net2 net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=8
XM3 out net2 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=8
XM4 net1 out Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=8
XM5 net2 net1 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=8
XM6 out net2 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=8
.ends RingOscillator
