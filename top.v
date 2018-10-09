module top(
    input ref_clk,
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


wire pxlclk_raw, pxlclk;
wire serclk_raw, serclk;
wire serclk_locked;
wire rstn;
reg [7:0] r, g, b;


SB_PLL40_CORE pll_serclk (
    .REFERENCECLK (ref_clk),
    .PLLOUTGLOBAL (serclk_raw),
    .LOCK (serclk_locked),
    .BYPASS (1'b0),
    .RESETB (1'b1)
);

defparam pll_serclk.FEEDBACK_PATH = "SIMPLE";
defparam pll_serclk.DIVR          = 4'b0000;
defparam pll_serclk.DIVF          = 7'b1010011;
defparam pll_serclk.DIVQ          = 3'b011;
defparam pll_serclk.FILTER_RANGE  = 3'b001;


SB_GB serclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (serclk_raw),
    .GLOBAL_BUFFER_OUTPUT (serclk)
);

clk_divider pxlclk_divider (
    .clki (serclk),
    .clko (pxlclk_raw)
);

SB_GB pxlclk_gb (
    .USER_SIGNAL_TO_GLOBAL_BUFFER (pxlclk_raw),
    .GLOBAL_BUFFER_OUTPUT (pxlclk)
);

assign rstn = serclk_locked;

reg [9:0] col_cnt;
reg [8:0] row_cnt;

reg hsync, vsync, dena;

initial begin
    r = 8'b11111111;
    g = 8'b00000000;
    b = 8'b00000000;

    col_cnt = 0;
    row_cnt = 0;

    hsync = 0;
    vsync = 0;
    dena  = 0;
end

always @(posedge pxlclk) begin
    
    col_cnt <= col_cnt + 1;
    if (col_cnt == 16) begin
    // hsync pulse
    hsync <= 1'b1;
    end else if (col_cnt == 112) begin
        // back porch
        hsync <= 1'b0;
    end else if (col_cnt == 160) begin
        dena <= 1'b1;
    end else if (col_cnt == 800) begin
        dena <= 1'b0;
        col_cnt <= 0;
        row_cnt <= row_cnt + 1;
    end

    if (row_cnt >= 480) begin
        dena <= 1'b0;
        if (row_cnt == 490) begin
            vsync <= 1'b1;
        end else if (row_cnt == 492) begin
            vsync <= 1'b0;
        end else if (row_cnt == 525) begin
            row_cnt <= 0;
        end
    end

end

dvi tmds (
    .serclk (serclk),
    .pxlclk (pxlclk),
    .rstn   (rstn),
    .r      (r),
    .g      (g),
    .b      (b),
    .hsync  (hsync),
    .vsync  (vsync),
    .dena   (dena),
    .tmds_p ({tmds_clk_p, tmds_2_p, tmds_1_p, tmds_0_p}),
    .tmds_n ({tmds_clk_n, tmds_2_n, tmds_1_n, tmds_0_n})
);

assign led_0 = 0;
assign led_1 = 0;
assign led_2 = 0;
assign led_3 = 0;
assign led_4 = rstn;

endmodule
