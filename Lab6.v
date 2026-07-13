module Lab6 (
    input clk,
    input rst,
    input [2:0] sw,           
    output [2:0] led,         
    output seg_data,
    output seg_latch,
    output seg_clk          
);

    wire [2:0] sw_stable;
    wire timeout;
    wire [7:0] random_val;
    wire [1:0] game_status;
    wire [3:0] score;
    wire time_en;

    Lab6_Debounce u_db1 (.clk(clk), .rst(rst), .sw(sw[0]), .sw_stable(sw_stable[0]));
    Lab6_Debounce u_db2 (.clk(clk), .rst(rst), .sw(sw[1]), .sw_stable(sw_stable[1]));
    Lab6_Debounce u_db3 (.clk(clk), .rst(rst), .sw(sw[2]), .sw_stable(sw_stable[2]));

    Lab6_LFSR u_lfsr (.clk(clk), .rst(rst), .random_result(random_val));

    Lab6_Timer u_timer (.clk(clk), .rst(rst), .en(time_en), .timeout(timeout));

    Lab6_FSM u_fsm (
        .clk(clk),
        .rst(rst),
        .sw1(sw_stable[0]),
        .sw2(sw_stable[1]),
        .sw3(sw_stable[2]),
        .timeout(timeout),
        .random_result(random_val),
        .led(led),
        .time_en(time_en),
        .g_status(game_status),
        .g_score(score)
    );

    Lab6_Decoder u_decoder (
        .clk(clk),
        .rst(rst),
        .g_score(score),
        .g_stastus(game_status),
        .seg_data(seg_data),
        .seg_latch(seg_latch),
        .seg_clk(seg_clk)
    );

endmodule
