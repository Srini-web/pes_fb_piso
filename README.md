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

III. [**Physical Design from Netlist to GDSII**](https://github.com/Srini-web/pes_fb_piso#iii-physical-design-from-netlist-to-gdsii)  
  1. [Installations](https://github.com/Srini-web/pes_fb_piso#installations)  
  2. [Invoking OpenLane](https://github.com/Srini-web/pes_fb_piso#invoking-openlane)  
  3. [Synthesis](https://github.com/Srini-web/pes_fb_piso#synthesis-1)      
  4. [Floorplan](https://github.com/Srini-web/pes_fb_piso#floorplan)  
  5. [Placement](https://github.com/Srini-web/pes_fb_piso#placement)  
  6. [CTS](https://github.com/Srini-web/pes_fb_piso#clock-tree-synthesis)  
  7. [Routing](https://github.com/Srini-web/pes_fb_piso#routing)
  8. [STA and Statistics](https://github.com/Srini-web/pes_fb_piso#routing)

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

## **III. Physical Design from Netlist to GDSII**
Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t power, performance and area.

General Physical Design Flow:

![p4flow](https://github.com/Srini-web/pes_fb_piso/assets/77874288/8e455ede-2848-4749-a678-0961d6d4af6c)


## Installations

```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

sudo docker run hello-world

sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 

# After reboot
docker run hello-world
```
Installing magic
```
sudo apt-get install m4
sudo apt-get install tcsh
sudo apt-get install csh
sudo apt-get install libx11-dev
sudo apt-get install tcl-dev tk-dev
sudo apt-get install libcairo2-dev
sudo apt-get install mesa-common-dev libglu1-mesa-dev
sudo apt-get install libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
make
make install
```
Installing PDKs and Tools
```
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```
Installing OpenSTA
```
https://github.com/The-OpenROAD-Project/OpenSTA
```
## Invoking Openlane
We begin by making a mount
```
cd OpenLane
make mount
```
To start the OpenLane flow in an interactive mode and to prepare the design, enter the below commands.

```
./flow.tcl -interactive
package require openlane
```

![s1mount](https://github.com/Srini-web/pes_fb_piso/assets/77874288/7b4dea4e-8255-4c8d-a205-b3a00eebe0ba)

Preparing the specified design

```
prep -design pes_fb_piso
```

![s2prep](https://github.com/Srini-web/pes_fb_piso/assets/77874288/5e542e74-a8e9-41ab-9c0e-cdb1026ca938)

Prior to the above step, we need to reconfigure the old `configure` json file to our specific design 

![p1Ajson](https://github.com/Srini-web/pes_fb_piso/assets/77874288/e48ef896-77c8-4b60-a552-17df0491d899)


We also need to create a standard inverter using 
https://github.com/Devipriya1921/Physical_Design_Using_OpenLANE_Sky130#inverter-standard-cell-layout--spice-extraction

Now we merge the inverter lef files with the main design using the commands

```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```

![s3merge](https://github.com/Srini-web/pes_fb_piso/assets/77874288/09e84aad-0dfb-41e6-964e-d2c0d6e4bd84)

## Synthesis

The next step is to synthesize. Run the below command.
```
run_synthesis
```

![s4synth](https://github.com/Srini-web/pes_fb_piso/assets/77874288/b2aeb64b-b355-437c-8129-547eb343581e)

The def file generated

![s5 1synth](https://github.com/Srini-web/pes_fb_piso/assets/77874288/b81e6fb2-85ed-4974-a3c1-fe46f9e6897d)

The statistics after synthesis can be found in the <current_run_directory>/reports/synthesis/1-synthesis.AREA_0.stat.rpt

![s5rpt](https://github.com/Srini-web/pes_fb_piso/assets/77874288/063a8ea8-3319-4520-9c6b-4b9bd3f6e54e)

![s6rptterm](https://github.com/Srini-web/pes_fb_piso/assets/77874288/99835f61-e513-445a-bec1-d8b2396c44a5)

#### Flop ratio 
```Flop Ratio= No. of d ffs/ No. of cells = 4/10 = 0.40 ```

## Floorplan

To run floorplan, we run the following commmand
```
run_floorplan
```
![s71floorplan](https://github.com/Srini-web/pes_fb_piso/assets/77874288/1ed78c31-03ef-4c40-8957-96379a4230ab)

To view the floorplan, we use the below magic command in the terminal opened in the directory: <current_run_directory>/results/floorplan
```
magic -T /home/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.min.lef def read pes_fb_piso.def &
```

![s9flrpln](https://github.com/Srini-web/pes_fb_piso/assets/77874288/c1e0a7db-f7e7-4a35-8ded-08f2e0d603dd)

![s10flrplnz1](https://github.com/Srini-web/pes_fb_piso/assets/77874288/2f1ceec2-d3b9-4395-88f5-56eb870b9cf7)

The die area and the core area report can be found in <current_run_dir>/reports/floorplan saves as 3-initial_fp_die_area.rpt and 3-initial_fp_core_area.rpt respectively. Find the below screenshots.

 	+ Core Area
 
![s11corearea](https://github.com/Srini-web/pes_fb_piso/assets/77874288/284e8330-c9b0-44b9-b489-b6eef7caba43)

	+ Die Area
 
 ![s12diearea](https://github.com/Srini-web/pes_fb_piso/assets/77874288/dc99722e-782a-4fe3-b23d-25a547b01fd2)

 ## Placement

 We run the below command to run placement

 ```
run_placement
```

![s13Aplacement](https://github.com/Srini-web/pes_fb_piso/assets/77874288/6c783d8e-4306-44e0-a854-3e0684ba804e)

View the placement in the layout, using the below magic command in the terminal opened in the directory: <current_run_directory>/results/placement

```
magic -T /home/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read pes_fb_piso.def &
```

![s14openplacement](https://github.com/Srini-web/pes_fb_piso/assets/77874288/1f3fdb1f-5079-4363-b7e4-8b689852290e)

The view after placement

![p2placement](https://github.com/Srini-web/pes_fb_piso/assets/77874288/32b26e51-5f84-407c-9735-a36d1e51ba12)

![p3placement2](https://github.com/Srini-web/pes_fb_piso/assets/77874288/e689ec4b-11fb-4e9d-81e0-6866fd3f7e6c)

## Clock Tree Synthesis

To run cts, execute the following command 
```
run_cts
```
![s15Acts](https://github.com/Srini-web/pes_fb_piso/assets/77874288/1eef85ce-1a0a-4a6c-8571-c5345ac4ceb6)

Timing Report

![s22ctstiming](https://github.com/Srini-web/pes_fb_piso/assets/77874288/b436086a-8456-42ec-98f7-284a4f9a87cb)

Power Report

![s23powerrpt](https://github.com/Srini-web/pes_fb_piso/assets/77874288/08e7c5a1-966d-4053-8be3-8437d0c746f0)

Slack Report

![s24ctsslack](https://github.com/Srini-web/pes_fb_piso/assets/77874288/68665458-1abb-4547-a450-37368cfc97fb)

Area Report

![s25ctsarearpt](https://github.com/Srini-web/pes_fb_piso/assets/77874288/236b86c8-49d8-438b-8c86-2b9ac2715855)


## Routing 

To run routing, run the following command
```
run_routing
```

![s16Arouting](https://github.com/Srini-web/pes_fb_piso/assets/77874288/62026d4f-d8f8-4ac7-acf4-da670558389b)

To view the layout after routing, using the below magic command in the terminal opened in the directory: <current_run_directory>/results/routing

```
magic -T /home/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read pes_fb_piso.def &
```

![s17routingcmd](https://github.com/Srini-web/pes_fb_piso/assets/77874288/8c537e8a-e692-4630-98a2-693957e9df5d)

View after opening

<img width="449" alt="s18Aroutingtemp" src="https://github.com/Srini-web/pes_fb_piso/assets/77874288/309743ed-dd9d-43e9-b7ae-b040e1d1aca2">

Area

<img width="448" alt="s19Adimen" src="https://github.com/Srini-web/pes_fb_piso/assets/77874288/ef77c4a4-a19b-449c-8504-7a25b5b692c2">

## STA 

Post statistics are viewed using OpenSTA in design mode 
1. Installation
```
sudo apt install opensta
```
2. Design Mode
```
./flow.tcl -design pes_fb_piso
```
Run the below commands on sta base to get the report_checks
```
read_liberty -max /home/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v95.lib
read_liberty -min /home/OpenLane/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
```
```
read_verilog /home/OpenLane/designs/pes_fb_piso_1/runs/<run number>/results/routing/pes_fb_piso.resized.v
link_design pes_fb_piso
read_sdc /home/OpenLane/designs/pes_fb_piso_1/runs/<run number>/results/cts/pes_fb_piso.sdc
read_spef /home/OpenLane/designs/pes_fb_piso_1/runs/<run number>/results/cts/pes_fb_piso.nom.spef
set_propagated_clock [all_clocks]
report_checks
report_clock_properties
```
<img width="295" alt="s20sta" src="https://github.com/Srini-web/pes_fb_piso/assets/77874288/b7fee604-960f-42a6-848b-e31921a7c9a0">

**Statistics**
- Area = 4878.272 um2
- Internal Power = 1.06e-05 W (87.3%)
- Switching Power = 1.55e-06 (12.7%)
- Leakage Power = 2.25e-10 (0.0%)
- Total Power = 1.22e-05 (100%)

