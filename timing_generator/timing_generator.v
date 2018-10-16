module timing_generator (
    input            i_clk,
    output           i_rstn,
    output reg       o_de,
    output reg       o_hs,
    output reg       o_vs,
    output reg [9:0] o_x,
    output reg [9:0] o_y
);

  parameter ACTIVE_WIDTH_PIX           = 640;
  parameter ACTIVE_HEIGHT_PIX          = 480;
  parameter HORIZONTAL_FRONT_PORCH_PIX =  16;
  parameter HORIZONTAL_SYNC_PULSE_PIX  =  96;
  parameter HORIZONTAL_BACK_PORCH_PIX  =  48;
  parameter VERTICAL_FRONT_PORCH_LINES =  10;
  parameter VERTICAL_SYNC_PULSE_LINES  =   2;
  parameter VERTICAL_BACK_PORTCH_LINES =  33;
  
  reg [9:0] r_col_cnt;
  reg [9:0] r_row_cnt;

  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin
      r_col_cnt <= 0;
      r_row_cnt <= 0;
      o_de      <= 0;
      o_hs      <= 0;
      o_vs      <= 0;
      o_x       <= 0;
      o_y       <= 0;
    end else begin
      r_col_cnt <= r_col_cnt + 1;
      if (r_col_cnt          == HORIZONTAL_FRONT_PORCH_PIX - 1 - 1) begin
        o_hs <= 1;
      end else if (r_col_cnt == HORIZONTAL_FRONT_PORCH_PIX +
                                HORIZONTAL_SYNC_PULSE_PIX  - 1) begin
        o_hs <= 0;
      end else if (r_col_cnt == HORIZONTAL_FRONT_PORCH_PIX +
                                HORIZONTAL_SYNC_PULSE_PIX  +
                                HORIZONTAL_BACK_PORCH_PIX  - 1) begin
        o_de <= 1;
      end else if (r_col_cnt == HORIZONTAL_FRONT_PORCH_PIX +
                                HORIZONTAL_SYNC_PULSE_PIX  +
                                HORIZONTAL_BACK_PORCH_PIX  +
                                ACTIVE_WIDTH_PIX           - 1) begin
        o_de      <= 0;
        r_col_cnt <= 0;
        r_row_cnt <= r_row_cnt + 1;
      end
      if (r_row_cnt             > ACTIVE_HEIGHT_PIX          - 1) begin
        o_de <= 0;
        if (r_row_cnt          == ACTIVE_HEIGHT_PIX          +
                                  VERTICAL_FRONT_PORCH_LINES - 1) begin
          o_vs <= 1;
        end else if (r_row_cnt == ACTIVE_HEIGHT_PIX          +
                                  VERTICAL_FRONT_PORCH_LINES +
                                  VERTICAL_SYNC_PULSE_LINES  - 1) begin
          o_vs <= 0;
        end else if (r_row_cnt == ACTIVE_HEIGHT_PIX          +
                                  VERTICAL_FRONT_PORCH_LINES +
                                  VERTICAL_SYNC_PULSE_LINES  +
                                  VERTICAL_BACK_PORTCH_LINES - 1) begin
          r_row_cnt <= 0;
        end
      end
      
      if (r_col_cnt > (HORIZONTAL_FRONT_PORCH_PIX +
                       HORIZONTAL_SYNC_PULSE_PIX  +
                       HORIZONTAL_BACK_PORCH_PIX  - 1)) begin
        o_x <= r_col_cnt - (HORIZONTAL_FRONT_PORCH_PIX +
                            HORIZONTAL_SYNC_PULSE_PIX  +
                            HORIZONTAL_BACK_PORCH_PIX  - 1);
      end else begin
        o_x <= 0;
      end
      
      if (r_row_cnt < (ACTIVE_HEIGHT_PIX          - 1)) begin
        o_y <= r_row_cnt;
      end else begin
        o_y <= 0;
      end
      
    end
  end
  
endmodule
