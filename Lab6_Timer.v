module Lab6_Timer (
    input clk,
    input rst,
    input en,
    output reg timeout
);
    parameter CNT_MAX = 25_000;
    reg [14:0] cnt;
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0 || !en ) begin
            cnt <= 0;
            timeout <= 0;
        end
        else if(cnt < CNT_MAX) begin
            cnt <= cnt + 1;
            timeout <= 0;
        end
        else begin
            timeout <=1;
        end
    end

endmodule