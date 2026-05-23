`timescale 1ns / 1ps

module tb_Lab4; // Đổi tên module testbench cho đồng bộ với Lab4

    // 1. Khai báo các tín hiệu kết nối với UUT
    reg clk;
    reg rst;
    reg sw;
    wire led;

    // 2. Gọi Module Lab4 (UUT - Unit Under Test)
    // Khớp chính xác với module Lab4 bạn vừa hoàn thiện
    Lab4 uut (
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .led(led)
    );

    // 3. Tạo xung Clock (Chu kỳ 10ns như bài trước bạn làm)
    always #5 clk = ~clk;

    // 4. Kịch bản mô phỏng
    initial begin
        // --- Khởi tạo ban đầu ---
        clk = 0;
        rst = 1;
        sw = 0;
        #20;
        
        rst = 0; // Tắt reset, mạch bắt đầu hoạt động ổn định
        #20;

        // --- MÔ PHỎNG HÀNH VI NHẤN NÚT (Đã tính toán thời gian trễ) ---
        
        // Thao tác 1: Nhấn nút (chuyển từ 0 -> 1)
        sw = 1; 
        #200; // Giữ 100ns (Vì MAX_CNT = 10, chu kỳ 10ns nên mạch cần 100ns để ổn định sw_stable)
        
        // Thao tác 2: Nhả nút (chuyển từ 1 -> 0)
        sw = 0;
        #200; // Giữ 100ns để bộ debounce xác nhận nút đã nhả hoàn toàn
        
        // Thao tác 3: Nhấn lại lần nữa
        sw = 1;
        #200;
        
        // Thao tác 4: Nhả lần nữa
        sw = 0;
        #200;

        $stop; // Tạm dừng để bạn quan sát biểu đồ sóng (Waveform)
    end

endmodule