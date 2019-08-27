module sram32x256 (
	input clk,
	input wen,
	input [7:0] addr,
	input [31:0] d,
	output [31:0] q
);

reg [31:0] ram [0:255];
reg [7:0] read_addr;
	
always @(posedge clk) begin
	if (wen==0)
		ram[addr] <= d;
	read_addr <= addr;
end

assign q = ram[read_addr];

endmodule
