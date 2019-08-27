Using the hw02_h.v file to switch the RTL simulation or gate-level simulation.
in the hw02_h.v file, you can comment out `define SYNTHESIS to do RTL simulation.

How to run simulation:

RTL:
	close `define SYNTHESIS and command $ make

gate-level:
	$ make syn