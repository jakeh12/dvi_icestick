`timescale 1ns / 1ps

module top_tb ();

reg ref_clk;
wire tmds_0_p, tmds_0_n, tmds_1_p, tmds_1_n, tmds_2_p, tmds_2_n, tmds_clk_p, tmds_clk_n;

top uut (
    .ref_clk (ref_clk),
    .tmds_0_p (tmds_0_p),
    .tmds_0_n (tmds_0_n),
    .tmds_1_p (tmds_1_p),
    .tmds_1_n (tmds_1_n),
    .tmds_2_p (tmds_2_p),
    .tmds_2_n (tmds_2_n),
    .tmds_clk_p (tmds_clk_p),
    .tmds_clk_n (tmds_clk_n)
);


    // clk
    always #4 ref_clk = ~ref_clk;
    
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars;
        ref_clk  = 1'b0;
        #100000000 $finish;
    end

endmodule
