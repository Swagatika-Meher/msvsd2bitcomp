# INDEX
* [Week 3](#Week-3)
  * [Xschem: Ring Oscillator](#Xschem:-Ring-Oscillator)
  
  
  
# Xschem: Ring Oscillator
A ring oscillator is an electronic circuit that generates a periodic waveform, typically a square wave or a sine wave, using a feedback loop of inverters or delay elements. It is a type of oscillator that does not require any external components like resistors, capacitors or crystals to generate a clock signal.
The basic principle behind the ring oscillator is that a chain of odd number of inverters are connected in a loop, and the output of the last inverter is fed back to the input of the first inverter. This creates a positive feedback loop that causes the circuit to oscillate at a frequency determined by the delay of each inverter.
Ring oscillators are widely used in digital circuits as clock generators, frequency dividers, and timing references. They are simple and easy to implement, making them popular in integrated circuits where small size and low power consumption are critical factors.

The following figure depicts a 3-stage ring oscillator in Xschem.


