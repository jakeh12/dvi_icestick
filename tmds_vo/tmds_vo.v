// -----------------------------------------------------------------------------
// vim:set shiftwidth=2 softtabstop=2 expandtab colorcolumn=80: 
//
// Module: tmds_vo.v
// Project: OpenFPGA
// Description: Digital RGB to Digital Visual Interface (DVI) implementation
//
// Author: Jakub Hladik
//
// Change history: 18/10/13 - Early implementation finished.
//
// -----------------------------------------------------------------------------
module tmds_vo (
    input         i_serclk,
    input         i_pxlclk,
    input         i_rstn,
    input         i_hs,
    input         i_vs,
    input         i_de,
    input  [23:0] i_bgr,
    output [ 2:0] o_ser_re,
    output [ 2:0] o_ser_fe
);
  
  // tmds encoders
  wire [9:0] w_encoded_b;
  wire [9:0] w_encoded_g;
  wire [9:0] w_encoded_r;
  
  tmds_encoder encoder_b (
    .i_clk  (i_pxlclk),
    .i_rstn (i_rstn),
    .i_de   (i_de),
    .i_ctrl ({i_vs, i_hs}),
    .i_data (i_bgr[23:16]),
    .o_data (w_encoded_b)
  );
  
  tmds_encoder encoder_g (
    .i_clk  (i_pxlclk),
    .i_rstn (i_rstn),
    .i_de   (i_de),
    .i_ctrl (2'b00),
    .i_data (i_bgr[15:8]),
    .o_data (w_encoded_g)
  );
  
  tmds_encoder encoder_r (
    .i_clk  (i_pxlclk),
    .i_rstn (i_rstn),
    .i_de   (i_de),
    .i_ctrl (2'b00),
    .i_data (i_bgr[7:0]),
    .o_data (w_encoded_r)
  );
  
  
  // tmds serializer
  tmds_serializer tmds_serializer_0 (
    .i_pxlclk (i_pxlclk),
    .i_serclk (i_serclk),
    .i_rstn   (i_rstn),
    .i_enc_b  (w_encoded_b),
    .i_enc_g  (w_encoded_g),
    .i_enc_r  (w_encoded_r),
    .o_ser_re (o_ser_re),
    .o_ser_fe (o_ser_fe)
  );
  
endmodule
