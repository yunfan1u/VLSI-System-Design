module top;
  wire clk;
  wire rst_n;
  wire exe;
  wire [7:0] addr;
  wire wen;
  wire mode;
  wire [31:0] data;
  wire [31:0] result;
  wire oe_n;
  wire [1:0] status;
  wire done;

  load_bmp testbench (
	.clk(clk),
	.rst_n(rst_n),
	.exe(exe),
	.addr(addr),
	.mode(mode),
	.wen(wen),
	.data(data),
	.status(status),
	.done(done)
);

  rsa rsa01 (
	.clk(clk),
	.rst_n(rst_n),
	.addr(addr),
	.exe(exe),
	.wen(wen),
	.data(data),
	.result(reault),
	.oe_n(oe_n),
	.status(status),
	.done(done)
);

endmodule
