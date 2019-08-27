module sram3x16x128 (
  input clk,
  input wen,
  input en,
  input [12:0] addr,
  input [7:0] d,
  output [7:0] q
);
 
  reg [7:0] ram [0:6143];
  reg [12:0] read_addr;
  integer c1, c2;

  initial begin
    // load the gray-scale image
    $readmemh(`A_HEX, ram);
	$readmemh(`B_HEX, ram, 2048);
  end
 
  always @(posedge clk) begin
    if (en) begin
      if (wen == 0)
        ram[addr] <= d;
      read_addr <= addr;
    end
	//$display("sram addr = %d", addr);
	//$display("en = %d", en);
	//$display("ram[%d] = %d", read_addr, ram[read_addr]);
  end
  assign q = ram[read_addr];

  // NOTE: you should declare q as reg type
  //
  // always @(posedge clk) begin
  //   if (en) begin
  //     if (wen == 0)
  //       ram[addr] <= d;
  //     q <= #1 ram[addr];
  //   end
  // end
  //

endmodule
