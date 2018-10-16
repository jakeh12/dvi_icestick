module top (
  input  ref_clk,
  output tmds_0_p,
  output tmds_0_n,
  output tmds_1_p,
  output tmds_1_n,
  output tmds_2_p,
  output tmds_2_n,
  output tmds_clk_p,
  output tmds_clk_n,
  output led_0,
  output led_1,
  output led_2,
  output led_3,
  output led_4
);
  
  wire w_pxlclk_raw, w_pxlclk;
  wire w_serclk_raw, w_serclk;
  wire w_serclk_locked;
  
  SB_PLL40_CORE #(
    .FEEDBACK_PATH ("SIMPLE"),
    .DIVR          (4'b0000),
    .DIVF          (7'b1010011),
    .DIVQ          (3'b011),
    .FILTER_RANGE  (3'b001)
  ) pll_serclk (
    .REFERENCECLK  (ref_clk),
    .PLLOUTGLOBAL  (w_serclk_raw),
    .LOCK          (w_serclk_locked),
    .BYPASS        (1'b0),
    .RESETB        (1'b1)
  );
  
  wire w_rstn;
  assign w_rstn = w_serclk_locked;
  
  SB_GB serclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (w_serclk_raw),
    .GLOBAL_BUFFER_OUTPUT         (w_serclk)
  );
  
  clk_divider pxlclk_divider (
    .i_clk  (w_serclk),
    .i_rstn (w_rstn),
    .o_clk  (w_pxlclk_raw)
  );
  
  SB_GB pxlclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (w_pxlclk_raw),
    .GLOBAL_BUFFER_OUTPUT         (w_pxlclk)
  );
  
  
  wire w_de, w_hs, w_vs;
  wire [9:0] w_x;
  wire [9:0] w_y;
  
  timing_generator #(
    .ACTIVE_WIDTH_PIX           (640),
    .ACTIVE_HEIGHT_PIX          (480),
    .HORIZONTAL_FRONT_PORCH_PIX ( 16),
    .HORIZONTAL_SYNC_PULSE_PIX  ( 96),
    .HORIZONTAL_BACK_PORCH_PIX  ( 48),
    .VERTICAL_FRONT_PORCH_LINES ( 10),
    .VERTICAL_SYNC_PULSE_LINES  (  2),
    .VERTICAL_BACK_PORTCH_LINES ( 33)
	)
	tg_0 (
    .i_clk  (w_pxlclk),
    .i_rstn (w_rstn),
    .o_de   (w_de),
    .o_hs   (w_hs),
    .o_vs   (w_vs),
    .o_x    (w_x),
    .o_y    (w_y)
  );
	
	wire w_ig_de, w_ig_hs, w_ig_vs;
	wire [23:0] w_ig_bgr;
	
	image_generator ig_0 (
	  .i_clk  (w_pxlclk),
	  .i_rstn (w_rstn),
	  .i_de   (w_de),
	  .i_hs   (w_hs),
	  .i_vs   (w_vs),
	  .i_x    (w_x),
	  .i_y    (w_y),
	  .o_de   (w_ig_de),
	  .o_hs   (w_ig_hs),
	  .o_vs   (w_ig_vs),
	  .o_bgr  (w_ig_bgr),
	);
	
	
   
  wire [2:0] w_ser_re, w_ser_fe;
  
  tmds_vo tmds_vo_0 (
    .i_serclk (w_serclk),
    .i_pxlclk (w_pxlclk),
    .i_rstn   (w_rstn),
    .i_hs     (w_ig_hs),
    .i_vs     (w_ig_vs),
    .i_de     (w_ig_de),
    .i_bgr    (w_ig_bgr),
    .o_ser_re (w_ser_re),
    .o_ser_fe (w_ser_fe)
  );
  
  
  /*************************
  
   DIFFERENTIAL DDR OUTPUTS
  
  *************************/
  
  // tmds channel 0 (blue + syncs) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_0_p (
    .PACKAGE_PIN (tmds_0_p),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[0]),
    .D_OUT_1     (w_ser_re[0])
  );
  
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_0_n (
    .PACKAGE_PIN (tmds_0_n),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[0]),
    .D_OUT_1     (~w_ser_re[0])
  );
  
  // tmds channel 1 (green) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_1_p (
    .PACKAGE_PIN (tmds_1_p),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[1]),
    .D_OUT_1     (w_ser_re[1])
  );
  
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_1_n (
    .PACKAGE_PIN (tmds_1_n),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[1]),
    .D_OUT_1     (~w_ser_re[1])
  );
  
  // tmds channel 2 (red) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_2_p (
    .PACKAGE_PIN (tmds_2_p),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[2]),
    .D_OUT_1     (w_ser_re[2])
  );
  
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_2_n (
    .PACKAGE_PIN (tmds_2_n),
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[2]),
    .D_OUT_1     (~w_ser_re[2])
  );
  
  // tmds clk differential pair
  SB_IO #(
    .PIN_TYPE    (6'b011010)
  ) sb_io_tmds_clk_p (
    .PACKAGE_PIN (tmds_clk_p),
    .D_OUT_0     (w_pxlclk)
  );
  
  SB_IO #(
    .PIN_TYPE    (6'b011010)
  ) sb_io_tmds_clk_n (
    .PACKAGE_PIN (tmds_clk_n),
    .D_OUT_0     (~w_pxlclk)
  );
  
  assign led_0 = 0;
  assign led_1 = 0;
  assign led_2 = 0;
  assign led_3 = 0;
  assign led_4 = w_rstn;
  
endmodule
