`timescale 1ns/1ps

module tmds_serializer_tb ();


		reg pxlclk;
		reg serclk;
		reg [9:0] red;
		reg [9:0] green;
		reg [9:0] blue;
		wire red_r;
		wire red_f;
		wire green_r;
		wire green_f;
		wire blue_r;
		wire blue_f;
		wire clk;

tmds_serializer dut (
		.pxlclk  (pxlclk),
		.serclk  (serclk),
		.r       (red),
		.g       (green),
		.b       (blue),
		.rising  ({blue_r, green_r, red_r}),
		.falling ({blue_f, green_f, red_f}),
		.clk     (clk)
);


initial begin
	pxlclk = 0;
	serclk = 0;
	red    = 10'b0000000000;
	green  = 10'b0000000000;
	blue   = 10'b0000000000;
end

always #1 serclk = ~serclk;
always #5 pxlclk = ~pxlclk;

initial begin
	$dumpfile ("tmds_encoder_tb.vcd"); 
	$dumpvars;
end

initial begin
	#10 red = 10'b1101010100;
	#10 red = 10'b0010101011;
	#10 red = 10'b0101010100;
	#10 red = 10'b1010101011;

	#10 red = 10'b1101010100;
	#10 red = 10'b0010101011;
	#10 red = 10'b0101010100;
	#10 red = 10'b1010101011;
	
	#200 $finish;
end

endmodule