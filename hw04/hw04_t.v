`define INPUT_A   "input_A.txt"
`define INPUT_B   "input_B.txt"
`define A_HEX	  "A_hex.txt"
`define B_HEX	  "B_hex.txt"
`define OUTPUT    "out_log.txt"

`timescale 1ns/100ps
`define SYNTHESIS

module load_bmp(
  clk,
  rst_n,
  start,
  out_pixel,
  out_valid
);

  parameter period = 10;
  parameter delay = 1;
  output reg clk;
  output reg rst_n;
  output reg start;

  input [7:0] out_pixel;
  input out_valid;

 integer input_A, input_B, A_hex, B_hex, out_log, data, i, j;

  reg signed [8:0] index_x;
  reg signed [8:0] index_y;
  

//  initial begin
  //  $fsdbDumpfile(`FSDB_FILE);
  //  $fsdbDumpvars;
 // end 

	initial begin
		`ifdef SYNTHESIS
			$sdf_annotate("hw04.sdf", systolic_1);
			$fsdbDumpfile("hw04_syn.fsdb");
		`else
			$fsdbDumpfile("hw04.fsdb");
		`endif
		$fsdbDumpvars;
	end


  initial begin
    // File handlers
    input_A = $fopen(`INPUT_A, "r");
	input_B = $fopen(`INPUT_B, "r");
	A_hex = $fopen(`A_HEX, "wd");
	B_hex = $fopen(`B_HEX, "wd");
    out_log = $fopen(`OUTPUT, "wd");
	
	//while (!$feof(input_A)) begin	
	//	$fscanf(input_A, "%d", data);
	//	$fwrite(A_hex, "%1h\n", data);
	//end
	
	$fscanf(input_A, "%d", data);
	while (!$feof(input_A)) begin	
		$fwrite(A_hex, "%1h\n", data);
		$fscanf(input_A, "%d", data);
	end

	$fscanf(input_B, "%d", data);
	while (!$feof(input_B)) begin
		$fwrite(B_hex, "%1h\n", data);
		$fscanf(input_B, "%d", data);
	end

	$fclose(input_A);
	$fclose(input_B);
	$fclose(A_hex);
	$fclose(B_hex);

  end
  
 // create the clock
  always #(period/2) clk = ~clk;

  // test patterns
  initial begin
    clk = 0;
    rst_n = 0;
    start = 0;
    #(period) rst_n = 0;
    #(period) rst_n = 1;
    #(period) start = 1;

	//@(out_valid)	
	for(i=0; i<128; i=i+1) begin
		for(j=0; j<16; j=j+1) begin
			@(posedge out_valid)
			if (j==15) begin
				$fwrite(out_log, "%3d", out_pixel);
			end else begin			
				$fwrite(out_log, "%3d", out_pixel);
				$fwrite(out_log, " ");
			end
		end
		$fwrite(out_log, "\n");
	end
			
	

    $fclose(out_log);

    // delay 100 more cycles
    #(period*35000);

    $finish;

    // enjoy the Verilog coding
  end
endmodule
