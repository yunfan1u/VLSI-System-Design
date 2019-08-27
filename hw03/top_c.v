module top;
  wire clk;
  wire rst_n;
  wire start;
  wire [15:0] addra;
  wire [15:0] addrb;
  wire wena;
  wire wenb;
  wire ena;
  wire enb;
  wire out_valid;
  wire [7:0] da;
  wire [7:0] qa;
  wire [7:0] qb;
  wire signed [7:0] fc;
  wire [7:0] out_pixel;

  load_bmp testbench (
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .fc_valid(fc_valid),
    .fc(fc),
    .out_pixel(out_pixel),
    .out_valid(out_valid)
  );

  sram_dp sram (
    .clka(clk),
    .clkb(clk),
    .wena(wena),
	.wenb(wenb),
    .ena(ena),
	.enb(enb),
    .addra(addra),
	.addrb(addrb),
    .da(da),
	.db(db),
    .qa(qa),
	.qb(qb)
  );

  filter filt (
    .clk(clk),
    .rst_n(rst_n),
    .fc_valid(fc_valid),
    .qa(qa),
	.qb(qb),
    .wena(wena),
	.wenb(wenb),
    .ena(ena),
	.enb(enb),
    .fc(fc),
    .out_pixel(out_pixel),
    .out_valid(out_valid),
    .da(da),
	.db(db),
    .addra(addra),
	.addrb(addrb),
    .start(start)
  );

endmodule
