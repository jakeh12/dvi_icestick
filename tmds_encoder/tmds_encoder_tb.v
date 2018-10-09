`timescale 1ns/1ps

module tmds_encoder_tb ();

reg clk, rstn, dena;
reg [1:0] ctrl;
reg [7:0] din;
wire [9:0] dout;

tmds_encoder dut (
    .clk  (clk),
	.rstn (rstn),
	.dena (dena),
    .ctrl (ctrl),
    .din  (din),
    .dout (dout)
);

initial begin
	clk  = 0;
	rstn = 0;
	dena = 0;
	ctrl = 2'b00;
	din  = 8'b11111111;
end

always #5 clk = ~clk;

initial begin
	$dumpfile ("tmds_encoder_tb.vcd"); 
	$dumpvars;
end

initial begin
	#10 rstn = 1;
	#30 dena = 1;
	#100 dena = 0;
	#120 ctrl = 2'b01;
	#140 ctrl = 2'b10;
	#160 ctrl = 2'b11;
	#180 ctrl = 2'b00;
	#200 $finish;
end

endmodule