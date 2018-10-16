module clk_divider (
  input  i_clk,
  input  i_rstn,
  output o_clk
);
  reg [2:0] r_cnt;
  wire      w_slow_0, w_slow_90;
  reg       r_toggle_0, r_toggle_90;
  
  // mod 5 counter
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_cnt <= 0;
    end else begin
      r_cnt <= (r_cnt == 4) ? 0 : r_cnt + 1;
    end
  end
  
  // mod 5 pulses with 90 degree phase offset
  assign w_slow_0  = (r_cnt == 0) ? 1 : 0;
  assign w_slow_90 = (r_cnt == 3) ? 1 : 0;
  
  // toggle_0 on 0 degree mod 5 pulse on positive edge
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_toggle_0 <= 0;
    end else begin
      r_toggle_0 <= (w_slow_0 == 1) ? ~r_toggle_0 : r_toggle_0;
    end
  end
  
  // toggle_90 on 90 degree mod 5 pulse on falling edge
  always @(negedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_toggle_90 <= 0;
    end else begin
      r_toggle_90 <= (w_slow_90 == 1) ? ~r_toggle_90 : r_toggle_90;
    end
  end
  
  // xor the two toggling waveform to obtain /5 with 50% duty
  assign o_clk = r_toggle_0 ^ r_toggle_90;
  
endmodule
