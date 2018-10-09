`timescale 1ns/1ps

module clk_divider_tb();

reg clki;
wire clko;

clk_divider dut (
	.clki  (clki),
	.clko (clkp)
);

initial begin
	clki = 0;
end

always #5 clki = ~clki;

initial begin
	$dumpfile ("clk_divider_tb.vcd"); 
	$dumpvars;
end

initial begin
	#200 $finish;
end

endmodule
