Using the RSA_v3.v file to switch the RTL simulation or gate-level simulation.
in the testbench.v file, you can comment out `define SYNTHESIS to do RTL simulation.

synthesis.tcl is the tcl code to run synthesis.

Note that my RTL code is failed to synthesis!!!

How to run simulation:

RTL:
	close `define SYNTHESIS and command $ make

gate-level:
	$ make syn

Note:
sram.v is the non-synthesizable parts of this project.