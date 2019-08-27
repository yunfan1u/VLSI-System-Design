module top;
  wire clk;
  wire rst_n;
  wire start;
  wire [12:0] addr;
  wire wen;
  wire en;
  wire out_valid;
  wire [7:0] d;
  wire [7:0] q;
  wire [7:0] out_pixel;

  load_bmp testbench (
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .out_pixel(out_pixel),
    .out_valid(out_valid)
  );

  sram3x16x128 sram (
    .clk(clk),
    .wen(wen),
    .en(en),
    .addr(addr),
    .d(d),
    .q(q)
  );

  systolic sys (
    .clk(clk),
    .rst_n(rst_n),
    .q(q),
    .wen(wen),
    .en(en),
    .out_pixel(out_pixel),
    .out_valid(out_valid),
    .d(d),
    .addr(addr),
    .start(start)
  );

endmodule
