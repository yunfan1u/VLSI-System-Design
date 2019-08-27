

`timescale 1ns/100ps

module load_bmp(
	clk,
	rst_n,
	exe,
	mode,
	addr,
	wen,
	data,
	status,
	done
);

	parameter period = 10;
	parameter cyc = 10;
	parameter delay = 1;
	output reg clk;
	output reg rst_n;
	output reg exe;

	output reg mode;
	output reg [7:0] addr;
	output reg wen;
	output reg [31:0] data;

	input [1:0] status;
	input done;
	
	integer i;

	initial begin
		`ifdef SYNTHESIS
			$sdf_annotate("rsa.sdf", rsa);
			$fsdbDumpfile("rsa_syn.fsdb");
		`else
			$fsdbDumpfile("rsa.fsdb");
		`endif
		$fsdbDumpvars;
	end
	
	
	always #(period/2) clk = ~clk;
	
	initial begin
		clk = 0;
		rst_n = 0;
		exe = 0;
		#(period) rst_n = 0;
		#(period) rst_n = 1;
		#(period) wen = 1;
		#(period) exe = 1; wen = 0;	mode =0;

		// E=7
		#(cyc) data = 32'd0; addr = 8'd0;
		#(cyc) data = 32'd0; addr = 8'd1;
		#(cyc) data = 32'd0; addr = 8'd2;
		#(cyc) data = 32'd0; addr = 8'd3;
		#(cyc) data = 32'd0; addr = 8'd4;
		#(cyc) data = 32'd0; addr = 8'd5;
		#(cyc) data = 32'd0; addr = 8'd6;
		#(cyc) data = 32'd0; addr = 8'd7;
		#(cyc) data = 32'd0; addr = 8'd8;
		#(cyc) data = 32'd0; addr = 8'd9;
		#(cyc) data = 32'd0; addr = 8'd10;
		#(cyc) data = 32'd0; addr = 8'd11;
		#(cyc) data = 32'd0; addr = 8'd12;
		#(cyc) data = 32'd0; addr = 8'd13;
		#(cyc) data = 32'd0; addr = 8'd14;
		#(cyc) data = 32'd0; addr = 8'd15;
		#(cyc) data = 32'd0; addr = 8'd16;
		#(cyc) data = 32'd0; addr = 8'd17;
		#(cyc) data = 32'd0; addr = 8'd18;
		#(cyc) data = 32'd0; addr = 8'd19;
		#(cyc) data = 32'd0; addr = 8'd20;
		#(cyc) data = 32'd0; addr = 8'd21;
		#(cyc) data = 32'd0; addr = 8'd22;
		#(cyc) data = 32'd0; addr = 8'd23;
		#(cyc) data = 32'd0; addr = 8'd24;
		#(cyc) data = 32'd0; addr = 8'd25;
		#(cyc) data = 32'd0; addr = 8'd26;
		#(cyc) data = 32'd0; addr = 8'd27;
		#(cyc) data = 32'd0; addr = 8'd28;
		#(cyc) data = 32'd0; addr = 8'd29;
		#(cyc) data = 32'd0; addr = 8'd30;
		#(cyc) data = 32'd0; addr = 8'd31;
		#(cyc) data = 32'd0; addr = 8'd32;
		#(cyc) data = 32'd0; addr = 8'd33;
		#(cyc) data = 32'd0; addr = 8'd34;
		#(cyc) data = 32'd0; addr = 8'd35;
		#(cyc) data = 32'd0; addr = 8'd36;
		#(cyc) data = 32'd0; addr = 8'd37;
		#(cyc) data = 32'd0; addr = 8'd38;
		#(cyc) data = 32'd0; addr = 8'd39;
		#(cyc) data = 32'd0; addr = 8'd40;
		#(cyc) data = 32'd0; addr = 8'd41;
		#(cyc) data = 32'd0; addr = 8'd42;
		#(cyc) data = 32'd0; addr = 8'd43;
		#(cyc) data = 32'd0; addr = 8'd44;
		#(cyc) data = 32'd0; addr = 8'd45;
		#(cyc) data = 32'd0; addr = 8'd46;
		#(cyc) data = 32'd0; addr = 8'd47;
		#(cyc) data = 32'd0; addr = 8'd48;
		#(cyc) data = 32'd0; addr = 8'd49;
		#(cyc) data = 32'd0; addr = 8'd50;
		#(cyc) data = 32'd0; addr = 8'd51;
		#(cyc) data = 32'd0; addr = 8'd52;
		#(cyc) data = 32'd0; addr = 8'd53;
		#(cyc) data = 32'd0; addr = 8'd54;
		#(cyc) data = 32'd0; addr = 8'd55;
		#(cyc) data = 32'd0; addr = 8'd56;
		#(cyc) data = 32'd0; addr = 8'd57;
		#(cyc) data = 32'd0; addr = 8'd58;
		#(cyc) data = 32'd0; addr = 8'd59;
		#(cyc) data = 32'd0; addr = 8'd60;
		#(cyc) data = 32'd0; addr = 8'd61;
		#(cyc) data = 32'd0; addr = 8'd62;
		#(cyc) data = 32'd7; addr = 8'd63;
		//#(cyc) data = 32'd200465399; addr = 8'd63;

		// D=103
		#(cyc) data = 32'd0; addr = 8'd64;
		#(cyc) data = 32'd0; addr = 8'd65;
		#(cyc) data = 32'd0; addr = 8'd66;
		#(cyc) data = 32'd0; addr = 8'd67;
		#(cyc) data = 32'd0; addr = 8'd68;
		#(cyc) data = 32'd0; addr = 8'd69;
		#(cyc) data = 32'd0; addr = 8'd70;
		#(cyc) data = 32'd0; addr = 8'd71;
		#(cyc) data = 32'd0; addr = 8'd72;
		#(cyc) data = 32'd0; addr = 8'd73;
		#(cyc) data = 32'd0; addr = 8'd74;
		#(cyc) data = 32'd0; addr = 8'd75;
		#(cyc) data = 32'd0; addr = 8'd76;
		#(cyc) data = 32'd0; addr = 8'd77;
		#(cyc) data = 32'd0; addr = 8'd78;
		#(cyc) data = 32'd0; addr = 8'd79;
		#(cyc) data = 32'd0; addr = 8'd80;
		#(cyc) data = 32'd0; addr = 8'd81;
		#(cyc) data = 32'd0; addr = 8'd82;
		#(cyc) data = 32'd0; addr = 8'd83;
		#(cyc) data = 32'd0; addr = 8'd84;
		#(cyc) data = 32'd0; addr = 8'd85;
		#(cyc) data = 32'd0; addr = 8'd86;
		#(cyc) data = 32'd0; addr = 8'd87;
		#(cyc) data = 32'd0; addr = 8'd88;
		#(cyc) data = 32'd0; addr = 8'd89;
		#(cyc) data = 32'd0; addr = 8'd90;
		#(cyc) data = 32'd0; addr = 8'd91;
		#(cyc) data = 32'd0; addr = 8'd92;
		#(cyc) data = 32'd0; addr = 8'd93;
		#(cyc) data = 32'd0; addr = 8'd94;
		#(cyc) data = 32'd0; addr = 8'd95;
		#(cyc) data = 32'd0; addr = 8'd96;
		#(cyc) data = 32'd0; addr = 8'd97;
		#(cyc) data = 32'd0; addr = 8'd98;
		#(cyc) data = 32'd0; addr = 8'd99;
		#(cyc) data = 32'd0; addr = 8'd100;
		#(cyc) data = 32'd0; addr = 8'd101;
		#(cyc) data = 32'd0; addr = 8'd102;
		#(cyc) data = 32'd0; addr = 8'd103;
		#(cyc) data = 32'd0; addr = 8'd104;
		#(cyc) data = 32'd0; addr = 8'd105;
		#(cyc) data = 32'd0; addr = 8'd106;
		#(cyc) data = 32'd0; addr = 8'd107;
		#(cyc) data = 32'd0; addr = 8'd108;
		#(cyc) data = 32'd0; addr = 8'd109;
		#(cyc) data = 32'd0; addr = 8'd110;
		#(cyc) data = 32'd0; addr = 8'd111;
		#(cyc) data = 32'd0; addr = 8'd112;
		#(cyc) data = 32'd0; addr = 8'd113;
		#(cyc) data = 32'd0; addr = 8'd114;
		#(cyc) data = 32'd0; addr = 8'd115;
		#(cyc) data = 32'd0; addr = 8'd116;
		#(cyc) data = 32'd0; addr = 8'd117;
		#(cyc) data = 32'd0; addr = 8'd118;
		#(cyc) data = 32'd0; addr = 8'd119;
		#(cyc) data = 32'd0; addr = 8'd120;
		#(cyc) data = 32'd0; addr = 8'd121;
		#(cyc) data = 32'd0; addr = 8'd122;
		#(cyc) data = 32'd0; addr = 8'd123;
		#(cyc) data = 32'd0; addr = 8'd124;
		#(cyc) data = 32'd0; addr = 8'd125;
		#(cyc) data = 32'd0; addr = 8'd126;
		#(cyc) data = 32'd103; addr = 8'd127;

		// N=143
		#(cyc) data = 32'd0; addr = 8'd128;
		#(cyc) data = 32'd0; addr = 8'd129;
		#(cyc) data = 32'd0; addr = 8'd130;
		#(cyc) data = 32'd0; addr = 8'd131;
		#(cyc) data = 32'd0; addr = 8'd132;
		#(cyc) data = 32'd0; addr = 8'd133;
		#(cyc) data = 32'd0; addr = 8'd134;
		#(cyc) data = 32'd0; addr = 8'd135;
		#(cyc) data = 32'd0; addr = 8'd136;
		#(cyc) data = 32'd0; addr = 8'd137;
		#(cyc) data = 32'd0; addr = 8'd138;
		#(cyc) data = 32'd0; addr = 8'd139;
		#(cyc) data = 32'd0; addr = 8'd140;
		#(cyc) data = 32'd0; addr = 8'd141;
		#(cyc) data = 32'd0; addr = 8'd142;
		#(cyc) data = 32'd0; addr = 8'd143;
		#(cyc) data = 32'd0; addr = 8'd144;
		#(cyc) data = 32'd0; addr = 8'd145;
		#(cyc) data = 32'd0; addr = 8'd146;
		#(cyc) data = 32'd0; addr = 8'd147;
		#(cyc) data = 32'd0; addr = 8'd148;
		#(cyc) data = 32'd0; addr = 8'd149;
		#(cyc) data = 32'd0; addr = 8'd150;
		#(cyc) data = 32'd0; addr = 8'd151;
		#(cyc) data = 32'd0; addr = 8'd152;
		#(cyc) data = 32'd0; addr = 8'd153;
		#(cyc) data = 32'd0; addr = 8'd154;
		#(cyc) data = 32'd0; addr = 8'd155;
		#(cyc) data = 32'd0; addr = 8'd156;
		#(cyc) data = 32'd0; addr = 8'd157;
		#(cyc) data = 32'd0; addr = 8'd158;
		#(cyc) data = 32'd0; addr = 8'd159;
		#(cyc) data = 32'd0; addr = 8'd160;
		#(cyc) data = 32'd0; addr = 8'd161;
		#(cyc) data = 32'd0; addr = 8'd162;
		#(cyc) data = 32'd0; addr = 8'd163;
		#(cyc) data = 32'd0; addr = 8'd164;
		#(cyc) data = 32'd0; addr = 8'd165;
		#(cyc) data = 32'd0; addr = 8'd166;
		#(cyc) data = 32'd0; addr = 8'd167;
		#(cyc) data = 32'd0; addr = 8'd168;
		#(cyc) data = 32'd0; addr = 8'd169;
		#(cyc) data = 32'd0; addr = 8'd170;
		#(cyc) data = 32'd0; addr = 8'd171;
		#(cyc) data = 32'd0; addr = 8'd172;
		#(cyc) data = 32'd0; addr = 8'd173;
		#(cyc) data = 32'd0; addr = 8'd174;
		#(cyc) data = 32'd0; addr = 8'd175;
		#(cyc) data = 32'd0; addr = 8'd176;
		#(cyc) data = 32'd0; addr = 8'd177;
		#(cyc) data = 32'd0; addr = 8'd178;
		#(cyc) data = 32'd0; addr = 8'd179;
		#(cyc) data = 32'd0; addr = 8'd180;
		#(cyc) data = 32'd0; addr = 8'd181;
		#(cyc) data = 32'd0; addr = 8'd182;
		#(cyc) data = 32'd0; addr = 8'd183;
		#(cyc) data = 32'd0; addr = 8'd184;
		#(cyc) data = 32'd0; addr = 8'd185;
		#(cyc) data = 32'd0; addr = 8'd186;
		#(cyc) data = 32'd0; addr = 8'd187;
		#(cyc) data = 32'd0; addr = 8'd188;
		#(cyc) data = 32'd0; addr = 8'd189;
		#(cyc) data = 32'd0; addr = 8'd190;
		#(cyc) data = 32'd143; addr = 8'd191;
		//#(cyc) data = 430872577; addr = 8'd190;

		// A=3 
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd3;
		@(status == 3); #(cyc);

		// A=8
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd8;
		@(status == 3); #(cyc);

		// A=23
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd23;
		@(status == 3); #(cyc);

		// A=1
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd1;
		@(status == 3); #(cyc);

		// A=14
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd14;
		@(status == 3); #(cyc);

		// A=7
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd7;
		@(status == 3);

		wen = 1; 

		// A=3 -> 42 
/*		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd42;
		@(status == 3); #(cyc);

		// A=8 -> 57
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd57;
		@(status == 3); #(cyc);

		// A=23 -> 23
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd23;
		@(status == 3); #(cyc);

		// A=1 -> 1
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd1;
		@(status == 3); #(cyc);

		// A=14 -> 53
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd53;
		@(status == 3); #(cyc);

		// A=7 -> 6
		for(i=0; i<63; i=i+1)
			#(cyc) data = 32'd0;
		#(cyc) data = 32'd6;
		@(status == 3);

		wen = 1;
*/


		@(posedge done)
//		$display("finished!!!");

		#(period*300);
		$finish;

	end
endmodule	
