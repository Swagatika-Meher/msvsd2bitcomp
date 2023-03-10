# Xschem: Pre-layout simulation for 1-bit Analog to Digital Converter
A 1-bit ADC (analog-to-digital converter) is the simplest form of ADC. It works by comparing the analog input signal to a fixed reference voltage and producing a digital output that indicates whether the input signal is above or below the reference voltage.

The 1-bit ADC can be implemented using a comparator circuit. A comparator is an electronic circuit that compares two voltages and produces a binary output (0 or 1) depending on which voltage is higher.

In the case of a 1-bit ADC, the comparator compares the analog input signal with a fixed reference voltage. If the input voltage is greater than the reference voltage, the comparator outputs a logic '1". If the input voltage is less than the reference voltage, the comparator outputs a logic "0". This digital output represents the result of the analog-to-digital conversion.

The output of a 1-bit ADC is a single bit, which means it can only represent two possible states: high (1) or low (0). This limited resolution makes the 1-bit ADC unsuitable for many applications that require higher precision, but it can be useful in some cases where simplicity and low cost are more important than accuracy.

The following figure depicts 1-bit ADC using two stage CMOS OP-AMP technique in Xschem.

![001](https://user-images.githubusercontent.com/114692581/224232409-24083ee0-eed0-45c2-b42f-e8efda5df53b.PNG)

1-bit ADC shown as a symbol in following figure.

![002](https://user-images.githubusercontent.com/114692581/224232587-0b7e31a2-94b4-422f-877c-90182d711075.PNG)

1-bit ADC shown as a testbench schematic in following figure.

![003](https://user-images.githubusercontent.com/114692581/224232790-7b831ab4-e343-416c-8e9e-3e11cba9dea7.PNG)

