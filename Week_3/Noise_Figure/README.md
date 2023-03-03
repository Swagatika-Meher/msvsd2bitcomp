Noise figure (NF) usually refers how much the noise added by the transistor affects the quality of the signal. A lower noise figure is better because it means that the transistor adds less noise to the signal.

# Post-layout of Ring Oscillator using ALIGN

Input netlist for ALIGN tool when **NF=2**,
```
.subckt RingOscillator Vdd out Gnd

XM1 net1 out Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
XM2 net2 net1 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
XM3 out net2 Vdd Vdd sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=2
XM4 net1 out Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2
XM5 net2 net1 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2
XM6 out net2 Gnd Gnd sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=2
.ends RingOscillator
```
