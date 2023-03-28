.subckt 1bitadc Vdd INN INP Gnd OUT
M1 net3 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M2 net1 net3 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M3 net3 INN net2 Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M4 net1 INP net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M5 OUT net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
M6 OUT net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M7 net2 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M8 net4 net4 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
M9 net4 net4 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
.ends 1bitadc
