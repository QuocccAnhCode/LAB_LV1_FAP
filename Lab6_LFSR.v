module Lab6_LFSR (
    input clk,
    input rst,
    output reg [7:0] random_result
);
parameter seed = 8'hAA;
always @(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
        random_result <= seed;
    end
    else begin
        random_result <= {random_result[7] ^ random_result[5] ^ random_result[4] ^ random_result[3], random_result[7:1]};
    end
end
    
endmodule