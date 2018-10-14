// -----------------------------------------------------------------------------
// vim:set shiftwidth=2 softtabstop=2 expandtab colorcolumn=80: 
//
// Module: tmds_serializer.v
// Project: OpenFPGA
// Description: 
//   Transition-minimized differential signaling (TMDS) protocol
//   serializer for Digital Visual Interface (DVI).
//   This module takes three 10-bit encoded data inputs and outputs a pair of
//   three serial outputs for each TMDS channel to be connected to 
//   double-data-rate (DDR) register. Both the rising edge and falling edge 
//   data should be sampled at the rising edge of the serial clock by the DDR
//   register input and outputted at their corresponding edges.
//
//                    ____      ____      ____      ____      ____      ____
//   I_SERCLK    ____|    |____|    |____|    |____|    |____|    |____|    |
//
//                   0         0         1_________1_________0         0
//   O_SER_RE    _______________________|                   |_______________
//
//                   0         1_________0         0         0         0
//   O_SER_FE    ______________|         |___________________________________
//
//                             0    0    0    1____1____0    1____0    0    0
//   DDR_OUTPUT  _____________________________|         |____|    |__________
//
// Author: Jakub Hladik
//
// Change history: 18/10/13 - Early implementation finished.
//
// -----------------------------------------------------------------------------
module tmds_serializer(
  input            i_pxlclk, // pixel clock
  input            i_serclk, // serial clock (5x pxlclk)
  input            i_rstn,   // async inv reset
  input      [9:0] i_enc_b,  // encoded blue
  input      [9:0] i_enc_g,  // encoded green
  input      [9:0] i_enc_r,  // encoded red
  output reg [2:0] o_ser_re, // serial outputs rising edge
  output reg [2:0] o_ser_fe  // serial outputs falling edge
);
  
	// register input on pixel clock
  reg [9:0] r_pxlclk_b;
  reg [9:0] r_pxlclk_g;
  reg [9:0] r_pxlclk_r;
  
  always @(posedge i_pxlclk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_pxlclk_b <= 0;
      r_pxlclk_g <= 0;
      r_pxlclk_r <= 0;
    end else begin
      r_pxlclk_b <= i_enc_b;
      r_pxlclk_g <= i_enc_g;
      r_pxlclk_r <= i_enc_r;
    end
  end
  
	// mod 5 counter
  reg [2:0] r_bit_cnt;
	
	// output 10 bits serially at serclk rate
  reg [9:0] r_serclk_b;
  reg [9:0] r_serclk_g;
  reg [9:0] r_serclk_r;
  
  always @(posedge i_serclk, negedge i_rstn) begin
    if (!i_rstn) begin // asynchronous reset
      r_serclk_b <= 0;
      r_serclk_g <= 0;
      r_serclk_r <= 0;
      r_bit_cnt  <= 0;
    end else begin
		  // increment mod 5 counter
      r_bit_cnt <= r_bit_cnt + 1;
      
      // load pxlclk domain register into serclk domain register 
      // when counter reaches four (5th beat)
      if (r_bit_cnt == 4) begin
        r_bit_cnt  <= 0; // mod 5 counter reset
        r_serclk_b <= r_pxlclk_b;
        r_serclk_g <= r_pxlclk_g;
        r_serclk_r <= r_pxlclk_r;
      end
      
			// assign rising edge data (index 0, 2, or 4)
      o_ser_re[0] <= r_serclk_b[{r_bit_cnt, 1'b0}];
      o_ser_re[1] <= r_serclk_g[{r_bit_cnt, 1'b0}];
      o_ser_re[2] <= r_serclk_r[{r_bit_cnt, 1'b0}];
			
			// assign falling edge data (index 1, 3, or 5)
      o_ser_fe[0] <= r_serclk_b[{r_bit_cnt, 1'b0} + 1];
      o_ser_fe[1] <= r_serclk_g[{r_bit_cnt, 1'b0} + 1];
      o_ser_fe[2] <= r_serclk_r[{r_bit_cnt, 1'b0} + 1];
    end
  end
  
endmodule
