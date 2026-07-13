module Lab6_Decoder (
    input [3:0] g_score,
    input [1:0] g_stastus,
    output reg [6:0] seg_out
);
always @(*) begin
    if(g_stastus == 2'b01) begin
        seg_out = 7'b0001000;
    end
    else if(g_stastus == 2'b11) begin
        seg_out = 7'b0111000;        
    end
    else begin
        case (g_score)
            4'd0 : seg_out = 7'b1000000;
            4'd1 : seg_out = 7'b1111001;
            4'd2 : seg_out = 7'b0100100;
            4'd3 : seg_out = 7'b0110000;
            4'd4 : seg_out = 7'b0011001;
            4'd5 : seg_out = 7'b0010010;
            4'd6 : seg_out = 7'b0000010;
            4'd7 : seg_out = 7'b1111000;
            default: seg_out = 7'b1111111;
        endcase
    end
end
    
endmodule