# pes_fb_piso
## 4-bit Parallel Input Serial Output
This repository contains details of design and working of a 4-bit PISO(Parallel In Serial Out) Shift Register


<h1 align="center">PISO Shift Register</h1>

## TABLE OF CONTENT

I. [**Introduction to Parallel Input Serial Output Registers**]([https://github.com/drvasanthi/iiitb_cg/blob/main/README.md#introduction](https://github.com/Srini-web/pes_fb_piso/edit/main/README.md#i-introduction))    

II. [**RTL Design and Synthesis**]
  1. [Icarus Verilog (iverilog) & Yosys Installation on Ubuntu]
  2. [RTL Pre-Simulation]
  3. [Synthesis]
  4. [GLS Post-simulation]

## **I. Introduction**
The shift register which uses parallel input and generates serial output is known as the parallel input serial output shift register or PISO shift register. In this shift register, the input data enters a parallel way and comes out serially. The flip-flops are connected such that the input of the second flip flop is the output of the first flip flop. Since a 4-bit PISO shift register is being implemented , 4 flip flops are used.

#### Applications
PISO Shift Registers are commonly used in
- Communication lines where a number of data lines are multiplexed into single serial data line
- Reading data into a microprocessor
- Transmitter section in Analog to Digital converters
