module filter (
  input wire clk,
  input wire rst_n,
  input wire fc_valid,
  input wire [7:0] working_pixel,  //q
  input signed [7:0] fc,
  input wire start,

  output reg [7:0] out_pixel,
  output reg out_valid,
  output reg [15:0] addr,
  output reg wen,
  output reg en,
  output reg [7:0] d
);

// :: Let wen = 1 and d = 0 all the time
// :: if you do not write any data into the SRAM.
// :: Note: You may use the following code segment but it will cause
// :: a warning because there is no event to check with @*
// :: If you want to avoid the warning, replace with assign and define
// :: the output wen and d as wires.
//
parameter [2:0] IDLE = 3'b000;
parameter [2:0] READ_K = 3'b001;
parameter [2:0] CALC_ADDR = 3'b010;
parameter [2:0] CALC = 3'b011;
parameter [2:0] DONE = 3'b100;

reg [1:0] state, state_next;
reg signed [9:0] row, row_next;
reg signed [9:0] col, col_next;
reg signed [9:0] _row, _col, _col_next, _row_next;

reg signed [15:0] Y, Y_next;
reg [1:0] isPadding, isPadding_next;

reg signed [15:0] w_p;
reg signed [15:0] kernel [0:4][0:4];
reg [3:0] i, j, i_next, j_next;


always @(posedge clk, negedge rst_n) begin  // state controller
	if (rst_n == 0) begin
		state <= IDLE;
		out_valid <= 0;
	end else begin
		state <= state_next;
		row <= row_next;
		col <= col_next;
		i <= i_next;
		j <= j_next;
		
		isPadding <= isPadding_next;
		
		if (_col_next==-2 && _row_next==-2) begin
			out_valid <= 1;
			if (Y_next > 255) begin
				out_pixel <= 255;
			end else if (Y_next < 0) begin
				out_pixel <= 0;
			end else begin
				out_pixel <= Y_next;
			end
			Y <= 0;
		end else begin
			out_valid <= 0;
			Y <= Y_next;
		end	

		_row <= _row_next;
		_col <= _col_next;
	end
end

always @* begin

	case (state)
		IDLE: begin
			en = 1;
			wen = 1;
			d = 0;

			Y_next = 0;
		
			row_next = 0;
			col_next = 0;
			
			_row_next = -2;  //NOT SURE
			_col_next = -2;

			i_next = 0;
			j_next = 0;
	
			if (start) begin		
				state_next = READ_K;
			end else begin
				state_next = IDLE;
			end
		end

		READ_K: begin
			state_next = READ_K;

			if (fc_valid) begin	
				if (j < 4) begin
					j_next = j + 1;
				end else begin
					if (i < 4) begin
						i_next = i + 1;
					end else begin
						state_next = CALC_ADDR;  // only when i==j==4 ???
						//$display("DONE HERE");
					end
					j_next = 0;
				end
				kernel[i][j] = fc;
				//$display("kernel[%1d][%1d] = %d", i, j , fc);
			end else begin    // fc_valid==0
				state_next = CALC_ADDR;
			end

		end

		CALC_ADDR: begin
			state_next = CALC;
			
			if (col+_col>=0 && row+_row>=0 && col+_col<256 && row+_row<256) begin
				addr = (row+_row)*256 + (col+_col);
				isPadding_next = 0;
			end	else begin
				isPadding_next = 1;
			end	
		end

		CALC: begin
			state_next = CALC_ADDR;
			w_p = working_pixel;

			if (_col < 2) begin  // -2~2
				_col_next = _col + 1;
			end else begin
				if (_row < 2) begin  // -2~2
					_row_next = _row + 1;
				end else begin
					if (col < 255) begin 
						col_next = col + 1;
					end else begin
						if (row < 255) begin
							row_next = row + 1;
						end else begin 
							state_next = DONE;
						end
						col_next = 0;
					end
					_row_next = -2;
				end
				_col_next = -2;
			end
			
			if (!isPadding) begin
				Y_next = Y +  w_p*kernel[_row+2][_col+2];
			end else begin
				Y_next = Y;
			end

			/*if (row==0 && col==0) begin
				$display("pixel[%1d][%1d] = %d", row+_row, col+_col, working_pixel);
				//$display("kernel[%1d][%1d] = %d", _row+2, _col+2, kernel[_row+2][_col+2]);
				$display("Y[%1d][%1d] = %d", _row+row, _col+col, Y);
			end  */

		end

		DONE: begin
			state_next = DONE;
		end

		default: begin
			state_next = IDLE;
		end
	endcase
end









endmodule
