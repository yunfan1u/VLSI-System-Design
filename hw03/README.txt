Using the load_bmp.v file to switch the RTL simulation or gate-level simulation.
in the load_bmp.v file, you can comment out `define SYNTHESIS to do RTL simulation.

How to run simulation:

RTL:
	close `define SYNTHESIS and command $ make

gate-level:
for hw03a:
	$ make syna 
for hw03b:
	$ make synb
for hw03c:
	$ make sync