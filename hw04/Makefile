VLOG = ncverilog +nctimescale+1ns/1ps

SRC = top.v hw04_t.v sram.v pe.v hw04.v

SYNSRC = hw04_t.v top.v sram.v pe.v hw04_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

VLOGARG = +access+r

all::sim

sim:
	$(VLOG) $(SRC) $(VLOGARG)
syn:
	$(VLOG) $(SYNSRC) $(VLOGARG)

