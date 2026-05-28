module Lab3 (
    input wire clk,
    input wire rst,
    input wire sw,
    output reg led
);

    reg [1:0] sw_sync;
    // Sửa posedge rst thành negedge rst (bắt sườn xuống khi bấm nút reset)
    always @(posedge clk or negedge rst) begin
        if (rst==1'b0) begin // Sửa rst thành !rst (khi nút bị kéo xuống 0)
            sw_sync <= 2'b11; // Nên khởi tạo sw_sync là 2'b11 vì idle của Active-Low là 1
            led     <= 1'b0;
        end else begin
            sw_sync <= {sw_sync[0], sw};
            if (sw_sync == 2'b01) begin
                led <= ~led; 
            end
        end
    end
endmodule
