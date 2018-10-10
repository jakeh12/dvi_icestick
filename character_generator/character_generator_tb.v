`timescale 1ns / 1ps

module character_generator_tb ();

reg pxlclk;
reg [6:0] ascii;
reg [2:0] row;
wire [7:0] dout;

character_generator dut (
    .pxlclk (pxlclk),
	.ascii  (ascii),
	.row    (row),
	.dout   (dout)
);
    // clk
    always #5 pxlclk = ~pxlclk;
    
    initial begin
        $dumpfile("character_generator_tb.vcd");
        $dumpvars;
        pxlclk  = 1'b0;
		ascii   = 7'b0000000;
		row     = 3'b000;
		#10
		ascii = 7'b0111111;
		row = 3'b000;
		#10 row = 3'b001;
		#10 row = 3'b010;
		#10 row = 3'b011;
		#10 row = 3'b100;
		#10 row = 3'b101;
		#10 row = 3'b110;
		#10 row = 3'b111;
        #1000 $finish;
    end

endmodule
