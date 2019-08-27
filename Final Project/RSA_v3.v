module rsa (
	input wire clk,
	input wire rst_n,
	input wire [7:0] addr,
	input wire wen,
	input wire [31:0] data,
	input exe,
	input mode,

	output reg [31:0] result,
	output reg oe_n,
	output reg [1:0] status,
	output reg done
);

parameter [3:0] IDLE = 4'b0000;
parameter [3:0] KEY_E = 4'b0001;
parameter [3:0] KEY_D = 4'b0010;
parameter [3:0] KEY_N = 4'b0011;

parameter [3:0] DATA_FEED = 4'b0100; 

parameter [3:0] LR_1 = 4'b0101;
parameter [3:0] LR_2_MUL = 4'b0110;
parameter [3:0] LR_3 = 4'b0111;
parameter [3:0] LR_3_MUL = 4'b1000;
parameter [3:0] LR_4 = 4'b1001;

parameter [3:0] OUTPUT = 4'b1010;
parameter [3:0] OUTPUT_PRINT = 4'b1011;
parameter [3:0] RELOAD = 4'b1100;
parameter [3:0] RELOAD_2 = 4'b1101;

parameter [3:0] DONE = 4'b1111;

reg [2047:0] E, D, N;
reg [2047:0] A;  // input data
reg [4095:0] C, C_next;
reg [4095:0] tmp;

reg [31:0] EE [0:63];
reg [31:0] DD [0:63];
reg [31:0] NN [0:63];
reg [31:0] AA [0:63];

reg [31:0] CC [0:63];

wire [31:0] q;
reg [7:0] _addr;
reg _wen;


reg [3:0] state, state_next;
reg [6:0] key_e, key_e_next;
reg [6:0] key_d, key_d_next;
reg [6:0] key_n, key_n_next;
reg [6:0] data_feed, data_feed_next;

reg [11:0] i, i_next;

reg [6:0] m, n, m_next, n_next;
reg [6:0] p, p_next;
reg [6:0] op, op_next;

sram32x256 sram(
	.clk(clk),
	.wen(_wen),
	.addr(_addr),
	.d(data),  //??
	.q(q)
);



always @(posedge clk, negedge rst_n) begin
	if (rst_n == 0) begin
		state <= IDLE;
	end else begin
		state <= state_next;
		key_e <= key_e_next;
		key_d <= key_d_next;
		key_n <= key_n_next;
		data_feed <= data_feed_next;
		i <= i_next;

		C <= C_next;

		m <= m_next;
		n <= n_next;
		p <= p_next;
		op <= op_next;
	end
end

