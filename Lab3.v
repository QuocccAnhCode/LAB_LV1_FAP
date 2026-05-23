module Lab3 (
    input wire clk,       // Tín hiệu xung nhịp hệ thống
    input wire rst,       // Tín hiệu reset (đưa LED về tắt ban đầu)
    input wire sw,        // Công tắc
    output reg led        // Trạng thái đèn LED
);

    reg [1:0] sw_sync;    // Thanh ghi để phát hiện cạnh (Edge detection)

    // Khối đồng bộ hóa công tắc và phát hiện cạnh
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sw_sync <= 2'b00;
            led     <= 1'b0;
        end else begin
            // Dịch bit để lưu trạng thái cũ và mới của công tắc
            sw_sync <= {sw_sync[0], sw};

            // Nếu sw_sync chuyển từ 1 sang 0 (phát hiện cạnh xuống - vừa nhả nút)
            if (sw_sync == 2'b10) begin
                led <= ~led; // Đảo trạng thái đèn LED
            end
        end
    end

endmodule