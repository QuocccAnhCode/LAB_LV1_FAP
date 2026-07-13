`timescale 1ns / 1ps

module tb_Lab5;

    reg clk;
    reg rst;
    reg [1:0] sw;
    wire [3:0] led;

    Lab5 #( .CNT_MAX(50) ) uut ( 
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .led(led)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        sw  = 2'b11;
        
        #20; 
        rst = 1;
        
        #20;
        sw = 2'b11;
        #600;        
        
        sw = 2'b01;
        #600; 
        
        sw = 2'b10;
        #600; 
        
        sw = 2'b00;
        #600;
        
        $stop;
    end

endmodule
