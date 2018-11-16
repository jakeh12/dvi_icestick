module image_generator (
  input             i_clk,
  input             i_rstn,
  input             i_de,
  input             i_hs,
  input             i_vs,
  input      [9:0]  i_x,
  input      [9:0]  i_y,
  output reg        o_de,
  output reg        o_hs,
  output reg        o_vs,
  output reg [23:0] o_bgr
);
  
  
  wire [15:0] w_x_0;
  wire [15:0] w_y_0;
  wire [15:0] w_cx_0;
  wire [15:0] w_cy_0;
  wire [7:0]  w_cnt_0;
  
  wire [15:0] w_x_1;
  wire [15:0] w_y_1;
  wire [15:0] w_cx_1;
  wire [15:0] w_cy_1;
  wire [7:0]  w_cnt_1;
  
  wire [15:0] w_x_2;
  wire [15:0] w_y_2;
  wire [15:0] w_cx_2;
  wire [15:0] w_cy_2;
  wire [7:0]  w_cnt_2;
  
  wire [7:0]  w_cnt_3;
  
mandelbrot m_0 (
  .i_clk  (i_clk),
  .i_rstn (i_rstn),
  .i_x    (0),
  .i_y    (0),
  .i_cx   (i_x),//({i_x, 6'b000000'}),
  .i_cy   (i_y),//({i_y, 6'b000000'}),
  .i_cnt  (0),
  .o_x    (w_x_0),
  .o_y    (w_y_0),
  .o_cx   (w_cx_0),
  .o_cy   (w_cy_0),
  .o_cnt  (w_cnt_0)
);

mandelbrot m_1 (
  .i_clk  (i_clk),
  .i_rstn (i_rstn),
  .i_x    (w_x_0),
  .i_y    (w_y_0),
  .i_cx   (w_cx_0),
  .i_cy   (w_cy_0),
  .i_cnt  (w_cnt_0),
  .o_x    (w_x_1),
  .o_y    (w_y_1),
  .o_cx   (w_cx_1),
  .o_cy   (w_cy_1),
  .o_cnt  (w_cnt_1)
);

mandelbrot m_2 (
  .i_clk  (i_clk),
  .i_rstn (i_rstn),
  .i_x    (w_x_1),
  .i_y    (w_y_1),
  .i_cx   (w_cx_1),
  .i_cy   (w_cy_1),
  .i_cnt  (w_cnt_1),
  .o_x    (w_x_2),
  .o_y    (w_y_2),
  .o_cx   (w_cx_2),
  .o_cy   (w_cy_2),
  .o_cnt  (w_cnt_2)
);

mandelbrot m_3 (
  .i_clk  (i_clk),
  .i_rstn (i_rstn),
  .i_x    (w_x_2),
  .i_y    (w_y_2),
  .i_cx   (w_cx_2),
  .i_cy   (w_cy_2),
  .i_cnt  (w_cnt_2),
  //.o_x    (),
  //.o_y    (),
  //.o_cx   (),
  //.o_cy   (),
  .o_cnt  (w_cnt_3)
);
  
  
  
  
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      o_de  <= 0;
      o_hs  <= 0;
      o_vs  <= 0;
      o_bgr <= 0;
    end else begin
      o_de  <= i_de;
      o_hs  <= i_hs;
      o_vs  <= i_vs;
      //if (i_x == 0 || i_x == 639 || i_y == 0 || i_y == 479) begin
      if (w_cnt_3 == 3) begin
        o_bgr <= 24'h0000FF;
      end else if (w_cnt_3 == 2) begin
        o_bgr <= 24'h00FF00;
      end else if (w_cnt_3 == 1) begin
        o_bgr <= 24'hFF0000;
      end else begin
        o_bgr <= 24'h000000;
      end
    end
  end
  
endmodule
