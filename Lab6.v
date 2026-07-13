module Lab6 (
    input clk,
    input rst,
    input [2:0] sw,           // 3 công tắc đầu vào
    output [2:0] led,         // 3 đèn LED
    output [6:0] seg          // 7 đoạn hiển thị điểm hoặc trạng thái
);

    // --- Khai báo các dây nối trung gian (wire) ---
    wire [2:0] sw_stable;
    wire timeout;
    wire [7:0] random_val;
    wire [1:0] game_status;
    wire [3:0] score;
    wire time_en;

    // --- 1. Khối xử lý nhiễu nút bấm (Debounce cho 3 nút) ---
    // Cần 3 instance cho 3 nút bấm
    Lab6_Debounce u_db1 (.clk(clk), .rst(rst), .sw(sw[0]), .sw_stable(sw_stable[0]));
    Lab6_Debounce u_db2 (.clk(clk), .rst(rst), .sw(sw[1]), .sw_stable(sw_stable[1]));
    Lab6_Debounce u_db3 (.clk(clk), .rst(rst), .sw(sw[2]), .sw_stable(sw_stable[2]));

    // --- 2. Khối tạo số ngẫu nhiên ---
    Lab6_LFSR u_lfsr (.clk(clk), .rst(rst), .random_result(random_val));

    // --- 3. Khối tạo thời gian nghỉ ---
    Lab6_Timer u_timer (.clk(clk), .rst(rst), .en(time_en), .timeout(timeout));

    // --- 4. Máy trạng thái (FSM) ---
    Lab6_FSM u_fsm (
        .clk(clk),
        .rst(rst),
        .sw1(sw_stable[0]), .sw2(sw_stable[1]), .sw3(sw_stable[2]),
        .timeout(timeout),
        .random_result(random_val),
        .led(led),
        .time_en(time_en),
        .g_status(game_status),
        .g_score(score)
    );

    // --- 5. Khối giải mã hiển thị 7 đoạn ---
    Lab6_Decoder u_decoder (
        .g_score(score),
        .g_stastus(game_status),
        .seg_out(seg)
    );

endmodule
