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
wire [15:0] data_a, data_b;
reg [15:0] reg_a, reg_b, diff;
reg error_next;
reg [2:0] state, state_next;
reg input_1, input_2, output_1, output_2;
reg input_1_next, input_2_next, output_1_next, output_2_next;

parameter [2:0] IDLE = 3'b000;
parameter [2:0] READDATA = 3'b001;
parameter [2:0] CALC = 3'b010;
parameter [2:0] FINISH = 3'b011;
parameter [2:0] FINISH_2 = 3'b100;

assign found = (reg_a == reg_b) ? 1'b1:0;

assign data_a = (reg_a > reg_b) ? reg_a : reg_b;
assign data_b = (reg_a > reg_b) ? reg_b : reg_a;

//assign diff = data_a - data_b;

/*assign swap = (reg_a > reg_b) ? 0:1'b1;

always @* begin  // swap block
	if (swap) begin
		data_a = reg_b;
		data_b = reg_a;
	end else begin
		data_a = reg_a;
		data_b = reg_b;
	end
end*/

always @* begin // sub block
	diff = data_a - data_b;
end

/*always @(posedge CLK, negedge RST_N) begin  // input block
	if (!RST_N) begin
		reg_a [15:0] = 16'b0;
		reg_b [15:0] = 16'b1;
	end
end*/

/*always @(posedge CLK, negedge RST_N) begin // output block
	if (!RST_N) begin
		Y = 0;
	end else begin
		Y = 0;
	end
end*/

always @(posedge CLK, negedge RST_N) begin  // state controller
	if (RST_N == 0) begin
		state <= IDLE;
		ERROR <= 0;
	end else begin
		state <= state_next;
		ERROR <= error_next;
		input_1 = input_1_next;
		input_2 = input_2_next;
		output_1 = output_1_next;
		output_2 = output_2_next;
	end
end

always @* begin  // next controller
//  	Y = 0;

	case (state)
		IDLE: begin
//			Y = 0;
			DONE = 0;
			input_1_next = 1;
			input_2_next = 0;
			output_1_next = 0;
			output_2_next = 0;
		
			if (START) begin
				state_next = READDATA;
			end else begin
				state_next = IDLE;
				error_next = 0;
			end
		end

		READDATA: begin
			DONE = 0;
			if (input_1) begin
				reg_a [15:8] = A;
				reg_b [15:8] = B;
	
				state_next = READDATA;
				input_1_next = 0;
				input_2_next = 1;
				error_next = 0;
			end else if (input_2) begin
				reg_a [7:0] = A;
				reg_b [7:0] = B;
	
				state_next = CALC;
				error_next = (reg_a==0 || reg_b==0) ? 1'b1:0;
			end else begin
				Y = 0;
			end
		end

		CALC: begin
			DONE = 0;
			input_1_next = 0;
			input_2_next = 0;
			if (found || ERROR) begin
				state_next = FINISH;
			end else begin
				if(data_b != 0) begin
					reg_a = data_b;
					reg_b = diff;
				end
				state_next = CALC;
			end
		end

		FINISH: begin
			DONE = 0;
			if (found) begin
				output_1_next = 1;
				output_2_next = 0;
				state_next = FINISH_2;
			end else begin
				DONE = 1;
				error_next = 0;
				state_next = IDLE;
			end
		end

		FINISH_2: begin
			if (output_1) begin
				Y = data_a [15:8];
				DONE = 1;
				output_1_next = 0;
				output_2_next = 1;
			end else if (output_2) begin
				Y = data_a [7:0];
				DONE = 1;
				error_next = 0;
				state_next = IDLE; 
			end
		end

		default: begin
			DONE = 0;
			state_next = IDLE;
			error_next = 0;
		end
	endcase
end

endmodule

