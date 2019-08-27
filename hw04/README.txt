Using the hw04_t.v file to switch the RTL simulation or gate-level simulation.
in the hw04_t.v file, you can comment out `define SYNTHESIS to do RTL simulation.

How to run simulation:

RTL:
	close `define SYNTHESIS and command $ make

gate-level:
	$ make syn

Note:
sram.v and pe.v is the non-synthesizable parts of this project.