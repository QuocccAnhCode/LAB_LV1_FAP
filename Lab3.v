module Lab3 (
    input wire clk,
    input wire rst,
    input wire sw,
    output reg led
);

    reg [1:0] sw_sync;
    always @(posedge clk or negedge rst) begin
        if (rst==1'b0) begin
            sw_sync <= 2'b11;
            led     <= 1'b0;
        end else begin
            sw_sync <= {sw_sync[0], sw};
            if (sw_sync == 2'b01) begin
                led <= ~led; 
            end
        end
    end
endmodule
