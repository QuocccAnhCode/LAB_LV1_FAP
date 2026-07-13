module Lab6_Debounce (
    input clk,
    input rst,
    input sw,
    output reg sw_stable    
); 
    parameter CNT_MAX = 500_000;
    reg [23:0] cnt;
    reg sw_last;

    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            cnt <= 0;
            sw_last <= 1'b1;
            sw_stable <= 1'b1;
        end else begin
            if (sw_last != sw) begin
                cnt <= 0;
            end
            else if(cnt < CNT_MAX) begin
                cnt <= cnt + 1;
            end
            else begin
                sw_stable <= sw;
            end
            sw_last <= sw;
        end
    end
endmodule
