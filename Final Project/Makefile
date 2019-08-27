VLOG = ncverilog +nctimescale+1ns/1ps

SRC = top.v testbench.v sram.v RSA_v3.v

SYNSRC = testbench.v top.v sram.v RSA_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

VLOGARG = +access+r

all::sim

sim:
	$(VLOG) $(SRC) $(VLOGARG)
syn:
	$(VLOG) $(SYNSRC) $(VLOGARG)

