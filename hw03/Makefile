VLOG = ncverilog +nctimescale+1ns/1ps

SRC = top.v load_bmp.v sram.v hw03a.v

SYNSRC_A = load_bmp.v top.v hw03a_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SYNSRC_B = load_bmp.v top.v hw03b_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

SYNSRC_C = load_bmp.v top_c.v hw03c_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v


VLOGARG = +access+r

all::sim

sim:
	$(VLOG) $(SRC) $(VLOGARG)
syna:
	$(VLOG) $(SYNSRC_A) $(VLOGARG)
synb:
	$(VLOG) $(SYNSRC_B) $(VLOGARG)
sync:
	$(VLOG) $(SYNSRC_C) $(VLOGARG)
