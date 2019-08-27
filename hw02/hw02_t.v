`timescale 1ns/100ps
module stimulus;
  parameter cyc = 10;
  parameter delay = 10;
  reg clk, rst_n, start;
  reg [7:0] a, b;
  wire done, error;
  wire [7:0] y;

// [HW] complete the port connections
//  GCD gcd01 (
//    .CLK(...
//    .RST_N(
//    ...
//    ...
//  );
	GCD gcd01 (
		.CLK(clk),
		.RST_N(rst_n),
		.A(a),
		.B(b),
		.START(start),
		.Y(y),
		.DONE(done),
		.ERROR(error)
	);

  always #(cyc/2) clk = ~clk;

  initial begin
	`ifdef SYNTHESIS
		$sdf_annotate("hw02_syn.sdf", gcd01);
      	$fsdbDumpfile("hw02_syn.fsdb");
	`else
 	$fsdbDumpfile("hw02.fsdb");
	`endif

    $fsdbDumpvars;

    $monitor($time, " CLK=%b RST_N=%b START=%b A=%d B=%d | DONE=%b Y=%d ERROR=%b",
      clk, rst_n, start, a, b, done, y, error);
  end

  initial begin
	a = 8'd0;
	b = 8'd1;
	#(cyc);

    clk = 1;
    rst_n = 1;
    #(cyc);
    #(delay) rst_n = 0;
    #(cyc*4) rst_n = 1;
    #(cyc*2);

    #(cyc) nop;

	// gcd(900, 450)
	#(cyc) load; data_in(8'd3, 8'd1);
    #(cyc*2) nop;
	data_in(8'd132, 8'd194);
    #(cyc) nop;
    @(posedge done);
   
	#(cyc*4) nop;

	// gcd(450, 900)
	#(cyc) load; data_in(8'd1, 8'd3);
    #(cyc*2) nop;
	data_in(8'd194, 8'd132);
    #(cyc) nop;
    @(posedge done);

	#(cyc*4) nop;

	// gcd(3096, 1428)
    #(cyc) load; data_in(8'd12, 8'd5);
    #(cyc*2) nop;
	data_in(8'd24, 8'd148);
    #(cyc) nop;
    @(posedge done);

	#(cyc*4) nop;

	// gcd(0, 0)
	#(cyc) load; data_in(8'd0, 8'd0);
    #(cyc*2) nop;
	data_in(8'd0, 8'd0);
    #(cyc) nop;
    @(posedge done);


	#(cyc*4) nop;

	// gcd(0, 259)
	#(cyc) load; data_in(8'd0, 8'd1);
    #(cyc*2) nop;
	data_in(8'd0, 8'd3);
    #(cyc) nop;
    @(posedge done);
    
// [HW] apply more patterns to cover
// different conditions

	#(cyc) nop;
    #(cyc) nop;
    #(cyc*8);
    $finish;
  end

  // take a careful look at 
  // the usage of task here
  task nop;
    begin
      start = 0;
    end
  endtask
  task load;
    begin
      start = 1;
    end
  endtask
  task data_in;
    input [7:0] data1, data2;
    begin
      a = data1;
      b = data2;
    end
  endtask
endmodule

