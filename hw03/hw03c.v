module filter (
  input wire clk,
  input wire rst_n,
  input wire fc_valid,
  input wire [7:0] qa,  //q
  input wire [7:0] qb,  
  input signed [7:0] fc,
  input wire start,

  output reg [7:0] out_pixel,
  output reg out_valid,
  output reg [15:0] addra,
  output reg [15:0] addrb,
  output reg wena,
  output reg wenb,
  output reg ena,
  output reg enb,
  output reg [7:0] da,
  output reg [7:0] db
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

reg signed [15:0] Y;
reg [1:0] isPaddinga, isPaddinga_next;
reg [1:0] isPaddingb, isPaddingb_next;

reg signed [15:0] kernel [0:4][0:4];
reg [3:0] i, j, i_next, j_next;

reg [4:0] ka, kb;
reg signed [15:0] pArray [0:24];

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
		
		isPaddinga <= isPaddinga_next;
		isPaddingb <= isPaddingb_next;

		if (_col_next==-2 && _row_next==-2) begin
			out_valid <= 1;
			if (Y > 255) begin
				out_pixel <= 255;
			end else if (Y < 0) begin
				out_pixel <= 0;
			end else begin
				out_pixel <= Y;
			end
			//Y <= 0;
		end else begin
			out_valid <= 0;
			//Y <= Y_next;
		end	

		_row <= _row_next;
		_col <= _col_next;
	end
end

always @* begin

	case (state)
		IDLE: begin
			ena = 1;
			enb = 1;
			wena = 1;
			wenb = 1;
			da = 0;
			db = 0;

			// Y_next = 0;
		
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
					end
					j_next = 0;
				end
				kernel[i][j] = fc;
			end else begin    // fc_valid==0
				state_next = CALC_ADDR;
			end

		end

		CALC_ADDR: begin
			state_next = CALC;
			
			if (col+_col>=0 && row+_row>=0 && col+_col<256 && row+_row<256) begin
				addra = (row+_row)*256 + (col+_col);
				isPaddinga_next = 0;
			end	else begin
				isPaddinga_next = 1;
			end

			if (_row<0) begin
				if (col+_col>=0 && row+_row+3>=0 && col+_col<256 && row+_row+3<256) begin
					addrb = (row+_row+3)*256 + (col+_col);
					isPaddingb_next = 0;
				end else begin
					isPaddingb_next = 1;
				end
			end else begin
				isPaddingb_next = 1;
			end

	
		end

		CALC: begin
			state_next = CALC_ADDR;

			ka = (_row+2)*5 + (_col+2);
			if (!isPaddinga) begin
				pArray[ka] = qa;
			end else begin
				pArray[ka] = 0;
			end

			if (_row<0) begin
				kb = (_row+5)*5 + (_col+2);
				if (!isPaddingb) begin
					pArray[kb] = qb;
				end else begin
					pArray[kb] = 0;
				end
			end else begin
				kb = 0;
			end

			if (_col < 2) begin  // -2~2
				_col_next = _col + 1;
			end else begin
				if (_row < 0) begin  // -2~0
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
		
			if (_col==2 && _row==0) begin
				Y =		 pArray[0]*kernel[0][0] +
						 pArray[1]*kernel[0][1] +
						 pArray[2]*kernel[0][2] +
	 					 pArray[3]*kernel[0][3] +
	 					 pArray[4]*kernel[0][4] +
	 					 pArray[5]*kernel[1][0] +
	 					 pArray[6]*kernel[1][1] +
	 					 pArray[7]*kernel[1][2] +
	 					 pArray[8]*kernel[1][3] +
	 					 pArray[9]*kernel[1][4] +
	 					 pArray[10]*kernel[2][0] +
	 					 pArray[11]*kernel[2][1] +
	 					 pArray[12]*kernel[2][2] +
	 					 pArray[13]*kernel[2][3] +
	 					 pArray[14]*kernel[2][4] +
	 					 pArray[15]*kernel[3][0] +
	 					 pArray[16]*kernel[3][1] +
	 					 pArray[17]*kernel[3][2] +
	 					 pArray[18]*kernel[3][3] +
	 					 pArray[19]*kernel[3][4] +
	 					 pArray[20]*kernel[4][0] +
	 					 pArray[21]*kernel[4][1] +
	 					 pArray[22]*kernel[4][2] +
	 					 pArray[23]*kernel[4][3] +
	 					 pArray[24]*kernel[4][4];
			end else begin
				Y = 0;
			end






	
			/*if (!isPadding) begin
				Y_next = Y + w_p*kernel[_row+2][_col+2];
			end else begin
				Y_next = Y;
			end*/
	
		//	if (row==0 && col==0) begin
		//		$display("pArray[%d] = %d", 12, pArray[12]);
		//	end

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
