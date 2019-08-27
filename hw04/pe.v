module pe (
	input wire clk,
	input wire rst_n,
	input wire [7:0] in_a,
	input wire [7:0] in_b,
	output reg [7:0] out_c,
	output reg [7:0] out_a,
	output reg [7:0] out_b
);

reg [7:0] out_c_next, out_a_next, out_b_next;

always @(posedge clk, negedge rst_n) begin
	if (rst_n == 0) begin
		out_a = 0;
		out_b = 0;
		out_c = 0;
	end else begin
		out_c = out_c_next;
		out_a = in_a;
		out_b = in_b;
	end
end


always @* begin
	if (rst_n != 0) begin
		out_c_next = out_c + in_a*in_b;
	end else begin
		out_c_next = 0;
		//out_a_next = in_a;
		//out_b_next = in_b;
	end
end

endmodule	
