module systolic (
  input wire clk,
  input wire rst_n,
  input wire [7:0] q,
  input wire start,

  output reg [7:0] out_pixel,
  output reg out_valid,
  output reg [15:0] addr,
  output reg wen,
  output reg en,
  output reg [7:0] d
);

// processing elements
reg [7:0] a0, a1, a2, a3, b0, b1, b2, b3;
reg [7:0] A [0:15];
reg [7:0] B [0:15];
wire [7:0] C [0:15];

wire [7:0] a01, a12, a23, 
		b04, b15, b26, b37, 
		a45, a56, a67, 
		b48, b59, b610, b711, 
		a89, a910, a1011, 
		b812, b913, b1014, b1115, 
		a1213, a1314, a1415;

reg r0, r1, r2, r3, r4, r5, r6;

pe pe0(.clk(clk), .rst_n(r0), .in_a(a0), .in_b(b0), .out_a(a01), .out_b(b04), .out_c(C[0]));
pe pe1(.clk(clk), .rst_n(r1), .in_a(a01), .in_b(b1), .out_a(a12), .out_b(b15), .out_c(C[1]));
pe pe2(.clk(clk), .rst_n(r2), .in_a(a12), .in_b(b2), .out_a(a23), .out_b(b26), .out_c(C[2]));
pe pe3(.clk(clk), .rst_n(r3), .in_a(a23), .in_b(b3), .out_a(), .out_b(b37), .out_c(C[3]));
pe pe4(.clk(clk), .rst_n(r1), .in_a(a1), .in_b(b04), .out_a(a45), .out_b(b48), .out_c(C[4]));
pe pe5(.clk(clk), .rst_n(r2), .in_a(a45), .in_b(b15), .out_a(a56), .out_b(b59), .out_c(C[5]));
pe pe6(.clk(clk), .rst_n(r3), .in_a(a56), .in_b(b26), .out_a(a67), .out_b(b610), .out_c(C[6]));
pe pe7(.clk(clk), .rst_n(r4), .in_a(a67), .in_b(b37), .out_a(), .out_b(b711), .out_c(C[7]));
pe pe8(.clk(clk), .rst_n(r2), .in_a(a2), .in_b(b48), .out_a(a89), .out_b(b812), .out_c(C[8]));
pe pe9(.clk(clk), .rst_n(r3), .in_a(a89), .in_b(b59), .out_a(a910), .out_b(b913), .out_c(C[9]));
pe pe10(.clk(clk), .rst_n(r4), .in_a(a910), .in_b(b610), .out_a(a1011), .out_b(b1014), .out_c(C[10]));
pe pe11(.clk(clk), .rst_n(r5), .in_a(a1011), .in_b(b711), .out_a(), .out_b(b1115), .out_c(C[11]));
pe pe12(.clk(clk), .rst_n(r3), .in_a(a3), .in_b(b812), .out_a(a1213), .out_b(), .out_c(C[12]));
pe pe13(.clk(clk), .rst_n(r4), .in_a(a1213), .in_b(b913), .out_a(a1314), .out_b(), .out_c(C[13]));
pe pe14(.clk(clk), .rst_n(r5), .in_a(a1314), .in_b(b1014), .out_a(a1415), .out_b(), .out_c(C[14]));
pe pe15(.clk(clk), .rst_n(r6), .in_a(a1415), .in_b(b1115), .out_a(), .out_b(), .out_c(C[15]));

parameter [3:0] IDLE = 4'b0000;
parameter [3:0] READ_1 = 4'b0001;
parameter [3:0] READ_2 = 4'b0010;
parameter [3:0] CALC = 4'b0011;
parameter [3:0] STORE_1 = 4'b0100;
parameter [3:0] STORE_2 = 4'b0101;
parameter [3:0] STORE_1_5 = 4'b0110;
parameter [3:0] DONE = 4'b0111;
parameter [3:0] TEST = 4'b1000;


reg [3:0] state, state_next;
reg [9:0] indexA, indexA_next, _indexA, _indexA_next;	// 0~15
reg [9:0] batchA, batchA_next;	// 0~127
reg flag_A, flag_A_next;
reg [4:0] indexB, indexB_next, _indexB, _indexB_next;
reg [9:0] batchB, batchB_next;  // 128~255

reg [3:0] cal_c, cal_c_next;  // CALC

reg [9:0] batchC, batchC_next;  // 256~383
reg [9:0] indexC, indexC_next;  // 0~15

always @(posedge clk, negedge rst_n) begin  // state controller
	if (rst_n == 0) begin
		state <= IDLE;
		out_valid <= 0;
	end else begin
		state <= state_next;
		indexA <= indexA_next;
		_indexA <= _indexA_next;
		batchA <= batchA_next;
		flag_A <= flag_A_next;
		indexB <= indexB_next;
		batchB <= batchB_next;
		_indexB <= _indexB_next;

		cal_c <= cal_c_next;

		batchC <= batchC_next;
		indexC <= indexC_next;

		// output out_log.txt	
		if (state_next == STORE_1 ) begin
			out_valid <= 1;
			out_pixel <= C[indexC_next];
		//	$display("%d", C[indexC_next]);
		end else begin
			out_valid <= 0;
		end
			
	end
end

