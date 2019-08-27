module GCD (
	input wire CLK,
	input wire RST_N,
	input wire [7:0] A,
	input wire [7:0] B,
	input wire START,
	output reg [7:0] Y,
	output reg DONE,
	output reg ERROR
);

wire found, swap;
reg [7:0] reg_a, reg_b, data_a, data_b, diff;
reg error_next;
reg [1:0] state, state_next;

parameter [1:0] IDLE = 2'b00;
parameter [1:0] CALC = 2'b01;
parameter [1:0] FINISH = 2'b10;

assign found = (reg_a==reg_b || A==B) ? 1'b1:0;

assign swap = (reg_a > reg_b) ? 0:1'b1;

always @* // swap block
begin
	if(swap) begin
		data_a = reg_b;
		data_b = reg_a;
	end else begin
		data_a = reg_a;
		data_b = reg_b;
	end
end

always @* begin // sub block
	diff = data_a - data_b;
end

always @(posedge CLK, negedge RST_N)  // input block
begin
	if(!RST_N) begin
		reg_a = 0;
		reg_b = 1;
	end else if(START) begin
		reg_a = A;
		reg_b = B;
	end else begin
		if(data_b != 0) begin
			reg_a = data_b;
			reg_b = diff;
		end
	end
end

always @(posedge CLK, negedge RST_N)  // output block
begin
	if(!RST_N) begin
		Y = 0;
	end else if (found) begin
		Y = reg_a;
	end
end

always @(posedge CLK, negedge RST_N)  // state controller
begin
	if(RST_N == 0) begin
		state <= IDLE;
		ERROR = 0;
	end else begin
		state <= state_next;
		ERROR = error_next;
	end
end

always @* begin  // next controller
	case (state)
		IDLE: begin
			DONE = 0;
			if(START) begin
				state_next = CALC;
				error_next = (A==0 || B==0) ? 1:0;
			end else begin
				state_next = IDLE;
				error_next = 0;
			end
		end
		CALC: begin
			DONE = 0;
			if(found || ERROR) begin
				state_next = FINISH;
			end else begin
				state_next = CALC;
			end
			error_next = (A==0 || B==0) ? 1:0;
		end
		FINISH: begin
			DONE = 1;
			error_next = 0;
			state_next = IDLE;
		end
		default: begin
			DONE = 0;
			state_next = IDLE;
			error_next = 0;
		end
	endcase
end

endmodule

