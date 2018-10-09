module tmds_encoder (
    input clk, rstn, dena,
    input [1:0] ctrl,
    input [7:0] din,
    output reg [9:0] dout
);
    
    wire [7:0] din_xor;
    assign din_xor[0] = din[0];
    assign din_xor[1] = din[1] ^ din_xor[0];
    assign din_xor[2] = din[2] ^ din_xor[1];
    assign din_xor[3] = din[3] ^ din_xor[2];
    assign din_xor[4] = din[4] ^ din_xor[3];
    assign din_xor[5] = din[5] ^ din_xor[4];
    assign din_xor[6] = din[6] ^ din_xor[5];
    assign din_xor[7] = din[7] ^ din_xor[6];
    
    wire [7:0] din_xnor;
    assign din_xnor[0] = din[0];
    assign din_xnor[1] = din[1] ^~ din_xnor[0];
    assign din_xnor[2] = din[2] ^~ din_xnor[1];
    assign din_xnor[3] = din[3] ^~ din_xnor[2];
    assign din_xnor[4] = din[4] ^~ din_xnor[3];
    assign din_xnor[5] = din[5] ^~ din_xnor[4];
    assign din_xnor[6] = din[6] ^~ din_xnor[5];
    assign din_xnor[7] = din[7] ^~ din_xnor[6];
    
    wire [3:0] din_ones_cnt;
    assign din_ones_cnt = din[0] + 
                          din[1] + 
                          din[2] + 
                          din[3] + 
                          din[4] + 
                          din[5] + 
                          din[6] + 
                          din[7];
    
    reg signed [3:0] disparity;
    reg [8:0] symbol, symbol_inv;
    wire [3:0] symbol_disparity;
    
    always @* begin
        if (din_ones_cnt > 4 || (din_ones_cnt == 4 && din[0] == 0)) begin
            symbol     = {1'b0,  din_xnor};
            symbol_inv = {1'b0, ~din_xnor};
        end else begin
            symbol     = {1'b1,  din_xor};
            symbol_inv = {1'b1, ~din_xor};
        end
    end
    
    // symbol_disparity = num_ones_symbol[7:0] - num_zeros_symbol[7:0]
    assign symbol_disparity = symbol[0] + 
                              symbol[1] +
                              symbol[2] + 
                              symbol[3] + 
                              symbol[4] + 
                              symbol[5] + 
                              symbol[6] + 
                              symbol[7] + 
                              4'b1100; // 1100 = -4
    
    always @(posedge clk) begin
        if (!rstn) begin
            disparity <= 0;
        end else if (!dena) begin
            disparity <= 0;
            case (ctrl)
                2'b00: dout <= 10'b1101010100;
                2'b01: dout <= 10'b0010101011;
                2'b10: dout <= 10'b0101010100;
                2'b11: dout <= 10'b1010101011;
            endcase
        end else begin
            if (disparity == 0 || symbol_disparity == 0) begin
                if (symbol[8] == 1) begin
                    dout      <= {1'b0, symbol};
                    disparity <= disparity + symbol_disparity;
                end else begin
                    dout      <= {1'b1, symbol_inv};
                    disparity <= disparity - symbol_disparity;
                end
            end else begin
                // (disparity > 0 and symbol_disparity > 0) or (disparity < 0 and symbol_disparity < 0) 
                if ((disparity[3] == 0 && symbol_disparity[3] == 0) || 
                    (disparity[3] == 1 && symbol_disparity[3] == 1)) begin
                    dout      <= {1'b1, symbol_inv};
                    disparity <= disparity + symbol_inv[8] - symbol_disparity;
                end else begin
                    dout      <= {1'b0, symbol};
                    disparity <= disparity - symbol[8] + symbol_disparity;
                end
            end
        end
    end
    
endmodule
