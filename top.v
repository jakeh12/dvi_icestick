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
  wire w_rstn;
  reg [23:0] r_bgr;


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

  SB_GB serclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (w_serclk_raw),
    .GLOBAL_BUFFER_OUTPUT         (w_serclk)
  );

  clk_divider pxlclk_divider (
    .clki (w_serclk),
    .clko (w_pxlclk_raw)
  );

  SB_GB pxlclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (w_pxlclk_raw),
    .GLOBAL_BUFFER_OUTPUT         (w_pxlclk)
  );

  assign w_rstn = w_serclk_locked;

  reg [9:0] r_col_cnt;
  reg [9:0] r_row_cnt;

  reg r_hs, r_vs, r_de;

  initial begin
      r_bgr     <= 24'h000000;
    
      r_col_cnt <= 0;
      r_row_cnt <= 0;

      r_hs      <= 0;
      r_vs      <= 0;
      r_de      <= 0;
  end

  always @(posedge w_pxlclk) begin
    
      r_col_cnt <= r_col_cnt + 1;
      if (r_col_cnt == 16-1-1) begin
      // hsync pulse
      r_hs <= 1'b1;
      end else if (r_col_cnt == 112-1) begin
          // back porch
          r_hs <= 1'b0;
      end else if (r_col_cnt == 160-1) begin
          r_de <= 1'b1;
      end else if (r_col_cnt == 800-1) begin
          r_de <= 1'b0;
          r_col_cnt <= 0;
          r_row_cnt <= r_row_cnt + 1;
      end

      if (r_row_cnt > 480-1) begin
          r_de <= 1'b0;
          if (r_row_cnt == 490-1) begin
              r_vs <= 1'b1;
          end else if (r_row_cnt == 492-1) begin
              r_vs <= 1'b0;
          end else if (r_row_cnt == 525-1) begin
              r_row_cnt <= 0;
          end
      end

  end

  wire [2:0] w_ser_re, w_ser_fe;

  dvi dvi_0 (
      .i_serclk (w_serclk),
      .i_pxlclk (w_pxlclk),
      .i_rstn   (w_rstn),
      .i_hs     (r_hs),
      .i_vs     (r_vs),
      .i_de     (r_de),
      .i_bgr    (r_bgr),
      .o_ser_re (w_ser_re),
      .o_ser_fe (w_ser_fe)
  );

  assign led_0 = 0;
  assign led_1 = 0;
  assign led_2 = 0;
  assign led_3 = 0;
  assign led_4 = w_rstn;


  always @(posedge w_pxlclk) begin
    r_bgr <= r_col_cnt[0] == 1 ? 24'h0000FF : 24'h000000;
  end


  //
  // wire [7:0] char_line;
  //
  // character_generator cg_0 (
  //   .pxlclk (w_pxlclk),
  //   .ascii  (r_col_cnt[9:3]),
  //   .row    (r_row_cnt[2:0]),
  //   .dout   (char_line)
  // );
  //
  // reg [7:0] char_line_reg;
  // reg [2:0] char_col;
  // reg r_pxl;
  //
  // always @(posedge w_pxlclk) begin
  //   if (r_col_cnt[2:0] == 7) begin
  //     char_line_reg <= char_line;
  //   end
  //   r_pxl <= char_line_reg[char_col];
  //   char_col <= char_col + 1;
  //   if (r_pxl) begin
  //     r_bgr <= 24'hFFFFFF;
  //   end else begin
  //     r_bgr <= 24'h000000;
  //   end
  // end



  /*************************

   DIFFERENTIAL DDR OUTPUTS

  *************************/

  // tmds channel 0 (blue + syncs) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_0_p (
    .PACKAGE_PIN (tmds_0_p),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[0]),
    .D_OUT_1     (w_ser_re[0])
  );

  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_0_n (
    .PACKAGE_PIN (tmds_0_n),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[0]),
    .D_OUT_1     (~w_ser_re[0])
  );

  // tmds channel 1 (green) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_1_p (
    .PACKAGE_PIN (tmds_1_p),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[1]),
    .D_OUT_1     (w_ser_re[1])
  );

  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_1_n (
    .PACKAGE_PIN (tmds_1_n),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[1]),
    .D_OUT_1     (~w_ser_re[1])
  );

  // tmds channel 2 (red) differential pair
  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_2_p (
    .PACKAGE_PIN (tmds_2_p),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (w_ser_fe[2]),
    .D_OUT_1     (w_ser_re[2])
  );

  SB_IO #(
    .PIN_TYPE    (6'b010010)
  ) sb_io_tmds_2_n (
    .PACKAGE_PIN (tmds_2_n),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .OUTPUT_CLK  (w_serclk),
    .D_OUT_0     (~w_ser_fe[2]),
    .D_OUT_1     (~w_ser_re[2])
  );

  // tmds clk differential pair
  SB_IO #(
    .PIN_TYPE    (6'b011010)
  ) sb_io_tmds_clk_p (
    .PACKAGE_PIN (tmds_clk_p),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .D_OUT_0     (w_pxlclk)
  );

  SB_IO #(
    .PIN_TYPE    (6'b011010)
  ) sb_io_tmds_clk_n (
    .PACKAGE_PIN (tmds_clk_n),
    //.CLOCK_ENABLE (1'b1), // TODO: remove later, only for simulation
    .D_OUT_0     (~w_pxlclk)
  );

endmodule
