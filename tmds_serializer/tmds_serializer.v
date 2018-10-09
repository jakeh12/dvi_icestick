module tmds_serializer(
		input pxlclk,
		input serclk,
		input [9:0] r,
		input [9:0] g,
		input [9:0] b,
		output reg [2:0] rising,
		output reg [2:0] falling,
		output clk
);

reg [9:0] din_pxlclk_r;
reg [9:0] din_pxlclk_g;
reg [9:0] din_pxlclk_b;


always @(posedge pxlclk) begin
	din_pxlclk_r <= r;
	din_pxlclk_g <= g;
	din_pxlclk_b <= b;
end

reg [2:0] bit_cnt;
reg [9:0] din_serclk_r;
reg [9:0] din_serclk_g;
reg [9:0] din_serclk_b;


initial begin
	bit_cnt = 0;
end

always @(posedge serclk) begin
	bit_cnt <= bit_cnt + 1;
	
	if (bit_cnt == 4) begin
		bit_cnt <= 0;
		din_serclk_r <= din_pxlclk_r;
		din_serclk_g <= din_pxlclk_g;
		din_serclk_b <= din_pxlclk_b;
	end
	
	rising[2]  <= din_serclk_r[{bit_cnt, 1'b0}];
	rising[1]  <= din_serclk_g[{bit_cnt, 1'b0}];
	rising[0]  <= din_serclk_b[{bit_cnt, 1'b0}];
	falling[2] <= din_serclk_r[{bit_cnt, 1'b0} + 1'b1];
	falling[1] <= din_serclk_g[{bit_cnt, 1'b0} + 1'b1];
	falling[0] <= din_serclk_b[{bit_cnt, 1'b0} + 1'b1];
	
end


assign clk = pxlclk;

endmodule