always @* begin

	case (state)
		IDLE: begin
			en = 1;
			wen = 1;
			d = 0;

			indexA_next = 0;
			batchA_next = 0;
			flag_A_next = 1;
			indexB_next = 0;
			batchB_next = 128;

			cal_c_next = 0;

			batchC_next = 256;
			indexC_next = 0;

		if (start) begin		
				state_next = READ_1;
			end else begin
				state_next = IDLE;
			end
		end

		READ_1: begin
			state_next = READ_2;
			
			if (flag_A) begin
				_indexA_next = indexA;
				if (batchA < 128) begin  // 0~127
					if (indexA < 15) begin
						indexA_next = indexA + 1;
					end else begin
						indexA_next = 0;
						batchA_next = batchA + 1;
					end
				end else begin
					state_next = READ_2;
				end
 				addr = batchA*16 + indexA;
			end else begin
				_indexB_next = indexB;
				if (batchB < 256) begin  // 128~255	
					if (indexB < 15) begin
						indexB_next = indexB + 1;
					end else begin
						indexB_next = 0;
						batchB_next = batchB + 1;
					end
				end else begin
					state_next = READ_2;
				end
				addr = batchB*16 + indexB;
			end	
		end

		READ_2: begin
			if (_indexA==15 && _indexB==15) begin
				state_next = CALC;
				indexA_next = 0;
				indexB_next = 0;
				_indexA_next = 0;
				_indexB_next = 0;
				flag_A_next = 1;
				r0 = 0;  // reset
			end else begin
				state_next = READ_1;
			end

			if (flag_A) begin
				A[_indexA] = q;
				if (_indexA==15) begin
					flag_A_next = 0;
				end else begin
					flag_A_next = 1;
				end
			end else begin
				B[_indexB] = q;
			end
		end

		CALC: begin
			
			en = 0;
			if (cal_c == 0) begin
				r0 = 1;
				r1 = 0;
				a0 = A[0]; a1 = 0; a2 = 0; a3 = 0;
				b0 = B[0]; b1 = 0; b2 = 0; b3 = 0;
				cal_c_next = cal_c + 1;
				state_next = CALC;
			end else if (cal_c == 1) begin
				r1 = 1;
				r2 = 0;
				a0 = A[1]; a1 = A[4]; a2 = 0; a3 = 0;
				b0 = B[4]; b1 = B[1]; b2 = 0; b3 = 0;
				cal_c_next = cal_c + 1;
				state_next = CALC;
			end else if (cal_c == 2) begin
				r2 = 1;
				r3 = 0;
				a0 = A[2]; a1 = A[5]; a2 = A[8]; a3 = 0;
				b0 = B[8]; b1 = B[5]; b2 = B[2]; b3 = 0;
				cal_c_next = cal_c + 1;
				state_next = CALC;
			end else if (cal_c == 3) begin
				r3 = 1;
				r4 = 0;
				a0 = A[3]; a1 = A[6]; a2 = A[9]; a3 = A[12];
				b0 = B[12]; b1 = B[9]; b2 = B[6]; b3 = B[3];
				cal_c_next = cal_c + 1;
				state_next = CALC;	
			end else if (cal_c == 4) begin
				r4 = 1;
				r5 = 0;
				a0 = 0; a1 = A[7]; a2 = A[10]; a3 = A[13];
				b0 = 0; b1 = B[13]; b2 = B[10]; b3 = B[7];
				cal_c_next = cal_c + 1;
				state_next = CALC;	
			end else if (cal_c == 5) begin
				r5 = 1;
				r6 = 0;
				a0 = 0; a1 = 0; a2 = A[11]; a3 = A[14];
				b0 = 0; b1 = 0; b2 = B[14]; b3 = B[11];
				cal_c_next = cal_c + 1;
				state_next = CALC;	
			end else if (cal_c == 6) begin
				r6 = 1;
				a0 = 0; a1 = 0; a2 = 0; a3 = A[15];
				b0 = 0; b1 = 0; b2 = 0; b3 = B[15];
				cal_c_next = cal_c + 1;
				state_next = CALC;
			end else if (cal_c == 7) begin
				a0 = 0; a1 = 0; a2 = 0; a3 = 0;
				b0 = 0; b1 = 0; b2 = 0; b3 = 0;
				cal_c_next = cal_c + 1;
				state_next = CALC;
			end else begin
				//wait
				state_next = STORE_1;
				cal_c_next = 0;
//			$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ", 
//			A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[8], A[9], A[10], A[11], A[12], A[13], A[14], A[15]);
//			$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ", 
//			B[0], B[1], B[2], B[3], B[4], B[5], B[6], B[7], B[8], B[9], B[10], B[11], B[12], B[13], B[14], B[15]);	
			end
		end

		STORE_1: begin
			state_next = STORE_1_5;		
	
			en = 1;
			wen = 0;
			if (batchC < 384) begin  // 256~383
				if (indexC < 15) begin
					indexC_next = indexC + 1;
				end else begin
					state_next = STORE_2;
					batchC_next = batchC + 1;
					indexC_next = 0;
					wen = 1;
				end
			end else begin
				state_next = STORE_2;
				wen = 1;
			end
			addr = batchC*16 + indexC;
			d = C[indexC];

		end

		STORE_1_5: begin
			state_next = STORE_1;
		end

		STORE_2: begin
//			$display("batch = %d", batchA);
//		$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ", 
//			C[0], C[1], C[2], C[3], C[4], C[5], C[6], C[7], C[8], C[9], C[10], C[11], C[12], C[13], C[14], C[15]);		
			if (batchC == 384) begin
				state_next = DONE;
			end else begin
				wen = 1;
				state_next = READ_1;
				indexC_next = 0;
			end			
		end

		DONE: begin
			state_next = DONE;
		end

		TEST: begin
			state_next = TEST;	

			addr = 6142;
			$display("tt = %d", q);
		end

		default: begin
			state_next = IDLE;
		end
	endcase
end


endmodule
