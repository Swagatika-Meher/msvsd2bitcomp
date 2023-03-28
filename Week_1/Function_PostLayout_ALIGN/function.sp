.subckt function A B C D E F Fn VDD Gnd
XM1 net3 A VDD VDD sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM2 net1 B VDD VDD sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM3 net2 C net3 net3 sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM4 net2 D net1 net1 sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM5 Fn E net2 net2 sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM6 Fn F net2 net2 sky130_fd_pr__pfet_01v8 L=120n W=1050n nf=2
XM7 Fn A net4 net4 sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
XM8 Fn C net4 net4 sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
XM9 Fn E net5 net5 sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
XM10 net4 B Gnd Gnd sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
XM11 net4 D Gnd Gnd sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
XM12 net5 F Gnd Gnd sky130_fd_pr__nfet_01v8 L=120n W=840n nf=2
.ends function
