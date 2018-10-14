module tmds_encoder (
  input            i_clk,
  input            i_rstn,
  input            i_de,
  input      [1:0] i_ctrl,
  input      [7:0] i_data,
  output reg [9:0] o_data
);
  
  // --------------------------------------------------------------------------
  // REGISTER ALL INPUTS
  // --------------------------------------------------------------------------
  reg r_de;
  reg r_ctrl;
  reg r_data;
  
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin  // asynchronous reset
      r_de   <= 0;
      r_ctrl <= 0;
      r_data <= 0;
    end else begin
      r_de   <= i_de;
      r_ctrl <= i_ctrl;
      r_data <= i_data;
    end
  end
  
  // --------------------------------------------------------------------------
  // MINIMIZE TRANSITIONS
  // --------------------------------------------------------------------------
  // prepare xor and xnor encoded data
  wire [7:0] w_data_xor;
  
  assign w_data_xor[0] = r_data[0];
  assign w_data_xor[1] = r_data[1] ^ w_data_xor[0];
  assign w_data_xor[2] = r_data[2] ^ w_data_xor[1];
  assign w_data_xor[3] = r_data[3] ^ w_data_xor[2];
  assign w_data_xor[4] = r_data[4] ^ w_data_xor[3];
  assign w_data_xor[5] = r_data[5] ^ w_data_xor[4];
  assign w_data_xor[6] = r_data[6] ^ w_data_xor[5];
  assign w_data_xor[7] = r_data[7] ^ w_data_xor[6];
  
  wire [7:0] w_data_xnor;
  
  assign w_data_xnor[0] = r_data[0];
  assign w_data_xnor[1] = r_data[1] ^~ w_data_xnor[0];
  assign w_data_xnor[2] = r_data[2] ^~ w_data_xnor[1];
  assign w_data_xnor[3] = r_data[3] ^~ w_data_xnor[2];
  assign w_data_xnor[4] = r_data[4] ^~ w_data_xnor[3];
  assign w_data_xnor[5] = r_data[5] ^~ w_data_xnor[4];
  assign w_data_xnor[6] = r_data[6] ^~ w_data_xnor[5];
  assign w_data_xnor[7] = r_data[7] ^~ w_data_xnor[6];
  
  // count number of set bits on the input data
  wire [3:0] w_data_set_count;
  
  assign w_data_set_count = r_data[0] + 
                            r_data[1] + 
                            r_data[2] + 
                            r_data[3] + 
                            r_data[4] + 
                            r_data[5] + 
                            r_data[6] + 
                            r_data[7];
  
  // decide which encoding results in less transitions
  reg [8:0] r_encoded, r_encoded_inv;
  
  always @* begin
    if (w_data_set_count > 4 ||
       (w_data_set_count == 4 && r_data[0] == 0)) begin
      // if #1s on the input data is greater than 4 or when the #1s is 4 and
      // the first bit is 0, the xnor encoding will result in less transitions
      r_encoded     = {1'b0,  w_data_xnor};
      r_encoded_inv = {1'b0, ~w_data_xnor};
    end else begin
      r_encoded     = {1'b1,  w_data_xor};
      r_encoded_inv = {1'b1, ~w_data_xor};
    end
  end
  
  // --------------------------------------------------------------------------
  // MAINTAIN DC BALANCE
  // --------------------------------------------------------------------------
  // calculate encoded symbol disparity
  // disparity = #1s - #0s
  // there are always 8 bits in a symbol => #0s = 8 - #1s
  // 
  // disparity = #1s - (8 - #1s) 
  //          = 2*#1s - 8 
  //
  // we can downscale the disparity by 2 otherwise the bit 0 
  // would be never used because the result is always even
  //
  // hence,
  //   disparity = #1s - 4
  wire signed [3:0] w_encoded_disparity;
  
  assign w_encoded_disparity = r_encoded[0] + 
                               r_encoded[1] +
                               r_encoded[2] + 
                               r_encoded[3] + 
                               r_encoded[4] + 
                               r_encoded[5] + 
                               r_encoded[6] + 
                               r_encoded[7] + 
                               4'b1100;       // 1100 = -4
  
  
  // decide which symbol to transmit and update disparity
  reg signed [3:0] r_running_disparity;
  
  always @(posedge i_clk, negedge i_rstn) begin
    if (!i_rstn) begin // asynchronous reset
      r_running_disparity <= 0;
    end else if (!r_dena) begin
      // output control data during blanking period
      case (r_ctrl)
        2'b00: o_data <= 10'b1101010100;
        2'b01: o_data <= 10'b0010101011;
        2'b10: o_data <= 10'b0101010100;
        2'b11: o_data <= 10'b1010101011;
      endcase
      // all control symbols have 0 disparity
      r_running_disparity <= 0;
    end else begin
      // decide if transmitting inverted symbol will help
      // achieve dc balance and update disparity
      if (r_running_disparity == 0 || w_encoded_disparity == 0) begin
        // figure out whether to invert to achieve better dc balance
        if (r_encoded[8] == 1) begin
          // no inversion necessary
          o_data              <= {1'b0, r_encoded};
          // r_running_disparity = r_running_disparity 
          //               + disparity_of_symbol_to_be_transmitted
          //
          // disparity_of_symbol_to_be_transmitted = 
          //   = #1_stbt - #0_stbt
          //   = #1s_[9:8]_stbt - #0s_[9:8]_stbt + w_encoded_disparity
          //
          // since bit 9 is always 0 signifying no inversion and bit 8 is
          // always 1 signifying xor encoding,
          //   #1s_[9:8]_stbt - #0s_[9:8]_stbt = 0
          //
          // therefore,
          //   disparity_of_symbol_to_be_transmitted = w_encoded_disparity
          r_running_disparity <= r_running_disparity 
                                 + w_encoded_disparity;
        end else begin
          // transmit inverted symbol
          o_data              <= {1'b1, r_encoded_inv};
          // r_running_disparity = r_running_disparity
          //               + disparity_of_symbol_to_be_transmitted
          //
          // note that w_encoded_inv_disparity = -w_encoded_disparity
          //
          // disparity_of_symbol_to_be_transmitted = 
          //   = #1_stbt - #0_stbt
          //   = #1s_[9:8]_stbt - #0s_[9:8]_stbt - w_encoded_disparity
          //
          // since bit 9 is always 1 signifying inversion and bit 8 is
          // always 0 signifying xnor encoding,
          //   #1s_[9:8]_stbt - #0s_[9:8]_stbt = 0
          //
          // therefore,
          //   disparity_of_symbol_to_be_transmitted = -w_encoded_disparity
          r_running_disparity <= r_running_disparity
                                 - w_encoded_disparity;
        end
      end else begin
        // the conditional below is a simplification for the following:
        //
        // (r_running_disparity > 0 and w_encoded_disparity > 0) or 
        // (r_running_disparity < 0 and w_encoded_disparity < 0)
        //
        // since the q_dispariy is a signed quantity, we can check for the
        // msb bit to see whether the number is negative or positive
        if ((r_running_disparity[3] == 0 && w_encoded_disparity[3] == 0) ||
            (r_running_disparity[3] == 1 && w_encoded_disparity[3] == 1)) begin
          // dc bias would grow futher with the current symbol
          // transmit inverted symbol instead to help achieve dc balance
          o_data              <= {1'b1, r_encoded_inv};
          // r_running_disparity = r_running_disparity
          //                       + disparity_of_symbol_to_be_transmitted
          //
          // note that w_encoded_inv_disparity = -w_encoded_disparity
          //
          // disparity_of_symbol_to_be_transmitted = #1_stbt - #0_stbt
          //   = #1s_[9:8]_stbt - #0s_[9:8]_stbt - w_encoded_disparity
          //
          // since bit 9 is always 1 signifying inversion there are only two
          // possibilities:
          //   bit 9 = 1, bit 8 = 1  ==> #1s_[9:8]_stbt - #0s_[9:8]_stbt = 2
          //   bit 9 = 1, bit 8 = 0  ==> #1s_[9:8]_stbt - #0s_[9:8]_stbt = 0
          //
          // this gives
          //   #1s_[9:8]_stbt - #0s_[9:8]_stbt = r_encoded_inv[8]*2
          //
          // however, since we downscaled the w_encoded_disparity by two to
          // get rid off the unsused bit 0, we need to do the same here
          //
          // therefore,
          //   (#1s_[9:8]_stbt - #0s_[9:8]_stbt)/2 = r_encoded_inv[8]
          r_running_disparity <= r_running_disparity
                                 + r_encoded_inv[8]
                                 - w_encoded_disparity;
        end else begin
          // non-inverted symbol will help achieve dc balance
          // no inversion necessary
          o_data              <= {1'b0, r_encoded};
          // r_running_disparity = r_running_disparity
          //                       + disparity_of_symbol_to_be_transmitted
          //
          // disparity_of_symbol_to_be_transmitted = #1_stbt - #0_stbt
          //   = #1s_[9:8]_stbt - #0s_[9:8]_stbt - w_encoded_disparity
          //
          // since bit 9 is always 0 signifying no inversion there are only
          // two possibilities:
          //   bit 9 = 0, bit 8 = 1  ==> #1s_[9:8]_stbt - #0s_[9:8]_stbt = 0
          //   bit 9 = 0, bit 8 = 0  ==> #1s_[9:8]_stbt - #0s_[9:8]_stbt = -2
          //
          // this gives
          //   #1s_[9:8]_stbt - #0s_[9:8]_stbt = -r_encoded(8)*2
          //
          // however, since we downscaled the enc_q_din_disparity by two to
          // get rid off the unsused bit 0, we need to do the same here
          //
          // therefore,
          //   (#1s_[9:8]_stbt - #0s_[9:8]_stbt)/2 = -r_encoded[8]
          r_running_disparity <= r_running_disparity
                                 - r_encoded[8]
                                 + w_encoded_disparity;
        end
      end
    end
  end
  
endmodule
