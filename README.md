# pes_fb_piso
## 4-bit Parallel Input Serial Output
This repository contains details of design and working of a 4-bit PISO(Parallel In Serial Out) Shift Register


<h1 align="center">PISO Shift Register</h1>

## TABLE OF CONTENT

I. [**Introduction to Parallel Input Serial Output Registers**](https://github.com/Srini-web/pes_fb_piso#i-introduction)    

II. [**RTL Design and Synthesis**](https://github.com/Srini-web/pes_fb_piso#ii-rtl-design-and-synthesis)
  1. [Icarus Verilog (iverilog) & Yosys Installation on Ubuntu](https://github.com/Srini-web/pes_fb_piso#1-icarus-verilog-iverilog--yosys-installation-on-ubuntu)
  2. [RTL Pre-Simulation](https://github.com/Srini-web/pes_fb_piso#rtl-pre-simulation)
  3. [Synthesis](https://github.com/Srini-web/pes_fb_piso#synthesis)
  4. [GLS Post-simulation](https://github.com/Srini-web/pes_fb_piso#gls-post-simulation)

## **I. Introduction**
The shift register that uses parallel input and generates serial output is known as the parallel input serial output shift register or PISO shift register. In this shift register, the input data enters a parallel way and comes out serially. The flip-flops are connected such that the input of the second flip-flop is the output of the first flip-flop. Since a 4-bit PISO shift register is being implemented, 4 flip flops are used.

#### Applications
PISO Shift Registers are commonly used in
- Communication lines where a number of data lines are multiplexed into a single serial data line
- Reading data into a microprocessor
- Transmitter section in Analog to Digital converters

#### Block Diagram
The  4-bit PISO shift register circuit diagram is shown below. This circuit mainly includes 4, D flip flops which are connected as per the diagram shown. The CLK(clock) input signal is connected directly to all the flip-flops however the input data is individually connected to every flip-flop. Hence it is a synchronous sequential circuit. The previous flip-flop’s output, as well as parallel input data, is simply connected to the input of the second flip-flop. 

<p align='center'>
   <img src='https://github.com/Srini-web/pes_fb_piso/assets/77874288/669b094a-8c5c-4dd8-a611-ddd0c9fbf9db'>
</p> 

In the PISO shift register circuit, the input data is applied to the input pins of the shift registers from D0 to D3  at the same time. On every subsequent clock pulse, the output is read from the shift register serially 1-bit at a time from the input. Here, one CLK pulse is enough to load the 4 bits of data but four pulses are required to unload all four bits serially.

In this PISO shift register circuit, logic gates are used.  One control signal (Shift/Load) is used to control the parallel input and serial output for the selection of the loading or shifting function. 

For loading, ‘0’ must be given as input to the select line, and for shifting, ‘1’ has to be given as select input. Hence, a NOT gate is used for the select lines to distinguish loading and shifting functions. 

The connections are made as follows
- The NOT gate outputs are connected to inputs of AND gates ‘A2’, ‘A4’, and ‘A6’, and the other inputs of A2, A4 & A6 are the actual data inputs Q, R & S. Here, input ‘P’ is directly connected to D0 input of the first flip flop.

- For AND gates, A1, A3, and A5, one of the inputs is the Shift/Load select line and the other input is connected to the outputs Q0, Q1, and Q2 of respective flip flops.  
- The outputs of AND gates A1 and A2 are connected to OR gate O1, the outputs of AND gates A2 and A4 are connected to OR gate O2, The outputs of AND gates A5 and A6 are connected to OR gate O3. 
-The outputs of OR gates O1, O2 and O3 are connected to inputs of Q1, Q2 and Q3 respectively. The AND gates and OR gates, together, perform the function of a multiplexer.
-All the flip flops are to be connected in a single CLK pulse and the flip flops outputs will be in the serial data output. The serial output is taken at the output Q3 of flip-flop D3.

Refer to the truth table below to understand the progress after each clock pulse. In the below truth table, input is taken as '1011'. Observe 'Q3' at each clock cycle for the serial output.

<p align='center'> 
  <img src='https://github.com/Srini-web/pes_fb_piso/assets/77874288/df974b92-40c3-4669-b547-6cc7e5114127'>
</p>


<p align='center'>
  <img src='https://github.com/Srini-web/pes_fb_piso/assets/77874288/46f0cfe8-8eab-41c4-a6bb-b522a3b8ef57'>
</p>


## **II. RTL Design and Synthesis**

### **1. Icarus Verilog (iverilog) & Yosys Installation on Ubuntu**

#### Required Tools and Installation Details

#### iverilog

Icarus Verilog (iverilog) is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the "vvp" command. For synthesis, the compiler generates netlists in the desired format.

#### GTKWave

GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

#### yosys

Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

### Installation of iverilog and GTKwave

- In Ubuntu
  + Open the terminal and enter the following commands
  
  ```
   sudo apt-get update
   sudo apt-get install iverilog 
   sudo apt-get install gtkwave
  ```
 
### Installation of yosys

- Type the following command to install `yosys`

  ```
  git clone https://github.com/YosysHQ/yosys.git
  sudo apt install make
  
  sudo apt-get install build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev
  
  sudo make install
  ```

## RTL Pre-Simulation

1. Create files for PISO design `pes_fb_piso.v` and testbench for the same `pes_fb_piso_tb.v`

 <p align='center'>
  <img src='https://github.com/Srini-web/pes_fb_piso/assets/77874288/634c6b66-90d0-4b0e-9da0-cfef8e70fccd'>
</p>
<p align='center'>
  <img src='https://github.com/Srini-web/pes_fb_piso/assets/77874288/e7386d81-38f2-4cb1-8e72-40c37fd37cc3'>
</p>  

3. Detailed information on files
   
![s3list](https://github.com/Srini-web/pes_fb_piso/assets/77874288/e9b693d2-7b2d-4e2b-93ac-a59037374974)
![s4list](https://github.com/Srini-web/pes_fb_piso/assets/77874288/41d5f3aa-ad8a-46a2-ada1-24c46fb2855a)

4. To Run the .v file, type the following commands

   ```
   cd Desktop
   cd piso
   iverilog pes_fb_piso.v  pes_fb_piso_tb.v
   ./a.out
   gtkwave -o pes_fb_piso.vcd
   ```
![s5run1](https://github.com/Srini-web/pes_fb_piso/assets/77874288/73e737ae-22cb-41a0-9a9f-66a7092e4492)

Output is initially not outputted owing to the large size of the file

![s6run2](https://github.com/Srini-web/pes_fb_piso/assets/77874288/aac6d751-add4-4de3-be72-6fe9c0311682)

Error is resolved as `-o` is included short for `--optimise`

![s7](https://github.com/Srini-web/pes_fb_piso/assets/77874288/129ba819-b874-428c-9650-c8e36f6d545f)

Pre-Simulation output

<img width="639" alt="s8gtkfin" src="https://github.com/Srini-web/pes_fb_piso/assets/77874288/42d27343-af5e-4f09-b14c-ac7754611485">

## Synthesis

Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

Synthesis takes place in multiple steps:

  -  Converting RTL into simple logic gates.
  -  Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
  -  Optimizing the mapped netlist keeping the constraints set by the designer intact

1. Invoking the yosys using the following commands

![s9syncom](https://github.com/Srini-web/pes_fb_piso/assets/77874288/b254f5d6-235c-4407-9851-9356288072f0)

![s10readmodule](https://github.com/Srini-web/pes_fb_piso/assets/77874288/655274fc-5fda-4f4d-a655-006241a0a20f)

2. Generating synthesized diagram
   Enter the following commands

   ```
   read_liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
   read_verilog pes_fb_piso.v
   synth -top pes_fb_piso
   dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
   abc -liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
   ```
   
   Synthesised circuit is flattened and shown

   ```
   flatten
   show
   ```
   
![s13flat](https://github.com/Srini-web/pes_fb_piso/assets/77874288/c001746c-29c2-4346-a959-3c45df1ac691)

Statistics drawn
```
stat
```

![s14stats](https://github.com/Srini-web/pes_fb_piso/assets/77874288/667b4cfc-05f5-47c6-af32-f34427fcd1b0)

3. Write the netlist
   ```
   write_verilog -noattr pes_fb_piso_netlist.v
   ```

## GLS Post-simulation
GLS implies running the testbench with netlist as the design under test. It is used to verify the logical correctness of the design after synthesis. It also ensures that the timing constraints are met.

Execute the below commands in the project directory to perform GLS.
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 ./verilog_model/primitives.v ./verilog_model/sky130_fd_sc_hd.v
./a.out
gtkwave -o -g pes_fb_piso.vcd
```
Errors encountered in the first step are addressed as #2 and #3 in the error file

<img width="639" alt="s15postsim" src="https://github.com/Srini-web/pes_fb_piso/assets/77874288/cdf733de-4b60-4c69-9b4b-c0a64f3567e5">

GLS post-simulation complete

![s17simulationmod](https://github.com/Srini-web/pes_fb_piso/assets/77874288/b3314308-ce67-498a-aeaa-d8ec8a309ea7)

