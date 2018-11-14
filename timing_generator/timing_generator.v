module timing_generator (
    input            i_clk,
    input            i_rstn,
    output reg       o_de,
    output reg       o_hs,
    output reg       o_vs,
    output     [9:0] o_x,
    output     [9:0] o_y
);

  parameter HAC = 640; // horizontal active area pixels
  parameter HFP =  16; // horizontal front porch pixels
  parameter HSP =  96; // horizontal sync pulse pixels
  parameter HBP =  48; // horizontal back porch pixels
  parameter VAC = 480; // vertical active area lines
  parameter VFP =  10; // vertical front porch lines
  parameter VSP =   2; // vertical sync pulse lines
  parameter VBP =  33; // vertical back porch lines
  
  reg [9:0] r_col_cnt;
  reg [9:0] r_row_cnt;
  
  // the timing generator generates timing signals according to this diagram
  //  _____________________________
  // |                             |____________________________________...*o_de
  // .                             .          _____________
  // ________________________________________|             |____________....o_hs
  // .                             .         .             .
  // .                             .         .             .                o_vs
  // .                             .         .             .                 :
  // |<------------HAC------------>|<--HFP-->|<----HSP---->|<---HBP--->|  -  |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |******* ACTIVE AREA *********|         |             |           | VAC |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |*****************************|         |             |           |  |  |
  // |-----------------------------|---------|-------------|-----------|  -  |
  // |                             |         |             |           |  |  |
  // |                             |         |             |           | VFP |
  // |                             |         |             |           |  |  |
  // |-----------------------------|---------|-------------|-----------|  -  --
  // |                             |         |             |           | VSP   |
  // |-----------------------------|---------|-------------|-----------|  -  --
  // |                             |         |             |           |  |  |
  // |                             |         |             |           | VBP |
  // |                             |         |             |           |  |  |
  // |-----------------------------|---------|-------------|-----------|  -  |
  //
  // *o_de stays low during vertical blanking time (outside of VAC)
  
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_col_cnt <= 0;
      r_row_cnt <= 0;
      o_de      <= 0;
      o_hs      <= 0;
      o_vs      <= 0;
    end else begin
      r_col_cnt <= r_col_cnt + 1;
      if (r_col_cnt          == 0      ) begin
        o_de <= 1;
      end else if (r_col_cnt == HAC - 1) begin
        o_de <= 0;
      end else if (r_col_cnt == HAC +
                                HFP - 1) begin
        o_hs <= 1;
      end else if (r_col_cnt == HAC +
                                HFP +
                                HSP - 1) begin
        o_hs <= 0;
      end else if (r_col_cnt == HAC +
                                HFP +
                                HSP +
                                HBP - 1) begin
        r_col_cnt <= 0;
        r_row_cnt <= r_row_cnt + 1;
      end
      if (r_row_cnt             > VAC - 1) begin
        o_de <= 0;
        if (r_row_cnt          == VAC +
                                  VFP - 1) begin
          o_vs <= 1;
        end else if (r_row_cnt == VAC +
                                  VFP +
                                  VSP - 1) begin
          o_vs <= 0;
        end else if (r_row_cnt == VAC +
                                  VFP +
                                  VSP +
                                  VBP - 1) begin
          r_row_cnt <= 0;
        end
      end
    end
  end
  
  // only output x and y when in the active area
  assign o_x = r_col_cnt < HAC ? r_col_cnt : 0;
  assign o_y = r_row_cnt < VAC ? r_row_cnt : 0;
  
endmodule
