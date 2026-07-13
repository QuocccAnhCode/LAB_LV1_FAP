module Lab6_FSM(
    input clk,
    input rst,
    input sw1, sw2, sw3,
    input timeout,
    input [7:0] random_result,
    output reg [2:0] led,
    output reg time_en,
    output reg [1:0] g_status,
    output reg [3:0] g_score

);

reg [2:0] n_state;
reg [2:0] pattern [0:6];
reg [2:0] current_idx;
reg sw1_last, sw2_last, sw3_last;
parameter   start       = 3'd0,
            patternoff  = 3'd1,
            patternshow = 3'd2,
            waitplayer = 3'd3,
            score_up = 3'd4,
            win = 3'd5,
            lose = 3'd6;




wire sw1_rise = sw1 & ~ sw1_last;
wire sw2_rise = sw2 & ~ sw2_last;
wire sw3_rise = sw3 & ~ sw3_last;
wire any_sw = sw1_rise | sw2_rise | sw3_rise;
wire [2:0] input_user = {sw3_rise, sw2_rise , sw1_rise};
//



always @(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
        n_state <= start;
        led <= 3'b111;
        time_en <= 1'b0;
        g_score <= 4'b0000;
        g_status <= 2'b00;
        sw1_last <= 1'b0;
        sw2_last <= 1'b0;
        sw3_last <= 1'b0;
        current_idx <= 3'b000;
    end else begin
        sw1_last <= sw1;
        sw2_last <= sw2;
        sw3_last <= sw3;
        case (n_state)
            start : begin
                led <= 3'b000;
                g_score <= 4'd0;
                current_idx <= 3'd0;
                g_status <= 2'b00; 

            if(random_result[1:0] == 2'b00) begin
                pattern[0] <= 3'b001;
            end
            else if(random_result[1:0] == 2'b01) begin
                pattern[0] <= 3'b010;
            end
            else begin
                pattern[0] <= 3'b100;
            end
            n_state <= patternoff;
            end
            
            
            
            patternoff : begin
                led <= 3'b000;
                time_en <= 1'b1;
                if(timeout) begin
                    time_en <= 1'b0;
                    n_state <= patternshow;
                end
            end
            
            
            
            patternshow : begin
                led <= pattern[current_idx];
                time_en <= 1'b1;
                if(timeout) begin
                    time_en <= 1'b0;
                    if(current_idx == g_score[2:0]) begin
                        current_idx <= 3'd0;
                        led <= 3'b000;
                        n_state <= waitplayer;
                    end
                    else begin 
                        current_idx <= current_idx + 1;
                        n_state <= patternoff;
                    end
                end
            end 
            
            
            
            waitplayer : begin
                if(any_sw) begin
                    if(input_user == pattern[current_idx]) begin
                        if(current_idx == g_score[2:0]) begin
                            n_state <= score_up;
                        end
                        else begin
                            current_idx <= current_idx + 1;
                        end
                    end
                    else begin
                        n_state <= lose;
                    end
                end
            end
            
            
            
            score_up : begin
                if(g_score < 4'd6) begin
                    g_score <= g_score + 1;
                    current_idx <= 3'd0;
                    if(random_result[1:0] == 2'b00) begin
                        pattern[g_score + 1] <= 3'b001; 
                    end
                    else if(random_result[1:0] == 2'b01) begin
                        pattern[g_score + 1] <= 3'b010;
                    end
                    else begin
                        pattern[g_score + 1] <= 3'b100;
                    end
                    n_state <= patternoff;
                end
                else begin
                    g_score <= 4'd7;
                    n_state <= win;
                end
            end
            
            
            
            win : begin
                g_status <= 2'b01;
            end
            
            
            lose : begin
                g_status <= 2'b11;
            end
            default: n_state <= start;
        endcase
    end
end
    

endmodule