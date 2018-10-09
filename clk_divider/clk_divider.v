module clk_divider (
    input clki,
    output clko
);
    reg [2:0] cnt;
    wire slow_0, slow_90;
    reg toggle_0, toggle_90;

    initial begin
        cnt       = 0;
        toggle_0  = 0;
        toggle_90 = 0;
    end
    
    // mod 5 counter
    always @(posedge clki) begin
        cnt <= (cnt == 4) ? 0 : cnt + 1;
    end

    // mod 5 pulses with 90 degree phase offset
    assign slow_0  = (cnt == 0) ? 1 : 0;
    assign slow_90 = (cnt == 3) ? 1 : 0;

    // toggle_0 on 0 degree mod 5 pulse on positive edge
    always @(posedge clki) begin
        toggle_0 <= (slow_0 == 1) ? ~toggle_0 : toggle_0;
    end

    // toggle_90 on 90 degree mod 5 pulse on falling edge
    always @(negedge clki) begin
        toggle_90 <= (slow_90 == 1) ? ~toggle_90 : toggle_90;
    end
    
    // xor the two toggling waveform to obtain /5 with 50% duty
    assign clko = toggle_0 ^ toggle_90;

endmodule