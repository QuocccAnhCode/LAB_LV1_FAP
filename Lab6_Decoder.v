module Lab6_Decoder (
    input clk,
    input rst,
    input [3:0] g_score,
    input [1:0] g_stastus,
    output reg seg_data,
    output reg seg_latch,
    output reg seg_clk
);

    reg [6:0] seg_parallel;
    always @(*) begin
        if(g_stastus == 2'b01) begin
            seg_parallel = 7'b0001000;
        end
        else if(g_stastus == 2'b11) begin
            seg_parallel = 7'b0111000;        
        end
        else begin
            case (g_score)
                4'd0 : seg_parallel = 7'b1000000;
                4'd1 : seg_parallel = 7'b1111001;
                4'd2 : seg_parallel = 7'b0100100;
                4'd3 : seg_parallel = 7'b0110000;
                4'd4 : seg_parallel = 7'b0011001;
                4'd5 : seg_parallel = 7'b0010010;
                4'd6 : seg_parallel = 7'b0000010;
                4'd7 : seg_parallel = 7'b1111000;
                default: seg_parallel = 7'b1111111;
            endcase
        end
    end

    reg [3:0] bit_cnt;
    reg [6:0] shift_reg;
    reg [15:0] clk_div;
    reg s_clk;

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            clk_div <= 0;
            s_clk <= 0;
        end else begin
            if (clk_div == 16'd25000) begin
                clk_div <= 0;
                s_clk <= ~s_clk;
            end else begin
                clk_div <= clk_div + 1;
            end
        end
    end

    always @(posedge s_clk or negedge rst) begin
        if (rst == 1'b0) begin
            bit_cnt <= 0;
            shift_reg <= 7'b1111111;
            seg_data <= 1;
            seg_latch <= 1;
            seg_clk <= 1;
        end else begin
            if (bit_cnt == 4'd0) begin
                shift_reg <= seg_parallel;
                seg_latch <= 1'b0;
                seg_clk <= 1'b0;
                bit_cnt <= bit_cnt + 1;
            end else if (bit_cnt <= 4'd7) begin
                seg_data <= shift_reg[6];
                shift_reg <= {shift_reg[5:0], 1'b1};
                seg_clk <= 1'b1;
                bit_cnt <= bit_cnt + 1;
            end else if (bit_cnt == 4'd8) begin
                seg_latch <= 1'b1;
                bit_cnt <= 0;
            end
            
            if (bit_cnt > 4'd0 && bit_cnt <= 4'd7 && seg_clk == 1'b1) begin
                seg_clk <= 1'b0;
            end
        end
    end

endmodule
