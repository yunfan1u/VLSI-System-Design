/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Mar 22 13:50:47 2019
/////////////////////////////////////////////////////////////


module GCD_1_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [16:0] carry;

  XOR3X1 U2_15 ( .A(A[15]), .B(n14), .C(carry[15]), .Y(DIFF[15]) );
  ADDFXL U2_14 ( .A(A[14]), .B(n15), .CI(carry[14]), .CO(carry[15]), .S(
        DIFF[14]) );
  ADDFXL U2_13 ( .A(A[13]), .B(n16), .CI(carry[13]), .CO(carry[14]), .S(
        DIFF[13]) );
  ADDFXL U2_12 ( .A(A[12]), .B(n17), .CI(carry[12]), .CO(carry[13]), .S(
        DIFF[12]) );
  ADDFXL U2_11 ( .A(A[11]), .B(n13), .CI(carry[11]), .CO(carry[12]), .S(
        DIFF[11]) );
  ADDFXL U2_10 ( .A(A[10]), .B(n12), .CI(carry[10]), .CO(carry[11]), .S(
        DIFF[10]) );
  ADDFXL U2_9 ( .A(A[9]), .B(n6), .CI(carry[9]), .CO(carry[10]), .S(DIFF[9])
         );
  ADDFXL U2_8 ( .A(A[8]), .B(n5), .CI(carry[8]), .CO(carry[9]), .S(DIFF[8]) );
  ADDFXL U2_7 ( .A(A[7]), .B(n4), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7]) );
  ADDFXL U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6]) );
  ADDFXL U2_5 ( .A(A[5]), .B(n10), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFXL U2_4 ( .A(A[4]), .B(n9), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4]) );
  ADDFXL U2_3 ( .A(A[3]), .B(n8), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3]) );
  ADDFXL U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2]) );
  ADDFXL U2_1 ( .A(A[1]), .B(n11), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  CLKINVX1 U1 ( .A(B[0]), .Y(n2) );
  CLKINVX1 U2 ( .A(A[0]), .Y(n1) );
  NAND2X1 U3 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  CLKINVX1 U4 ( .A(B[1]), .Y(n11) );
  CLKINVX1 U5 ( .A(B[2]), .Y(n7) );
  CLKINVX1 U6 ( .A(B[3]), .Y(n8) );
  CLKINVX1 U7 ( .A(B[4]), .Y(n9) );
  CLKINVX1 U8 ( .A(B[5]), .Y(n10) );
  CLKINVX1 U9 ( .A(B[6]), .Y(n3) );
  CLKINVX1 U10 ( .A(B[7]), .Y(n4) );
  CLKINVX1 U11 ( .A(B[8]), .Y(n5) );
  CLKINVX1 U12 ( .A(B[9]), .Y(n6) );
  CLKINVX1 U13 ( .A(B[10]), .Y(n12) );
  CLKINVX1 U14 ( .A(B[11]), .Y(n13) );
  CLKINVX1 U15 ( .A(B[12]), .Y(n17) );
  CLKINVX1 U16 ( .A(B[13]), .Y(n16) );
  CLKINVX1 U17 ( .A(B[14]), .Y(n15) );
  XNOR2X1 U18 ( .A(n2), .B(A[0]), .Y(DIFF[0]) );
  CLKINVX1 U19 ( .A(B[15]), .Y(n14) );
endmodule


module GCD_1 ( CLK, RST_N, A, B, START, Y, DONE, ERROR );
  input [7:0] A;
  input [7:0] B;
  output [7:0] Y;
  input CLK, RST_N, START;
  output DONE, ERROR;
  wire   error_next, input_1, input_1_next, input_2, input_2_next, output_1,
         output_1_next, output_2, output_2_next, N63, N64, N65, N66, N68, N69,
         N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81, N82, N83,
         N84, N85, N86, N87, N88, N89, N90, N91, N92, N93, N94, N95, N96, N97,
         N98, N99, N100, N101, N102, N103, N104, N105, N106, N107, N108, N109,
         N110, N111, N112, N113, N114, N115, N116, N117, N118, N119, n76, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216;
  wire   [15:0] reg_a;
  wire   [15:0] reg_b;
  wire   [15:0] data_a;
  wire   [15:0] data_b;
  wire   [15:0] diff;
  wire   [2:0] state;
  wire   [2:0] state_next;

  TLATX4 \reg_b_reg[0]  ( .G(N86), .D(N104), .Q(reg_b[0]) );
  TLATX4 \reg_a_reg[12]  ( .G(N95), .D(N100), .Q(reg_a[12]) );
  TLATX4 \reg_a_reg[13]  ( .G(N95), .D(N101), .Q(reg_a[13]) );
  TLATX4 \reg_a_reg[0]  ( .G(N86), .D(N87), .Q(reg_a[0]) );
  TLATX4 \reg_a_reg[1]  ( .G(N86), .D(N88), .Q(reg_a[1]) );
  TLATX4 \reg_b_reg[1]  ( .G(N86), .D(N105), .Q(reg_b[1]) );
  TLATX4 \reg_b_reg[2]  ( .G(N86), .D(N106), .Q(reg_b[2]) );
  TLATX4 \reg_a_reg[2]  ( .G(N86), .D(N89), .Q(reg_a[2]) );
  TLATX4 \reg_b_reg[3]  ( .G(N86), .D(N107), .Q(reg_b[3]) );
  TLATX4 \reg_a_reg[3]  ( .G(N86), .D(N90), .Q(reg_a[3]) );
  TLATX4 \reg_b_reg[4]  ( .G(N86), .D(N108), .Q(reg_b[4]) );
  TLATX4 \reg_a_reg[4]  ( .G(N86), .D(N91), .Q(reg_a[4]) );
  TLATX4 \reg_b_reg[5]  ( .G(N86), .D(N109), .Q(reg_b[5]) );
  TLATX4 \reg_a_reg[5]  ( .G(N86), .D(N92), .Q(reg_a[5]) );
  TLATX4 \reg_b_reg[6]  ( .G(N86), .D(N110), .Q(reg_b[6]) );
  TLATX4 \reg_a_reg[6]  ( .G(N86), .D(N93), .Q(reg_a[6]) );
  TLATX4 \reg_b_reg[7]  ( .G(N86), .D(N111), .Q(reg_b[7]) );
  TLATX4 \reg_a_reg[7]  ( .G(N86), .D(N94), .Q(reg_a[7]) );
  TLATX4 \reg_b_reg[8]  ( .G(N95), .D(N112), .Q(reg_b[8]) );
  TLATX4 \reg_a_reg[8]  ( .G(N95), .D(N96), .Q(reg_a[8]) );
  TLATX4 \reg_b_reg[9]  ( .G(N95), .D(N113), .Q(reg_b[9]) );
  TLATX4 \reg_a_reg[9]  ( .G(N95), .D(N97), .Q(reg_a[9]) );
  TLATX4 \reg_b_reg[10]  ( .G(N95), .D(N114), .Q(reg_b[10]) );
  TLATX4 \reg_a_reg[10]  ( .G(N95), .D(N98), .Q(reg_a[10]) );
  TLATX4 \reg_b_reg[11]  ( .G(N95), .D(N115), .Q(reg_b[11]) );
  TLATX4 \reg_a_reg[11]  ( .G(N95), .D(N99), .Q(reg_a[11]) );
  TLATX4 \reg_b_reg[12]  ( .G(N95), .D(N116), .Q(reg_b[12]) );
  TLATX4 \reg_b_reg[13]  ( .G(N95), .D(N117), .Q(reg_b[13]) );
  TLATX4 \reg_b_reg[14]  ( .G(N95), .D(N118), .Q(reg_b[14]) );
  TLATX4 \reg_a_reg[14]  ( .G(N95), .D(N102), .Q(reg_a[14]) );
  TLATX4 \reg_b_reg[15]  ( .G(N95), .D(N119), .Q(reg_b[15]) );
  TLATX4 \reg_a_reg[15]  ( .G(N95), .D(N103), .Q(reg_a[15]) );
  GCD_1_DW01_sub_0 sub_46 ( .A({n215, data_a[14:0]}), .B(data_b), .CI(1'b0), 
        .DIFF(diff) );
  EDFFX1 output_2_reg ( .D(output_2_next), .E(RST_N), .CK(CLK), .Q(output_2)
         );
  DFFRX1 ERROR_reg ( .D(error_next), .CK(CLK), .RN(RST_N), .Q(ERROR) );
  EDFFX1 output_1_reg ( .D(output_1_next), .E(RST_N), .CK(CLK), .Q(output_1)
         );
  EDFFX1 input_1_reg ( .D(input_1_next), .E(RST_N), .CK(CLK), .Q(input_1) );
  EDFFX1 input_2_reg ( .D(input_2_next), .E(RST_N), .CK(CLK), .Q(input_2), 
        .QN(n144) );
  DFFRX1 \state_reg[0]  ( .D(state_next[0]), .CK(CLK), .RN(RST_N), .Q(state[0]), .QN(n143) );
  DFFRX1 \state_reg[1]  ( .D(state_next[1]), .CK(CLK), .RN(RST_N), .Q(state[1]), .QN(n142) );
  TLATX1 \Y_reg[0]  ( .G(N77), .D(N78), .Q(Y[0]) );
  TLATX1 \Y_reg[1]  ( .G(N77), .D(N79), .Q(Y[1]) );
  TLATX1 \Y_reg[2]  ( .G(N77), .D(N80), .Q(Y[2]) );
  TLATX1 \Y_reg[3]  ( .G(N77), .D(N81), .Q(Y[3]) );
  TLATX1 \Y_reg[4]  ( .G(N77), .D(N82), .Q(Y[4]) );
  TLATX1 \Y_reg[5]  ( .G(N77), .D(N83), .Q(Y[5]) );
  TLATX1 \Y_reg[6]  ( .G(N77), .D(N84), .Q(Y[6]) );
  TLATX1 \Y_reg[7]  ( .G(N77), .D(N85), .Q(Y[7]) );
  TLATX1 input_1_next_reg ( .G(N65), .D(N66), .Q(input_1_next) );
  TLATX1 output_2_next_reg ( .G(N68), .D(N70), .Q(output_2_next) );
  TLATX1 output_1_next_reg ( .G(N68), .D(N69), .Q(output_1_next) );
  TLATX1 error_next_reg ( .G(N71), .D(N72), .Q(error_next) );
  TLATX1 \state_next_reg[0]  ( .G(N73), .D(N74), .Q(state_next[0]) );
  TLATX1 DONE_reg ( .G(N63), .D(N64), .Q(DONE) );
  TLATX1 input_2_next_reg ( .G(N65), .D(n158), .Q(input_2_next) );
  TLATX1 \state_next_reg[2]  ( .G(N73), .D(N76), .Q(state_next[2]) );
  TLATX1 \state_next_reg[1]  ( .G(N73), .D(N75), .Q(state_next[1]) );
  DFFRX1 \state_reg[2]  ( .D(state_next[2]), .CK(CLK), .RN(RST_N), .Q(state[2]) );
  OAI222XL U223 ( .A0(reg_a[15]), .A1(n214), .B0(n117), .B1(n118), .C0(n119), 
        .C1(n111), .Y(n87) );
  OAI22XL U224 ( .A0(n186), .A1(n148), .B0(n152), .B1(n168), .Y(data_a[0]) );
  OAI22XL U225 ( .A0(n204), .A1(n87), .B0(n155), .B1(n205), .Y(data_b[9]) );
  OAI22XL U226 ( .A0(n188), .A1(n87), .B0(n154), .B1(n187), .Y(data_b[1]) );
  OAI22XL U227 ( .A0(n206), .A1(n87), .B0(n154), .B1(n207), .Y(data_b[10]) );
  OAI22XL U228 ( .A0(n192), .A1(n87), .B0(n155), .B1(n193), .Y(data_b[3]) );
  OAI22XL U229 ( .A0(n208), .A1(n87), .B0(n154), .B1(n209), .Y(data_b[11]) );
  OAI22XL U230 ( .A0(n202), .A1(n87), .B0(n155), .B1(n203), .Y(data_b[8]) );
  OAI22XL U231 ( .A0(n210), .A1(n148), .B0(n149), .B1(n184), .Y(data_b[12]) );
  OAI22XL U232 ( .A0(n196), .A1(n87), .B0(n154), .B1(n197), .Y(data_b[5]) );
  OAI22XL U233 ( .A0(n200), .A1(n87), .B0(n155), .B1(n201), .Y(data_b[7]) );
  OAI22XL U234 ( .A0(n212), .A1(n148), .B0(n151), .B1(n213), .Y(data_b[14]) );
  OAI22XL U235 ( .A0(n168), .A1(n87), .B0(n154), .B1(n186), .Y(data_b[0]) );
  OAI22XL U236 ( .A0(n189), .A1(n87), .B0(n155), .B1(n190), .Y(data_b[2]) );
  OAI22XL U237 ( .A0(n194), .A1(n148), .B0(n155), .B1(n195), .Y(data_b[4]) );
  OAI22XL U238 ( .A0(n198), .A1(n87), .B0(n155), .B1(n199), .Y(data_b[6]) );
  OAI22XL U239 ( .A0(n211), .A1(n148), .B0(n150), .B1(n185), .Y(data_b[13]) );
  CLKINVX1 U240 ( .A(n146), .Y(n157) );
  NOR3X1 U241 ( .A(n142), .B(state[2]), .C(n143), .Y(N69) );
  NAND2X1 U242 ( .A(output_1), .B(N70), .Y(n89) );
  OR3X2 U243 ( .A(state[1]), .B(state[2]), .C(n143), .Y(n145) );
  CLKINVX1 U244 ( .A(n151), .Y(n148) );
  NOR4X1 U245 ( .A(data_b[12]), .B(data_b[11]), .C(data_b[10]), .D(data_b[0]), 
        .Y(n83) );
  NOR4X1 U246 ( .A(data_b[9]), .B(data_b[8]), .C(data_b[7]), .D(data_b[6]), 
        .Y(n86) );
  NOR2X1 U247 ( .A(n82), .B(n166), .Y(N76) );
  CLKBUFX3 U248 ( .A(n156), .Y(n153) );
  CLKBUFX3 U249 ( .A(n156), .Y(n152) );
  CLKBUFX3 U250 ( .A(n156), .Y(n155) );
  CLKBUFX3 U251 ( .A(n156), .Y(n154) );
  CLKBUFX3 U252 ( .A(n156), .Y(n151) );
  CLKBUFX3 U253 ( .A(n156), .Y(n149) );
  CLKBUFX3 U254 ( .A(n156), .Y(n150) );
  CLKINVX1 U255 ( .A(n82), .Y(n183) );
  CLKINVX1 U256 ( .A(n136), .Y(n191) );
  OAI22XL U257 ( .A0(n214), .A1(n148), .B0(n152), .B1(n216), .Y(data_b[15]) );
  OAI22XL U258 ( .A0(n187), .A1(n148), .B0(n152), .B1(n188), .Y(data_a[1]) );
  OAI22XL U259 ( .A0(n190), .A1(n148), .B0(n152), .B1(n189), .Y(data_a[2]) );
  OAI22XL U260 ( .A0(n193), .A1(n148), .B0(n153), .B1(n192), .Y(data_a[3]) );
  OAI22XL U261 ( .A0(n195), .A1(n148), .B0(n153), .B1(n194), .Y(data_a[4]) );
  OAI22XL U262 ( .A0(n197), .A1(n148), .B0(n153), .B1(n196), .Y(data_a[5]) );
  OAI22XL U263 ( .A0(n199), .A1(n148), .B0(n153), .B1(n198), .Y(data_a[6]) );
  OAI22XL U264 ( .A0(n201), .A1(n148), .B0(n154), .B1(n200), .Y(data_a[7]) );
  OAI22XL U265 ( .A0(n203), .A1(n148), .B0(n152), .B1(n202), .Y(data_a[8]) );
  OAI22XL U266 ( .A0(n205), .A1(n148), .B0(n152), .B1(n204), .Y(data_a[9]) );
  OAI22XL U267 ( .A0(n207), .A1(n148), .B0(n152), .B1(n206), .Y(data_a[10]) );
  OAI22XL U268 ( .A0(n209), .A1(n148), .B0(n153), .B1(n208), .Y(data_a[11]) );
  OAI22XL U269 ( .A0(n184), .A1(n148), .B0(n153), .B1(n210), .Y(data_a[12]) );
  OAI22XL U270 ( .A0(n185), .A1(n148), .B0(n153), .B1(n211), .Y(data_a[13]) );
  OAI22XL U271 ( .A0(n213), .A1(n148), .B0(n154), .B1(n212), .Y(data_a[14]) );
  NAND4BX1 U272 ( .AN(n105), .B(n106), .C(n107), .D(n108), .Y(n82) );
  NOR3X1 U273 ( .A(n113), .B(n114), .C(n191), .Y(n107) );
  NOR4X1 U274 ( .A(n109), .B(n110), .C(n111), .D(n112), .Y(n108) );
  XNOR2X1 U275 ( .A(n193), .B(n192), .Y(n136) );
  OAI22XL U276 ( .A0(n169), .A1(n147), .B0(n76), .B1(n89), .Y(N85) );
  CLKINVX1 U277 ( .A(data_a[7]), .Y(n169) );
  OAI22XL U278 ( .A0(n171), .A1(n147), .B0(n170), .B1(n89), .Y(N84) );
  CLKINVX1 U279 ( .A(data_a[14]), .Y(n170) );
  CLKINVX1 U280 ( .A(data_a[6]), .Y(n171) );
  OAI22XL U281 ( .A0(n173), .A1(n147), .B0(n172), .B1(n89), .Y(N83) );
  CLKINVX1 U282 ( .A(data_a[13]), .Y(n172) );
  CLKINVX1 U283 ( .A(data_a[5]), .Y(n173) );
  OAI22XL U284 ( .A0(n175), .A1(n147), .B0(n174), .B1(n89), .Y(N82) );
  CLKINVX1 U285 ( .A(data_a[12]), .Y(n174) );
  CLKINVX1 U286 ( .A(data_a[4]), .Y(n175) );
  OAI22XL U287 ( .A0(n177), .A1(n147), .B0(n176), .B1(n89), .Y(N81) );
  CLKINVX1 U288 ( .A(data_a[11]), .Y(n176) );
  CLKINVX1 U289 ( .A(data_a[3]), .Y(n177) );
  OAI22XL U290 ( .A0(n179), .A1(n147), .B0(n178), .B1(n89), .Y(N80) );
  CLKINVX1 U291 ( .A(data_a[10]), .Y(n178) );
  CLKINVX1 U292 ( .A(data_a[2]), .Y(n179) );
  OAI22XL U293 ( .A0(n181), .A1(n147), .B0(n180), .B1(n89), .Y(N79) );
  CLKINVX1 U294 ( .A(data_a[9]), .Y(n180) );
  CLKINVX1 U295 ( .A(data_a[1]), .Y(n181) );
  OAI22XL U296 ( .A0(n167), .A1(n147), .B0(n182), .B1(n89), .Y(N78) );
  CLKINVX1 U297 ( .A(data_a[8]), .Y(n182) );
  CLKINVX1 U298 ( .A(data_a[0]), .Y(n167) );
  NAND4X1 U299 ( .A(n162), .B(n161), .C(n160), .D(n159), .Y(n101) );
  NAND4X1 U300 ( .A(n212), .B(n214), .C(n202), .D(n204), .Y(n95) );
  NAND4X1 U301 ( .A(n213), .B(n216), .C(n203), .D(n205), .Y(n99) );
  NAND4X1 U302 ( .A(n207), .B(n209), .C(n184), .D(n185), .Y(n100) );
  NAND4X1 U303 ( .A(n206), .B(n208), .C(n210), .D(n211), .Y(n96) );
  NAND2X1 U304 ( .A(n142), .B(n143), .Y(n116) );
  NAND2X1 U305 ( .A(n147), .B(n89), .Y(n90) );
  NAND2X1 U306 ( .A(n79), .B(n80), .Y(N86) );
  OAI2BB2XL U307 ( .B0(n145), .B1(n159), .A0N(data_b[15]), .A1N(n157), .Y(N103) );
  OAI2BB2XL U308 ( .B0(n145), .B1(n160), .A0N(data_b[14]), .A1N(n157), .Y(N102) );
  OAI2BB2XL U309 ( .B0(n145), .B1(n159), .A0N(data_b[7]), .A1N(n157), .Y(N94)
         );
  OAI2BB2XL U310 ( .B0(n145), .B1(n160), .A0N(data_b[6]), .A1N(n157), .Y(N93)
         );
  OAI2BB2XL U311 ( .B0(n145), .B1(n161), .A0N(data_b[5]), .A1N(n157), .Y(N92)
         );
  OAI2BB2XL U312 ( .B0(n145), .B1(n162), .A0N(data_b[4]), .A1N(n157), .Y(N91)
         );
  OAI2BB2XL U313 ( .B0(n145), .B1(n161), .A0N(data_b[13]), .A1N(n157), .Y(N101) );
  OAI2BB2XL U314 ( .B0(n145), .B1(n162), .A0N(data_b[12]), .A1N(n157), .Y(N100) );
  NAND2X1 U315 ( .A(n78), .B(n79), .Y(N95) );
  NAND4X1 U316 ( .A(n104), .B(n165), .C(n145), .D(n115), .Y(N63) );
  NOR3X1 U317 ( .A(n90), .B(n157), .C(N69), .Y(n115) );
  NAND3BX1 U318 ( .AN(N76), .B(n165), .C(n89), .Y(N68) );
  OAI21XL U319 ( .A0(n191), .A1(n113), .B0(n135), .Y(n132) );
  NAND3X1 U320 ( .A(n78), .B(n165), .C(n146), .Y(N65) );
  CLKINVX1 U321 ( .A(N66), .Y(n165) );
  NAND2X1 U322 ( .A(n146), .B(n80), .Y(N75) );
  CLKINVX1 U323 ( .A(n145), .Y(n158) );
  CLKINVX1 U324 ( .A(n87), .Y(n156) );
  CLKINVX1 U325 ( .A(N69), .Y(n166) );
  OR3X2 U326 ( .A(N69), .B(N65), .C(n92), .Y(N73) );
  AO21X1 U327 ( .A0(n82), .A1(N69), .B0(N70), .Y(N64) );
  XNOR2X1 U328 ( .A(n190), .B(reg_b[2]), .Y(n113) );
  AOI2BB2X1 U329 ( .B0(reg_b[14]), .B1(n213), .A0N(n127), .A1N(n137), .Y(n117)
         );
  AOI2BB2X1 U330 ( .B0(reg_b[7]), .B1(n201), .A0N(n110), .A1N(n129), .Y(n119)
         );
  AOI2BB2X1 U331 ( .B0(n185), .B1(reg_b[13]), .A0N(n138), .A1N(n126), .Y(n137)
         );
  XNOR2X1 U332 ( .A(n185), .B(reg_b[13]), .Y(n126) );
  XNOR2X1 U333 ( .A(reg_b[0]), .B(n186), .Y(n112) );
  XNOR2X1 U334 ( .A(reg_a[6]), .B(n198), .Y(n109) );
  XNOR2X1 U335 ( .A(reg_a[7]), .B(n200), .Y(n110) );
  XNOR2X1 U336 ( .A(reg_a[14]), .B(n212), .Y(n127) );
  XNOR2X1 U337 ( .A(n216), .B(reg_b[15]), .Y(n118) );
  XNOR2X1 U338 ( .A(reg_a[1]), .B(n188), .Y(n114) );
  NAND3BX1 U339 ( .AN(input_1), .B(n158), .C(input_2), .Y(n80) );
  XNOR2X1 U340 ( .A(n209), .B(reg_b[11]), .Y(n124) );
  XNOR2X1 U341 ( .A(reg_a[12]), .B(n210), .Y(n125) );
  XNOR2X1 U342 ( .A(reg_a[10]), .B(n206), .Y(n123) );
  NAND4BX1 U343 ( .AN(ERROR), .B(n157), .C(n81), .D(n82), .Y(n79) );
  NAND4X1 U344 ( .A(n83), .B(n84), .C(n85), .D(n86), .Y(n81) );
  NOR4X1 U345 ( .A(data_b[1]), .B(data_b[15]), .C(data_b[14]), .D(data_b[13]), 
        .Y(n84) );
  NOR4X1 U346 ( .A(data_b[5]), .B(data_b[4]), .C(data_b[3]), .D(data_b[2]), 
        .Y(n85) );
  XNOR2X1 U347 ( .A(reg_a[4]), .B(reg_b[4]), .Y(n106) );
  XNOR2X1 U348 ( .A(reg_a[5]), .B(n196), .Y(n105) );
  NOR2BX1 U349 ( .AN(state[2]), .B(n116), .Y(N70) );
  NOR2X1 U350 ( .A(n116), .B(state[2]), .Y(N66) );
  NOR2X1 U351 ( .A(reg_a[15]), .B(reg_b[15]), .Y(n76) );
  NAND2X1 U352 ( .A(state[2]), .B(n116), .Y(n104) );
  AOI2BB2X1 U353 ( .B0(n199), .B1(reg_b[6]), .A0N(n109), .A1N(n130), .Y(n129)
         );
  AOI2BB2X1 U354 ( .B0(n197), .B1(reg_b[5]), .A0N(n131), .A1N(n105), .Y(n130)
         );
  AOI32X1 U355 ( .A0(n132), .A1(n133), .A2(n106), .B0(reg_b[4]), .B1(n195), 
        .Y(n131) );
  OAI211X1 U356 ( .A0(reg_a[1]), .A1(n188), .B0(n134), .C0(n135), .Y(n133) );
  AOI2BB2X1 U357 ( .B0(reg_b[12]), .B1(n184), .A0N(n125), .A1N(n139), .Y(n138)
         );
  AOI2BB2X1 U358 ( .B0(n209), .B1(reg_b[11]), .A0N(n140), .A1N(n124), .Y(n139)
         );
  AOI2BB2X1 U359 ( .B0(reg_b[10]), .B1(n207), .A0N(n123), .A1N(n141), .Y(n140)
         );
  AOI32X1 U360 ( .A0(reg_b[8]), .A1(n203), .A2(n122), .B0(n205), .B1(reg_b[9]), 
        .Y(n141) );
  NAND2X1 U361 ( .A(input_1), .B(n158), .Y(n78) );
  OR4X1 U362 ( .A(B[0]), .B(B[1]), .C(B[2]), .D(B[3]), .Y(n98) );
  AOI2BB1X1 U363 ( .A0N(n93), .A1N(n94), .B0(n80), .Y(N72) );
  NOR4X1 U364 ( .A(n99), .B(n100), .C(n101), .D(n102), .Y(n93) );
  NOR4X1 U365 ( .A(n95), .B(n96), .C(n97), .D(n98), .Y(n94) );
  OR4X1 U366 ( .A(A[0]), .B(A[1]), .C(A[2]), .D(A[3]), .Y(n102) );
  OR4X1 U367 ( .A(B[4]), .B(B[5]), .C(B[6]), .D(B[7]), .Y(n97) );
  OAI31X1 U368 ( .A0(n145), .A1(input_2), .A2(input_1), .B0(n164), .Y(N77) );
  CLKINVX1 U369 ( .A(n90), .Y(n164) );
  OR3X2 U370 ( .A(state[0]), .B(state[2]), .C(n142), .Y(n146) );
  NAND2X1 U371 ( .A(n120), .B(n121), .Y(n111) );
  NOR4X1 U372 ( .A(n126), .B(n127), .C(n118), .D(n128), .Y(n120) );
  NOR4BX1 U373 ( .AN(n122), .B(n123), .C(n124), .D(n125), .Y(n121) );
  XNOR2X1 U374 ( .A(n202), .B(reg_a[8]), .Y(n128) );
  CLKINVX1 U375 ( .A(reg_a[13]), .Y(n185) );
  CLKINVX1 U376 ( .A(reg_a[11]), .Y(n209) );
  OAI211X1 U377 ( .A0(n145), .A1(n144), .B0(n147), .C0(n104), .Y(n92) );
  CLKINVX1 U378 ( .A(reg_a[9]), .Y(n205) );
  CLKINVX1 U379 ( .A(reg_a[10]), .Y(n207) );
  CLKINVX1 U380 ( .A(reg_a[14]), .Y(n213) );
  CLKINVX1 U381 ( .A(reg_b[10]), .Y(n206) );
  CLKINVX1 U382 ( .A(reg_b[14]), .Y(n212) );
  CLKINVX1 U383 ( .A(reg_a[12]), .Y(n184) );
  CLKINVX1 U384 ( .A(reg_b[12]), .Y(n210) );
  CLKINVX1 U385 ( .A(reg_b[8]), .Y(n202) );
  CLKINVX1 U386 ( .A(reg_b[13]), .Y(n211) );
  CLKINVX1 U387 ( .A(reg_b[11]), .Y(n208) );
  AO22X1 U388 ( .A0(n158), .A1(A[2]), .B0(data_b[2]), .B1(n157), .Y(N89) );
  AO22X1 U389 ( .A0(n158), .A1(A[0]), .B0(data_b[0]), .B1(n157), .Y(N87) );
  AO22X1 U390 ( .A0(n158), .A1(A[2]), .B0(data_b[10]), .B1(n157), .Y(N98) );
  AO22X1 U391 ( .A0(n158), .A1(A[1]), .B0(data_b[9]), .B1(n157), .Y(N97) );
  AO22X1 U392 ( .A0(n158), .A1(A[3]), .B0(data_b[3]), .B1(n157), .Y(N90) );
  AO22X1 U393 ( .A0(n158), .A1(A[1]), .B0(data_b[1]), .B1(n157), .Y(N88) );
  AO22X1 U394 ( .A0(n158), .A1(A[3]), .B0(data_b[11]), .B1(n157), .Y(N99) );
  AO22X1 U395 ( .A0(n158), .A1(A[0]), .B0(data_b[8]), .B1(n157), .Y(N96) );
  CLKBUFX3 U396 ( .A(n88), .Y(n147) );
  NAND3BX1 U397 ( .AN(output_1), .B(N70), .C(output_2), .Y(n88) );
  CLKINVX1 U398 ( .A(reg_a[8]), .Y(n203) );
  CLKINVX1 U399 ( .A(reg_a[15]), .Y(n216) );
  CLKINVX1 U400 ( .A(reg_b[9]), .Y(n204) );
  CLKINVX1 U401 ( .A(reg_b[15]), .Y(n214) );
  AOI32X1 U402 ( .A0(reg_b[2]), .A1(n190), .A2(n136), .B0(n193), .B1(reg_b[3]), 
        .Y(n135) );
  AO22X1 U403 ( .A0(n158), .A1(B[0]), .B0(diff[0]), .B1(n157), .Y(N104) );
  AO22X1 U404 ( .A0(n158), .A1(B[7]), .B0(diff[15]), .B1(n157), .Y(N119) );
  CLKINVX1 U405 ( .A(n76), .Y(n215) );
  AO22X1 U406 ( .A0(n158), .A1(B[6]), .B0(diff[14]), .B1(n157), .Y(N118) );
  AO22X1 U407 ( .A0(n158), .A1(B[5]), .B0(diff[13]), .B1(n157), .Y(N117) );
  AO22X1 U408 ( .A0(n158), .A1(B[4]), .B0(diff[12]), .B1(n157), .Y(N116) );
  AO22X1 U409 ( .A0(n158), .A1(B[3]), .B0(diff[11]), .B1(n157), .Y(N115) );
  AO22X1 U410 ( .A0(n158), .A1(B[2]), .B0(diff[10]), .B1(n157), .Y(N114) );
  AO22X1 U411 ( .A0(n158), .A1(B[1]), .B0(diff[9]), .B1(n157), .Y(N113) );
  AO22X1 U412 ( .A0(n158), .A1(B[0]), .B0(diff[8]), .B1(n157), .Y(N112) );
  AO22X1 U413 ( .A0(n158), .A1(B[7]), .B0(diff[7]), .B1(n157), .Y(N111) );
  AO22X1 U414 ( .A0(n158), .A1(B[6]), .B0(diff[6]), .B1(n157), .Y(N110) );
  AO22X1 U415 ( .A0(n158), .A1(B[5]), .B0(diff[5]), .B1(n157), .Y(N109) );
  AO22X1 U416 ( .A0(n158), .A1(B[4]), .B0(diff[4]), .B1(n157), .Y(N108) );
  AO22X1 U417 ( .A0(n158), .A1(B[3]), .B0(diff[3]), .B1(n157), .Y(N107) );
  AO22X1 U418 ( .A0(n158), .A1(B[2]), .B0(diff[2]), .B1(n157), .Y(N106) );
  AO22X1 U419 ( .A0(n158), .A1(B[1]), .B0(diff[1]), .B1(n157), .Y(N105) );
  CLKINVX1 U420 ( .A(A[4]), .Y(n162) );
  CLKINVX1 U421 ( .A(A[7]), .Y(n159) );
  CLKINVX1 U422 ( .A(A[6]), .Y(n160) );
  CLKINVX1 U423 ( .A(A[5]), .Y(n161) );
  CLKINVX1 U424 ( .A(reg_b[7]), .Y(n200) );
  CLKINVX1 U425 ( .A(reg_a[5]), .Y(n197) );
  CLKINVX1 U426 ( .A(reg_a[6]), .Y(n199) );
  CLKINVX1 U427 ( .A(reg_b[5]), .Y(n196) );
  CLKINVX1 U428 ( .A(reg_b[6]), .Y(n198) );
  CLKINVX1 U429 ( .A(reg_a[7]), .Y(n201) );
  OAI211X1 U430 ( .A0(n165), .A1(n163), .B0(n91), .C0(n78), .Y(N74) );
  CLKINVX1 U431 ( .A(START), .Y(n163) );
  OAI21XL U432 ( .A0(n183), .A1(ERROR), .B0(n157), .Y(n91) );
  CLKINVX1 U433 ( .A(reg_b[1]), .Y(n188) );
  CLKINVX1 U434 ( .A(reg_a[0]), .Y(n186) );
  CLKINVX1 U435 ( .A(reg_b[3]), .Y(n192) );
  CLKINVX1 U436 ( .A(reg_a[3]), .Y(n193) );
  CLKINVX1 U437 ( .A(reg_a[2]), .Y(n190) );
  XOR2X1 U438 ( .A(n205), .B(reg_b[9]), .Y(n122) );
  CLKINVX1 U439 ( .A(reg_b[4]), .Y(n194) );
  CLKINVX1 U440 ( .A(reg_b[2]), .Y(n189) );
  CLKINVX1 U441 ( .A(reg_a[4]), .Y(n195) );
  CLKINVX1 U442 ( .A(reg_a[1]), .Y(n187) );
  CLKINVX1 U443 ( .A(reg_b[0]), .Y(n168) );
  OAI211X1 U444 ( .A0(n183), .A1(n166), .B0(n78), .C0(n103), .Y(N71) );
  AOI2BB1X1 U445 ( .A0N(n165), .A1N(START), .B0(n92), .Y(n103) );
  AO21X1 U446 ( .A0(n112), .A1(reg_a[0]), .B0(n114), .Y(n134) );
endmodule

