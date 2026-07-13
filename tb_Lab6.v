`timescale 1ns / 1ps

module tb_Lab6; // Tên module đã trùng khớp với tên file tb_Lab6.v

    // Inputs
    reg CLK;
    reg KEY0;
    reg KEY1;
    reg KEY2;

    // Outputs
    wire LED0;
    wire LED1;
    wire LED2;
    wire SEG7_DIO;
    wire SEG7_RCLK;
    wire SEG7_SCLK;

    // Gọi module Lab6 (Đã đổi tên theo file chính của bạn)
    // Rút ngắn thời gian đếm xung để chạy mô phỏng nhanh hơn
    Lab6 #(
        .CLK_FREQ(50_000_000),
        .SHOW_TIME(50),       // Giảm xuống 50 xung để test trạng thái hiển thị
        .BLANK_TIME(25),      // Giảm xuống 25 xung để hiển thị khoảng trống
        .DEBOUNCE_MAX(5)      // Khử phím bấm nhanh trong 5 xung để test chức năng
    ) uut (
        .CLK(CLK), 
        .KEY0(KEY0), 
        .KEY1(KEY1), 
        .KEY2(KEY2), 
        .LED0(LED0), 
        .LED1(LED1), 
        .LED2(LED2), 
        .SEG7_DIO(SEG7_DIO), 
        .SEG7_RCLK(SEG7_RCLK), 
        .SEG7_SCLK(SEG7_SCLK)
    );

    // Tạo xung Clock (Tần số 50 MHz tương đương chu kỳ 20ns)
    always #10 CLK = ~CLK;

    initial begin
        // Khởi tạo các giá trị ban đầu (Nút nhấn tích cực mức thấp mặc định là 1)
        CLK = 0;
        KEY0 = 1;
        KEY1 = 1;
        KEY2 = 1;

        // Chờ 100 ns cho hệ thống ổn định
        #100;
        
        // --- Bước 1: Nhấn nút KEY0 để kích hoạt game chuyển từ IDLE sang SHOW ---
        #20;
        KEY0 = 0; // Nhấn xuống
        #200;     // Giữ nút để vượt qua bộ khử nhiễu (Debounce)
        KEY0 = 1; // Nhả nút
        
        // --- Bước 2: Chờ hệ thống nháy LED theo chuỗi mẫu (Mẫu đầu tiên là LED0) ---
        #2000; 

        // --- Bước 3: Người chơi nhấn KEY0 để lặp lại đúng mẫu (Đoán đúng) ---
        KEY0 = 0; 
        #200;     
        KEY0 = 1; 

        // --- Bước 4: Chờ vài chu kỳ để quan sát điểm số tăng lên trên màn hình mô phỏng ---
        #1000;
        
        $display("Simulation Finished successfully.");
        $finish;
    end
      
endmodule