always @* begin

	case (state)
		IDLE: begin  		
			done = 0;
			status = 0;
			oe_n = 1;
				
			key_e_next = 0;
			key_d_next = 0;			
			key_n_next = 0;
			data_feed_next = 0;

			C_next = 0;

			i_next = 2047;
			m_next = 0;
			n_next = 0;
			p_next = 0;
			op_next = 0;

			if (exe) begin
				state_next = KEY_E;
			end else begin
				state_next = IDLE;
			end
		end

		KEY_E: begin
			state_next = KEY_E;  // 64 cycles
			key_e_next = key_e + 1;

			_wen = 0;			

			if (key_e == 0) begin
				E[2047:2016] = data; _addr = addr; EE[0] = data;
			end else if (key_e == 1) begin
				E[2015:1984] = data; _addr = addr; EE[1] = data;
			end else if (key_e == 2) begin
				E[1983:1952] = data; _addr = addr; EE[2] = data;
			end else if (key_e == 3) begin
				E[1951:1920] = data; _addr = addr; EE[3] = data;
			end else if (key_e == 4) begin
				E[1919:1888] = data; _addr = addr; EE[4] = data;
			end else if (key_e == 5) begin
				E[1887:1856] = data; _addr = addr; EE[5] = data;
			end else if (key_e == 6) begin
				E[1855:1824] = data; _addr = addr; EE[6] = data;
			end else if (key_e == 7) begin
				E[1823:1792] = data; _addr = addr; EE[7] = data;
			end else if (key_e == 8) begin
				E[1791:1760] = data; _addr = addr; EE[8] = data;
			end else if (key_e == 9) begin
				E[1759:1728] = data; _addr = addr; EE[9] = data;
			end else if (key_e == 10) begin
				E[1727:1696] = data; _addr = addr; EE[10] = data;
			end else if (key_e == 11) begin
				E[1695:1664] = data; _addr = addr; EE[11] = data;
			end else if (key_e == 12) begin
				E[1663:1632] = data; _addr = addr; EE[12] = data;
			end else if (key_e == 13) begin
				E[1631:1600] = data; _addr = addr; EE[13] = data;
			end else if (key_e == 14) begin
				E[1599:1568] = data; _addr = addr; EE[14] = data;
			end else if (key_e == 15) begin
				E[1567:1536] = data; _addr = addr; EE[15] = data;
			end else if (key_e == 16) begin
				E[1535:1504] = data; _addr = addr; EE[16] = data;
			end else if (key_e == 17) begin
				E[1503:1472] = data; _addr = addr; EE[17] = data;
			end else if (key_e == 18) begin
				E[1471:1440] = data; _addr = addr; EE[18] = data;
			end else if (key_e == 19) begin
				E[1439:1408] = data; _addr = addr; EE[19] = data;
			end else if (key_e == 20) begin
				E[1407:1376] = data; _addr = addr; EE[20] = data;
			end else if (key_e == 21) begin
				E[1375:1344] = data; _addr = addr; EE[21] = data;
			end else if (key_e == 22) begin
				E[1343:1312] = data; _addr = addr; EE[22] = data;
			end else if (key_e == 23) begin
				E[1311:1280] = data; _addr = addr; EE[23] = data;
			end else if (key_e == 24) begin
				E[1279:1248] = data; _addr = addr; EE[24] = data;
			end else if (key_e == 25) begin
				E[1247:1216] = data; _addr = addr; EE[25] = data;
			end else if (key_e == 26) begin
				E[1215:1184] = data; _addr = addr; EE[26] = data;
			end else if (key_e == 27) begin
				E[1183:1152] = data; _addr = addr; EE[27] = data;
			end else if (key_e == 28) begin
				E[1151:1120] = data; _addr = addr; EE[28] = data;
			end else if (key_e == 29) begin
				E[1119:1088] = data; _addr = addr; EE[29] = data;
			end else if (key_e == 30) begin
				E[1087:1056] = data; _addr = addr; EE[30] = data;
			end else if (key_e == 31) begin
				E[1055:1024] = data; _addr = addr; EE[31] = data;
			end else if (key_e == 32) begin
				E[1023:992] = data; _addr = addr; EE[32] = data;
			end else if (key_e == 33) begin
				E[991:960] = data; _addr = addr; EE[33] = data;
			end else if (key_e == 34) begin
				E[959:928] = data; _addr = addr; EE[34] = data;
			end else if (key_e == 35) begin
				E[927:896] = data; _addr = addr; EE[35] = data;
			end else if (key_e == 36) begin
				E[895:864] = data; _addr = addr; EE[36] = data;
			end else if (key_e == 37) begin
				E[863:832] = data; _addr = addr; EE[37] = data;
			end else if (key_e == 38) begin
				E[831:800] = data; _addr = addr; EE[38] = data;
			end else if (key_e == 39) begin
				E[799:768] = data; _addr = addr; EE[39] = data;
			end else if (key_e == 40) begin
				E[767:736] = data; _addr = addr; EE[40] = data;
			end else if (key_e == 41) begin
				E[735:704] = data; _addr = addr; EE[41] = data;
			end else if (key_e == 42) begin
				E[703:672] = data; _addr = addr; EE[42] = data;
			end else if (key_e == 43) begin
				E[671:640] = data; _addr = addr; EE[43] = data;
			end else if (key_e == 44) begin
				E[639:608] = data; _addr = addr; EE[44] = data;
			end else if (key_e == 45) begin
				E[607:576] = data; _addr = addr; EE[45] = data;
			end else if (key_e == 46) begin
				E[575:544] = data; _addr = addr; EE[46] = data;
			end else if (key_e == 47) begin
				E[543:512] = data; _addr = addr; EE[47] = data;
			end else if (key_e == 48) begin
				E[511:480] = data; _addr = addr; EE[48] = data;
			end else if (key_e == 49) begin
				E[479:448] = data; _addr = addr; EE[49] = data;
			end else if (key_e == 50) begin
				E[447:416] = data; _addr = addr; EE[50] = data;
			end else if (key_e == 51) begin
				E[415:384] = data; _addr = addr; EE[51] = data;
			end else if (key_e == 52) begin
				E[383:352] = data; _addr = addr; EE[52] = data;
			end else if (key_e == 53) begin
				E[351:320] = data; _addr = addr; EE[53] = data;
			end else if (key_e == 54) begin
				E[319:288] = data; _addr = addr; EE[54] = data;
			end else if (key_e == 55) begin
				E[287:256] = data; _addr = addr; EE[55] = data;
			end else if (key_e == 56) begin
				E[255:224] = data; _addr = addr; EE[56] = data;
			end else if (key_e == 57) begin
				E[223:192] = data; _addr = addr; EE[57] = data;
			end else if (key_e == 58) begin
				E[191:160] = data; _addr = addr; EE[58] = data;
			end else if (key_e == 59) begin
				E[159:128] = data; _addr = addr; EE[59] = data;
			end else if (key_e == 60) begin
				E[127:96] = data; _addr = addr; EE[60] = data;
			end else if (key_e == 61) begin
				E[95:64] = data; _addr = addr; EE[61] = data;
			end else if (key_e == 62) begin
				E[63:32] = data; _addr = addr; EE[62] = data;
			end else begin
    			E[31:0] = data; _addr = addr; EE[63] = data;
				state_next = KEY_D;
			end

		end

		KEY_D: begin
			state_next = KEY_D;  // 64 cycles
			key_d_next = key_d + 1;

			if (key_d == 0) begin
				D[2047:2016] = data; _addr = addr;
			end else if (key_d == 1) begin
				D[2015:1984] = data; _addr = addr;
			end else if (key_d == 2) begin
				D[1983:1952] = data; _addr = addr;
			end else if (key_d == 3) begin
				D[1951:1920] = data; _addr = addr;
			end else if (key_d == 4) begin
				D[1919:1888] = data; _addr = addr;
			end else if (key_d == 5) begin
				D[1887:1856] = data; _addr = addr;
			end else if (key_d == 6) begin
				D[1855:1824] = data; _addr = addr;
			end else if (key_d == 7) begin
				D[1823:1792] = data; _addr = addr;
			end else if (key_d == 8) begin
				D[1791:1760] = data; _addr = addr;
			end else if (key_d == 9) begin
				D[1759:1728] = data; _addr = addr;
			end else if (key_d == 10) begin
				D[1727:1696] = data; _addr = addr;
			end else if (key_d == 11) begin
				D[1695:1664] = data; _addr = addr;
			end else if (key_d == 12) begin
				D[1663:1632] = data; _addr = addr;
			end else if (key_d == 13) begin
				D[1631:1600] = data; _addr = addr;
			end else if (key_d == 14) begin
				D[1599:1568] = data; _addr = addr;
			end else if (key_d == 15) begin
				D[1567:1536] = data; _addr = addr;
			end else if (key_d == 16) begin
				D[1535:1504] = data; _addr = addr;
			end else if (key_d == 17) begin
				D[1503:1472] = data; _addr = addr;
			end else if (key_d == 18) begin
				D[1471:1440] = data; _addr = addr;
			end else if (key_d == 19) begin
				D[1439:1408] = data; _addr = addr;
			end else if (key_d == 20) begin
				D[1407:1376] = data; _addr = addr;
			end else if (key_d == 21) begin
				D[1375:1344] = data; _addr = addr;
			end else if (key_d == 22) begin
				D[1343:1312] = data; _addr = addr;
			end else if (key_d == 23) begin
				D[1311:1280] = data; _addr = addr;
			end else if (key_d == 24) begin
				D[1279:1248] = data; _addr = addr;
			end else if (key_d == 25) begin
				D[1247:1216] = data; _addr = addr;
			end else if (key_d == 26) begin
				D[1215:1184] = data; _addr = addr;
			end else if (key_d == 27) begin
				D[1183:1152] = data; _addr = addr;
			end else if (key_d == 28) begin
				D[1151:1120] = data; _addr = addr;
			end else if (key_d == 29) begin
				D[1119:1088] = data; _addr = addr;
			end else if (key_d == 30) begin
				D[1087:1056] = data; _addr = addr;
			end else if (key_d == 31) begin
				D[1055:1024] = data; _addr = addr;
			end else if (key_d == 32) begin
				D[1023:992] = data; _addr = addr;
			end else if (key_d == 33) begin
				D[991:960] = data; _addr = addr;
			end else if (key_d == 34) begin
				D[959:928] = data; _addr = addr;
			end else if (key_d == 35) begin
				D[927:896] = data; _addr = addr;
			end else if (key_d == 36) begin
				D[895:864] = data; _addr = addr;
			end else if (key_d == 37) begin
				D[863:832] = data; _addr = addr;
			end else if (key_d == 38) begin
				D[831:800] = data; _addr = addr;
			end else if (key_d == 39) begin
				D[799:768] = data; _addr = addr;
			end else if (key_d == 40) begin
				D[767:736] = data; _addr = addr;
			end else if (key_d == 41) begin
				D[735:704] = data; _addr = addr;
			end else if (key_d == 42) begin
				D[703:672] = data; _addr = addr;
			end else if (key_d == 43) begin
				D[671:640] = data; _addr = addr;
			end else if (key_d == 44) begin
				D[639:608] = data; _addr = addr;
			end else if (key_d == 45) begin
				D[607:576] = data; _addr = addr;
			end else if (key_d == 46) begin
				D[575:544] = data; _addr = addr;
			end else if (key_d == 47) begin
				D[543:512] = data; _addr = addr;
			end else if (key_d == 48) begin
				D[511:480] = data; _addr = addr;
			end else if (key_d == 49) begin
				D[479:448] = data; _addr = addr;
			end else if (key_d == 50) begin
				D[447:416] = data; _addr = addr;
			end else if (key_d == 51) begin
				D[415:384] = data; _addr = addr;
			end else if (key_d == 52) begin
				D[383:352] = data; _addr = addr;
			end else if (key_d == 53) begin
				D[351:320] = data; _addr = addr;
			end else if (key_d == 54) begin
				D[319:288] = data; _addr = addr;
			end else if (key_d == 55) begin
				D[287:256] = data; _addr = addr;
			end else if (key_d == 56) begin
				D[255:224] = data; _addr = addr;
			end else if (key_d == 57) begin
				D[223:192] = data; _addr = addr;
			end else if (key_d == 58) begin
				D[191:160] = data; _addr = addr;
			end else if (key_d == 59) begin
				D[159:128] = data; _addr = addr;
			end else if (key_d == 60) begin
				D[127:96] = data; _addr = addr;
			end else if (key_d == 61) begin
				D[95:64] = data; _addr = addr;
			end else if (key_d == 62) begin
				D[63:32] = data; _addr = addr;
			end else  begin
				D[31:0] = data; _addr = addr;
				state_next = KEY_N;
			end

		end

		KEY_N: begin
			state_next = KEY_N;  // 64 cycles
			key_n_next = key_n + 1;

			if (key_n == 0) begin
				N[2047:2016] = data; _addr = addr;
			end else if (key_n == 1) begin
				N[2015:1984] = data; _addr = addr;
			end else if (key_n == 2) begin
				N[1983:1952] = data; _addr = addr;
			end else if (key_n == 3) begin
				N[1951:1920] = data; _addr = addr;
			end else if (key_n == 4) begin
				N[1919:1888] = data; _addr = addr;
			end else if (key_n == 5) begin
				N[1887:1856] = data; _addr = addr;
			end else if (key_n == 6) begin
				N[1855:1824] = data; _addr = addr;
			end else if (key_n == 7) begin
				N[1823:1792] = data; _addr = addr;
			end else if (key_n == 8) begin
				N[1791:1760] = data; _addr = addr;
			end else if (key_n == 9) begin
				N[1759:1728] = data; _addr = addr;
			end else if (key_n == 10) begin
				N[1727:1696] = data; _addr = addr;
			end else if (key_n == 11) begin
				N[1695:1664] = data; _addr = addr;
			end else if (key_n == 12) begin
				N[1663:1632] = data; _addr = addr;
			end else if (key_n == 13) begin
				N[1631:1600] = data; _addr = addr;
			end else if (key_n == 14) begin
				N[1599:1568] = data; _addr = addr;
			end else if (key_n == 15) begin
				N[1567:1536] = data; _addr = addr;
			end else if (key_n == 16) begin
				N[1535:1504] = data; _addr = addr;
			end else if (key_n == 17) begin
				N[1503:1472] = data; _addr = addr;
			end else if (key_n == 18) begin
				N[1471:1440] = data; _addr = addr;
			end else if (key_n == 19) begin
				N[1439:1408] = data; _addr = addr;
			end else if (key_n == 20) begin
				N[1407:1376] = data; _addr = addr;
			end else if (key_n == 21) begin
				N[1375:1344] = data; _addr = addr;
			end else if (key_n == 22) begin
				N[1343:1312] = data; _addr = addr;
			end else if (key_n == 23) begin
				N[1311:1280] = data; _addr = addr;
			end else if (key_n == 24) begin
				N[1279:1248] = data; _addr = addr;
			end else if (key_n == 25) begin
				N[1247:1216] = data; _addr = addr;
			end else if (key_n == 26) begin
				N[1215:1184] = data; _addr = addr;
			end else if (key_n == 27) begin
				N[1183:1152] = data; _addr = addr;
			end else if (key_n == 28) begin
				N[1151:1120] = data; _addr = addr;
			end else if (key_n == 29) begin
				N[1119:1088] = data; _addr = addr;
			end else if (key_n == 30) begin
				N[1087:1056] = data; _addr = addr;
			end else if (key_n == 31) begin
				N[1055:1024] = data; _addr = addr;
			end else if (key_n == 32) begin
				N[1023:992] = data; _addr = addr;
			end else if (key_n == 33) begin
				N[991:960] = data; _addr = addr;
			end else if (key_n == 34) begin
				N[959:928] = data; _addr = addr;
			end else if (key_n == 35) begin
				N[927:896] = data; _addr = addr;
			end else if (key_n == 36) begin
				N[895:864] = data; _addr = addr;
			end else if (key_n == 37) begin
				N[863:832] = data; _addr = addr;
			end else if (key_n == 38) begin
				N[831:800] = data; _addr = addr;
			end else if (key_n == 39) begin
				N[799:768] = data; _addr = addr;
			end else if (key_n == 40) begin
				N[767:736] = data; _addr = addr;
			end else if (key_n == 41) begin
				N[735:704] = data; _addr = addr;
			end else if (key_n == 42) begin
				N[703:672] = data; _addr = addr;
			end else if (key_n == 43) begin
				N[671:640] = data; _addr = addr;
			end else if (key_n == 44) begin
				N[639:608] = data; _addr = addr;
			end else if (key_n == 45) begin
				N[607:576] = data; _addr = addr;
			end else if (key_n == 46) begin
				N[575:544] = data; _addr = addr;
			end else if (key_n == 47) begin
				N[543:512] = data; _addr = addr;
			end else if (key_n == 48) begin
				N[511:480] = data; _addr = addr;
			end else if (key_n == 49) begin
				N[479:448] = data; _addr = addr;
			end else if (key_n == 50) begin
				N[447:416] = data; _addr = addr;
			end else if (key_n == 51) begin
				N[415:384] = data; _addr = addr;
			end else if (key_n == 52) begin
				N[383:352] = data; _addr = addr;
			end else if (key_n == 53) begin
				N[351:320] = data; _addr = addr;
			end else if (key_n == 54) begin
				N[319:288] = data; _addr = addr;
			end else if (key_n == 55) begin
				N[287:256] = data; _addr = addr;
			end else if (key_n == 56) begin
				N[255:224] = data; _addr = addr;
			end else if (key_n == 57) begin
				N[223:192] = data; _addr = addr;
			end else if (key_n == 58) begin
				N[191:160] = data; _addr = addr;
			end else if (key_n == 59) begin
				N[159:128] = data; _addr = addr;
			end else if (key_n == 60) begin
				N[127:96] = data; _addr = addr;
			end else if (key_n == 61) begin
				N[95:64] = data; _addr = addr;
			end else if (key_n == 62) begin
				N[63:32] = data; _addr = addr;	
			end else begin
				N[31:0] = data; _addr = addr;
				state_next = DATA_FEED;
			end
		end

		DATA_FEED: begin
			state_next = DATA_FEED;
			data_feed_next = data_feed + 1;
			
			status = 1;

			if (data_feed == 0) begin
				A[2047:2016] = data; AA[63] = data; CC[63] = data;	
			end else if (data_feed == 1) begin
				A[2015:1984] = data; AA[62] = data; CC[62] = data;
			end else if (data_feed == 2) begin
				A[1983:1952] = data; AA[61] = data; CC[61] = data;
			end else if (data_feed == 3) begin
				A[1951:1920] = data; AA[60] = data; CC[60] = data;
			end else if (data_feed == 4) begin
				A[1919:1888] = data; AA[59] = data; CC[59] = data;
			end else if (data_feed == 5) begin
				A[1887:1856] = data; AA[58] = data; CC[58] = data;
			end else if (data_feed == 6) begin
				A[1855:1824] = data; AA[57] = data; CC[57] = data;
			end else if (data_feed == 7) begin
				A[1823:1792] = data; AA[56] = data; CC[56] = data;
			end else if (data_feed == 8) begin
				A[1791:1760] = data; AA[55] = data; CC[55] = data;
			end else if (data_feed == 9) begin
				A[1759:1728] = data; AA[54] = data; CC[54] = data;
			end else if (data_feed == 10) begin
				A[1727:1696] = data; AA[53] = data; CC[53] = data;
			end else if (data_feed == 11) begin
				A[1695:1664] = data; AA[52] = data; CC[52] = data;
			end else if (data_feed == 12) begin
				A[1663:1632] = data; AA[51] = data; CC[51] = data;
			end else if (data_feed == 13) begin
				A[1631:1600] = data; AA[50] = data; CC[50] = data;
			end else if (data_feed == 14) begin
				A[1599:1568] = data; AA[49] = data; CC[49] = data;
			end else if (data_feed == 15) begin
				A[1567:1536] = data; AA[48] = data; CC[48] = data;
			end else if (data_feed == 16) begin
				A[1535:1504] = data; AA[47] = data; CC[47] = data;
			end else if (data_feed == 17) begin
				A[1503:1472] = data; AA[46] = data; CC[46] = data;
			end else if (data_feed == 18) begin
				A[1471:1440] = data; AA[45] = data; CC[45] = data;
			end else if (data_feed == 19) begin
				A[1439:1408] = data; AA[44] = data; CC[44] = data;
			end else if (data_feed == 20) begin
				A[1407:1376] = data; AA[43] = data; CC[43] = data;
			end else if (data_feed == 21) begin
				A[1375:1344] = data; AA[42] = data; CC[42] = data;
			end else if (data_feed == 22) begin
				A[1343:1312] = data; AA[41] = data; CC[41] = data;
			end else if (data_feed == 23) begin
				A[1311:1280] = data; AA[40] = data; CC[40] = data;
			end else if (data_feed == 24) begin
				A[1279:1248] = data; AA[39] = data; CC[39] = data;
			end else if (data_feed == 25) begin
				A[1247:1216] = data; AA[38] = data; CC[38] = data;
			end else if (data_feed == 26) begin
				A[1215:1184] = data; AA[37] = data; CC[37] = data;
			end else if (data_feed == 27) begin
				A[1183:1152] = data; AA[36] = data; CC[36] = data;
			end else if (data_feed == 28) begin
				A[1151:1120] = data; AA[35] = data; CC[35] = data;
			end else if (data_feed == 29) begin
				A[1119:1088] = data; AA[34] = data; CC[34] = data;
			end else if (data_feed == 30) begin
				A[1087:1056] = data; AA[33] = data; CC[33] = data;
			end else if (data_feed == 31) begin
				A[1055:1024] = data; AA[32] = data; CC[32] = data;
			end else if (data_feed == 32) begin
				A[1023:992] = data; AA[31] = data; CC[31] = data;
			end else if (data_feed == 33) begin
				A[991:960] = data; AA[30] = data; CC[30] = data;
			end else if (data_feed == 34) begin
				A[959:928] = data; AA[29] = data; CC[29] = data;
			end else if (data_feed == 35) begin
				A[927:896] = data; AA[28] = data; CC[28] = data;
			end else if (data_feed == 36) begin
				A[895:864] = data; AA[27] = data; CC[27] = data;
			end else if (data_feed == 37) begin
				A[863:832] = data; AA[26] = data; CC[26] = data;
			end else if (data_feed == 38) begin
				A[831:800] = data; AA[25] = data; CC[25] = data;
			end else if (data_feed == 39) begin
				A[799:768] = data; AA[24] = data; CC[24] = data;
			end else if (data_feed == 40) begin
				A[767:736] = data; AA[23] = data; CC[23] = data;
			end else if (data_feed == 41) begin
				A[735:704] = data; AA[22] = data; CC[22] = data;
			end else if (data_feed == 42) begin
				A[703:672] = data; AA[21] = data; CC[21] = data;
			end else if (data_feed == 43) begin
				A[671:640] = data; AA[20] = data; CC[20] = data;
			end else if (data_feed == 44) begin
				A[639:608] = data; AA[19] = data; CC[19] = data;
			end else if (data_feed == 45) begin
				A[607:576] = data; AA[18] = data; CC[18] = data;
			end else if (data_feed == 46) begin
				A[575:544] = data; AA[17] = data; CC[17] = data;
			end else if (data_feed == 47) begin
				A[543:512] = data; AA[16] = data; CC[16] = data;
			end else if (data_feed == 48) begin
				A[511:480] = data; AA[15] = data; CC[15] = data;
			end else if (data_feed == 49) begin
				A[479:448] = data; AA[14] = data; CC[14] = data;
			end else if (data_feed == 50) begin
				A[447:416] = data; AA[13] = data; CC[13] = data;
			end else if (data_feed == 51) begin
				A[415:384] = data; AA[12] = data; CC[12] = data;
			end else if (data_feed == 52) begin
				A[383:352] = data; AA[11] = data; CC[11] = data;
			end else if (data_feed == 53) begin
				A[351:320] = data; AA[10] = data; CC[10] = data;
			end else if (data_feed == 54) begin
				A[319:288] = data; AA[9] = data; CC[9] = data;
			end else if (data_feed == 55) begin
				A[287:256] = data; AA[8] = data; CC[8] = data;
			end else if (data_feed == 56) begin
				A[255:224] = data; AA[7] = data; CC[7] = data;
			end else if (data_feed == 57) begin
				A[223:192] = data; AA[6] = data; CC[6] = data;
			end else if (data_feed == 58) begin
				A[191:160] = data; AA[5] = data; CC[5] = data;
			end else if (data_feed == 59) begin
				A[159:128] = data; AA[4] = data; CC[4] = data;
			end else if (data_feed == 60) begin
				A[127:96] = data; AA[3] = data; CC[3] = data;
			end else if (data_feed == 61) begin
				A[95:64] = data; AA[2] = data; CC[2] = data;
			end else if (data_feed == 62) begin
				A[63:32] = data; AA[1] = data; CC[1] = data;
			end else begin
				A[31:0] = data; AA[0] = data; CC[0] = data;
				state_next = LR_1;
			end
		end


		LR_1: begin
			state_next = LR_1;	
			status = 2;
			_wen = 1;

			if (E[i] == 0) begin
				i_next = i-1;
			end else begin
				//$display("found");
				//$display("%d", i);
				i_next = i-1;
				C_next = 0;
				state_next = LR_2_MUL;
			end
		end

		LR_2_MUL: begin  // C*C%N	
			state_next = LR_2_MUL;
			
			C_next = (C + ( (CC[m]*CC[n]) << ((m+n)*32)) ) %N;
			//C_next = (C + tmp);
		//	$display("CC[m]=%3d CC[n]=%3d", CC[m], CC[n]);
		//	$display("C = %3d", C);
		//	$display("m=%d n=%d", m, n);
			
			if (m < 63) begin
				m_next = m+1;
			end else begin
				if (n < 63) begin
					n_next = n+1;
					m_next = 0;
				end else begin
					state_next = RELOAD;
					//C_next = C % N;
					m_next = 0;
					n_next = 0;
				end
			end
		end

		RELOAD: begin
			state_next = RELOAD;
			p_next = p+1;		

			if (p == 0) begin
				CC[0] = C[31:0];
			end else if (p == 1) begin
				CC[1] = C[63:32];
			end else if (p == 2) begin
				CC[2] = C[95:64];
			end else if (p == 3) begin
				CC[3] = C[127:96];
			end else if (p == 4) begin
				CC[4] = C[159:128];
			end else if (p == 5) begin
				CC[5] = C[191:160];
			end else if (p == 6) begin
				CC[6] = C[223:192];
			end else if (p == 7) begin
				CC[7] = C[255:224];
			end else if (p == 8) begin
				CC[8] = C[287:256];
			end else if (p == 9) begin
				CC[9] = C[319:288];
			end else if (p == 10) begin
				CC[10] = C[351:320];
			end else if (p == 11) begin
				CC[11] = C[383:352];
			end else if (p == 12) begin
				CC[12] = C[415:384];
			end else if (p == 13) begin
				CC[13] = C[447:416];
			end else if (p == 14) begin
				CC[14] = C[479:448];
			end else if (p == 15) begin
				CC[15] = C[511:480];
			end else if (p == 16) begin
				CC[16] = C[543:512];
			end else if (p == 17) begin
				CC[17] = C[575:544];
			end else if (p == 18) begin
				CC[18] = C[607:576];
			end else if (p == 19) begin
				CC[19] = C[639:608];
			end else if (p == 20) begin
				CC[20] = C[671:640];
			end else if (p == 21) begin
				CC[21] = C[703:672];
			end else if (p == 22) begin
				CC[22] = C[735:704];
			end else if (p == 23) begin
				CC[23] = C[767:736];
			end else if (p == 24) begin
				CC[24] = C[799:768];
			end else if (p == 25) begin
				CC[25] = C[831:800];
			end else if (p == 26) begin
				CC[26] = C[863:832];
			end else if (p == 27) begin
				CC[27] = C[895:864];
			end else if (p == 28) begin
				CC[28] = C[927:896];
			end else if (p == 29) begin
				CC[29] = C[959:928];
			end else if (p == 30) begin
				CC[30] = C[991:960];
			end else if (p == 31) begin
				CC[31] = C[1023:992];
			end else if (p == 32) begin
				CC[32] = C[1055:1024];
			end else if (p == 33) begin
				CC[33] = C[1087:1056];
			end else if (p == 34) begin
				CC[34] = C[1119:1088];
			end else if (p == 35) begin
				CC[35] = C[1151:1120];
			end else if (p == 36) begin
				CC[36] = C[1183:1152];
			end else if (p == 37) begin
				CC[37] = C[1215:1184];
			end else if (p == 38) begin
				CC[38] = C[1247:1216];
			end else if (p == 39) begin
				CC[39] = C[1279:1248];
			end else if (p == 40) begin
				CC[40] = C[1311:1280];
			end else if (p == 41) begin
				CC[41] = C[1343:1312];
			end else if (p == 42) begin
				CC[42] = C[1375:1344];
			end else if (p == 43) begin
				CC[43] = C[1407:1376];
			end else if (p == 44) begin
				CC[44] = C[1439:1408];
			end else if (p == 45) begin
				CC[45] = C[1471:1440];
			end else if (p == 46) begin
				CC[46] = C[1503:1472];
			end else if (p == 47) begin
				CC[47] = C[1535:1504];
			end else if (p == 48) begin
				CC[48] = C[1567:1536];
			end else if (p == 49) begin
				CC[49] = C[1599:1568];
			end else if (p == 50) begin
				CC[50] = C[1631:1600];
			end else if (p == 51) begin
				CC[51] = C[1663:1632];
			end else if (p == 52) begin
				CC[52] = C[1695:1664];
			end else if (p == 53) begin
				CC[53] = C[1727:1696];
			end else if (p == 54) begin
				CC[54] = C[1759:1728];
			end else if (p == 55) begin
				CC[55] = C[1791:1760];
			end else if (p == 56) begin
				CC[56] = C[1823:1792];
			end else if (p == 57) begin
				CC[57] = C[1855:1824];
			end else if (p == 58) begin
				CC[58] = C[1887:1856];
			end else if (p == 59) begin
				CC[59] = C[1919:1888];
			end else if (p == 60) begin
				CC[60] = C[1951:1920];
			end else if (p == 61) begin
				CC[61] = C[1983:1952];
			end else if (p == 62) begin
				CC[62] = C[2015:1984];
			end else begin
				CC[63] = C[2047:2016];
				state_next = LR_3;
				p_next = 0;
			end

		end

		LR_3: begin

			if (E[i] == 1) begin
			//	C_next = (C*A) % N;
				state_next = LR_3_MUL;
				C_next = 0;
			//$display("CC= %4d, AA= %4d", C, A);
			end else begin
				C_next = C;
				state_next = LR_4;
			end

		/*	if (i != 0) begin
				i_next = i-1;
				state_next = RELOAD_2;
				m_next = 0;
				n_next = 0;

			end else begin
				state_next = OUTPUT;
				//$display("wen = %d", wen);
			end*/
		end

		LR_3_MUL: begin
			state_next = LR_3_MUL;

			C_next = (C + ( (CC[m]*AA[n]) << ((m+n)*32)) )%N;
		//	C_next = (C + tmp);
		//	$display("CC[m]=%3d CC[n]=%3d", CC[m], CC[n]);
		//	$display("C = %3d", C);
		//	$display("m=%d n=%d", m, n);
			
			if (m < 63) begin
				m_next = m+1;
			end else begin
				if (n < 63) begin
					n_next = n+1;
					m_next = 0;
				end else begin
					state_next = RELOAD_2;
					//C_next = C % N;
					m_next = 0;
					n_next = 0;
				end
			end
		end

		LR_4: begin
			if (i != 0) begin
				i_next = i-1;
				state_next = LR_2_MUL;
				C_next = 0;
				m_next = 0;
				n_next = 0;

			end else begin
				state_next = OUTPUT;
				//$display("wen = %d", wen);
			end
		end

		RELOAD_2: begin
			state_next = RELOAD_2;
			p_next = p+1;		

			if (p == 0) begin
				CC[0] = C[31:0];
			end else if (p == 1) begin
				CC[1] = C[63:32];
			end else if (p == 2) begin
				CC[2] = C[95:64];
			end else if (p == 3) begin
				CC[3] = C[127:96];
			end else if (p == 4) begin
				CC[4] = C[159:128];
			end else if (p == 5) begin
				CC[5] = C[191:160];
			end else if (p == 6) begin
				CC[6] = C[223:192];
			end else if (p == 7) begin
				CC[7] = C[255:224];
			end else if (p == 8) begin
				CC[8] = C[287:256];
			end else if (p == 9) begin
				CC[9] = C[319:288];
			end else if (p == 10) begin
				CC[10] = C[351:320];
			end else if (p == 11) begin
				CC[11] = C[383:352];
			end else if (p == 12) begin
				CC[12] = C[415:384];
			end else if (p == 13) begin
				CC[13] = C[447:416];
			end else if (p == 14) begin
				CC[14] = C[479:448];
			end else if (p == 15) begin
				CC[15] = C[511:480];
			end else if (p == 16) begin
				CC[16] = C[543:512];
			end else if (p == 17) begin
				CC[17] = C[575:544];
			end else if (p == 18) begin
				CC[18] = C[607:576];
			end else if (p == 19) begin
				CC[19] = C[639:608];
			end else if (p == 20) begin
				CC[20] = C[671:640];
			end else if (p == 21) begin
				CC[21] = C[703:672];
			end else if (p == 22) begin
				CC[22] = C[735:704];
			end else if (p == 23) begin
				CC[23] = C[767:736];
			end else if (p == 24) begin
				CC[24] = C[799:768];
			end else if (p == 25) begin
				CC[25] = C[831:800];
			end else if (p == 26) begin
				CC[26] = C[863:832];
			end else if (p == 27) begin
				CC[27] = C[895:864];
			end else if (p == 28) begin
				CC[28] = C[927:896];
			end else if (p == 29) begin
				CC[29] = C[959:928];
			end else if (p == 30) begin
				CC[30] = C[991:960];
			end else if (p == 31) begin
				CC[31] = C[1023:992];
			end else if (p == 32) begin
				CC[32] = C[1055:1024];
			end else if (p == 33) begin
				CC[33] = C[1087:1056];
			end else if (p == 34) begin
				CC[34] = C[1119:1088];
			end else if (p == 35) begin
				CC[35] = C[1151:1120];
			end else if (p == 36) begin
				CC[36] = C[1183:1152];
			end else if (p == 37) begin
				CC[37] = C[1215:1184];
			end else if (p == 38) begin
				CC[38] = C[1247:1216];
			end else if (p == 39) begin
				CC[39] = C[1279:1248];
			end else if (p == 40) begin
				CC[40] = C[1311:1280];
			end else if (p == 41) begin
				CC[41] = C[1343:1312];
			end else if (p == 42) begin
				CC[42] = C[1375:1344];
			end else if (p == 43) begin
				CC[43] = C[1407:1376];
			end else if (p == 44) begin
				CC[44] = C[1439:1408];
			end else if (p == 45) begin
				CC[45] = C[1471:1440];
			end else if (p == 46) begin
				CC[46] = C[1503:1472];
			end else if (p == 47) begin
				CC[47] = C[1535:1504];
			end else if (p == 48) begin
				CC[48] = C[1567:1536];
			end else if (p == 49) begin
				CC[49] = C[1599:1568];
			end else if (p == 50) begin
				CC[50] = C[1631:1600];
			end else if (p == 51) begin
				CC[51] = C[1663:1632];
			end else if (p == 52) begin
				CC[52] = C[1695:1664];
			end else if (p == 53) begin
				CC[53] = C[1727:1696];
			end else if (p == 54) begin
				CC[54] = C[1759:1728];
			end else if (p == 55) begin
				CC[55] = C[1791:1760];
			end else if (p == 56) begin
				CC[56] = C[1823:1792];
			end else if (p == 57) begin
				CC[57] = C[1855:1824];
			end else if (p == 58) begin
				CC[58] = C[1887:1856];
			end else if (p == 59) begin
				CC[59] = C[1919:1888];
			end else if (p == 60) begin
				CC[60] = C[1951:1920];
			end else if (p == 61) begin
				CC[61] = C[1983:1952];
			end else if (p == 62) begin
				CC[62] = C[2015:1984];
			end else begin
				CC[63] = C[2047:2016];
				state_next = LR_4;
				p_next = 0;
				// should not set C = 0, wait for OUTPUT
			end

		end
		
		OUTPUT: begin
			state_next = OUTPUT;
			oe_n = 1;
			op_next = op + 1;
			
			if (op == 0) begin
				result = C[2047:2016]; 
			end else if (op == 1) begin
				result = C[2015:1984];
			end else if (op == 2) begin
				result = C[1983:1952];
			end else if (op == 3) begin
				result = C[1951:1920];
			end else if (op == 4) begin
				result = C[1919:1888];
			end else if (op == 5) begin
				result = C[1887:1856];
			end else if (op == 6) begin
				result = C[1855:1824];
			end else if (op == 7) begin
				result = C[1823:1792];
			end else if (op == 8) begin
				result = C[1791:1760];
			end else if (op == 9) begin
				result = C[1759:1728];
			end else if (op == 10) begin
				result = C[1727:1696];
			end else if (op == 11) begin
				result = C[1695:1664];
			end else if (op == 12) begin
				result = C[1663:1632];
			end else if (op == 13) begin
				result = C[1631:1600];
			end else if (op == 14) begin
				result = C[1599:1568];
			end else if (op == 15) begin
				result = C[1567:1536];
			end else if (op == 16) begin
				result = C[1535:1504];
			end else if (op == 17) begin
				result = C[1503:1472];
			end else if (op == 18) begin
				result = C[1471:1440];
			end else if (op == 19) begin
				result = C[1439:1408];
			end else if (op == 20) begin
				result = C[1407:1376];
			end else if (op == 21) begin
				result = C[1375:1344];
			end else if (op == 22) begin
				result = C[1343:1312];
			end else if (op == 23) begin
				result = C[1311:1280];
			end else if (op == 24) begin
				result = C[1279:1248];
			end else if (op == 25) begin
				result = C[1247:1216];
			end else if (op == 26) begin
				result = C[1215:1184];
			end else if (op == 27) begin
				result = C[1183:1152];
			end else if (op == 28) begin
				result = C[1151:1120];
			end else if (op == 29) begin
				result = C[1119:1088];
			end else if (op == 30) begin
				result = C[1087:1056];
			end else if (op == 31) begin
				result = C[1055:1024];
			end else if (op == 32) begin
				result = C[1023:992];
			end else if (op == 33) begin
				result = C[991:960];
			end else if (op == 34) begin
				result = C[959:928];
			end else if (op == 35) begin
				result = C[927:896];
			end else if (op == 36) begin
				result = C[895:864];
			end else if (op == 37) begin
				result = C[863:832];
			end else if (op == 38) begin
				result = C[831:800];
			end else if (op == 39) begin
				result = C[799:768];
			end else if (op == 40) begin
				result = C[767:736];
			end else if (op == 41) begin
				result = C[735:704];
			end else if (op == 42) begin
				result = C[703:672];
			end else if (op == 43) begin
				result = C[671:640];
			end else if (op == 44) begin
				result = C[639:608];
			end else if (op == 45) begin
				result = C[607:576];
			end else if (op == 46) begin
				result = C[575:544];
			end else if (op == 47) begin
				result = C[543:512];
			end else if (op == 48) begin
				result = C[511:480];
			end else if (op == 49) begin
				result = C[479:448];
			end else if (op == 50) begin
				result = C[447:416];
			end else if (op == 51) begin
				result = C[415:384];
			end else if (op == 52) begin
				result = C[383:352];
			end else if (op == 53) begin
				result = C[351:320];
			end else if (op == 54) begin
				result = C[319:288];
			end else if (op == 55) begin
				result = C[287:256];
			end else if (op == 56) begin
				result = C[255:224];
			end else if (op == 57) begin
				result = C[223:192];
			end else if (op == 58) begin
				result = C[191:160];
			end else if (op == 59) begin
				result = C[159:128];
			end else if (op == 60) begin
				result = C[127:96];
			end else if (op == 61) begin
				result = C[95:64];
			end else if (op == 62) begin
				result = C[63:32];
			end else begin
				result = C[31:0];
				state_next = OUTPUT_PRINT;
			end

		end
				
		OUTPUT_PRINT: begin
			$display("A = %2d", A);
			$display("cihper = %3d", C);
			
			status = 3;		
			oe_n = 1;

			m_next = 0;
			n_next = 0;
			op_next = 0;

			if (wen == 0) begin
				state_next = DATA_FEED;
				data_feed_next = 0;
				i_next = 2047;
				//C_next = 0;
			end else begin
				state_next = DONE;
			end
		end


		DONE: begin
			done = 1;
			$display("IN DONE");
			//$display("E = %4b", E);
			//$display("D = %2d", D);
			//$display("N = %2d", N);
			//$display("A = %2d", A);
			
			state_next = DONE;
			$display("*********");
			//$display("EE = %d", EE[62]);
		end

		default: begin
			state_next = IDLE;
		end
	endcase
end
endmodule












