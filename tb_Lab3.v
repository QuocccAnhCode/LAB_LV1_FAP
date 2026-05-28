`timescale 1ns / 1ps

module tb_Lab3;

    // 1. Khai báo các tín hiệu
    reg clk;
    reg rst;
    reg sw;
    wire led;

    // 2. Gọi module cần kiểm tra (UUT)
    Lab3 uut (
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .led(led)
    );

    // 3. Tạo xung nhịp (Clock) - Giả sử chu kỳ 10ns
    always #5 clk = ~clk;

    // 4. Khối mô phỏng thao tác nhấn/nhả
    initial begin
        // Khởi tạo ban đầu
        clk = 0;
        rst = 0;
        sw  = 0;
        
        #20 rst = 1; // Tắt reset sau 20ns
        
        #20 sw = 1;
        #50 sw = 0; 
        #50 sw = 1;
        #50 sw = 0
        #50 

        $stop;
    end

endmodule
