// Dual-port SRAM template

module sram_dp (
  input clka,
  input clkb,
  input ena,
  input enb,
  input wena,
  input wenb,
  input [9:0] addra,
  input [9:0] addrb,
  input [7:0] da,
  input [7:0] db,
  output [7:0] qa,
  output [7:0] qb
);

reg [7:0] ram [0:65535];
reg [15:0] read_addra, read_addrb;

initial begin
	$readmemh(`IMAGE_GRAY_HEX, ram);
end

  always @(posedge clka) begin
    if (ena) begin
      if (wena == 0)
        ram[addra] <= da;
      // qa <= #1 ram[addra];
	  read_addra <= addra;
    end
  end

  assign qa = ram[read_addra];

  // 
  // always @(posedge clka) begin
  //   if (ena) begin
  //     if (wena == 0) begin
  //       ram[addra] <= da;
  //       qa <= #1 da;
  //     end else begin
  //       qa <= #1 ram[addra];
  //     end
  //   end
  // end
  //

  always @(posedge clkb) begin
    if (enb) begin
      if (wenb == 0)
        ram[addrb] <= db;
      // qb <= #1 ram[addrb];
	  read_addrb <= addrb;
    end
  end

  assign qb = ram[read_addrb];

endmodule
