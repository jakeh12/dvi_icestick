module dvi (
    input serclk,
    input pxlclk,
    input rstn,
    input [7:0] r,
    input [7:0] g,
    input [7:0] b,
    input hsync,
    input vsync,
    input dena,
    output [3:0] tmds_p,
    output [3:0] tmds_n
);

/*********************

 TMDS DATA ENCODERS 

*********************/

// tmds encode pixel and control data
wire [9:0] tmds_data [2:0];

tmds_encoder encoder_0 (
    .clk (pxlclk),
    .rstn (rstn),
    .dena (dena),
    .ctrl ({vsync, hsync}),
    .din (b),
    .dout (tmds_data[0])
);

tmds_encoder encoder_1 (
    .clk (pxlclk),
    .rstn (rstn),
    .dena (dena),
    .ctrl (2'b00),
    .din (g),
    .dout (tmds_data[1])
);

tmds_encoder encoder_2 (
    .clk (pxlclk),
    .rstn (rstn),
    .dena (dena),
    .ctrl (2'b00),
    .din (r),
    .dout (tmds_data[2])
);


/*********************

 10:1 DDR SERIALIZERS 

*********************/

wire [2:0] tmds_rising, tmds_falling;
wire tmds_clk;

tmds_serializer serializer_0 (
	.pxlclk  (pxlclk),
	.serclk  (serclk),
	.r       (tmds_data[2]),
	.g       (tmds_data[1]),
	.b       (tmds_data[0]),
	.rising  (tmds_rising),
	.falling (tmds_falling),
	.clk     (tmds_clk)
);


/*************************

 DIFFERENTIAL DDR OUTPUTS

*************************/

// tmds channel 0 (blue + syncs) differential pair
SB_IO tmds_0_p (
    .PACKAGE_PIN (tmds_p[0]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (tmds_falling[0]),
    .D_OUT_1 (tmds_rising[0])
);
defparam tmds_0_p.PIN_TYPE = 6'b010010;

SB_IO tmds_0_n (
    .PACKAGE_PIN (tmds_n[0]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (~tmds_falling[0]),
    .D_OUT_1 (~tmds_rising[0])
);
defparam tmds_0_n.PIN_TYPE = 6'b010010;

// tmds channel 1 (green) differential pair
SB_IO tmds_1_p (
    .PACKAGE_PIN (tmds_p[1]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (tmds_falling[1]),
    .D_OUT_1 (tmds_rising[1])
);
defparam tmds_1_p.PIN_TYPE = 6'b010010;

SB_IO tmds_1_n (
    .PACKAGE_PIN (tmds_n[1]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (~tmds_falling[1]),
    .D_OUT_1 (~tmds_rising[1])
);
defparam tmds_1_n.PIN_TYPE = 6'b010010;

// tmds channel 2 (red) differential pair
SB_IO tmds_2_p (
    .PACKAGE_PIN (tmds_p[2]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (tmds_falling[2]),
    .D_OUT_1 (tmds_rising[2])
);
defparam tmds_2_p.PIN_TYPE = 6'b010010;

SB_IO tmds_2_n (
    .PACKAGE_PIN (tmds_n[2]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK (serclk),
    .D_OUT_0 (~tmds_falling[2]),
    .D_OUT_1 (~tmds_rising[2])
);
defparam tmds_2_n.PIN_TYPE = 6'b010010;

// tmds clk differential pair
SB_IO tmds_clk_p (
    .PACKAGE_PIN (tmds_p[3]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .D_OUT_0 (tmds_clk)
);
defparam tmds_clk_p.PIN_TYPE = 6'b011010;

SB_IO tmds_clk_n (
    .PACKAGE_PIN (tmds_n[3]),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .D_OUT_0 (~tmds_clk)
);
defparam tmds_clk_n.PIN_TYPE = 6'b011010;


endmodule