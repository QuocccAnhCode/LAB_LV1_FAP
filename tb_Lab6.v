`timescale 1ns / 1ps

module tb_Lab6;

    reg clk;
    reg rst;
    reg [2:0] sw;

    wire [2:0] led;
    wire [6:0] seg;

    Lab6 uut (
        .clk(clk), 
        .rst(rst), 
        .sw(sw), 
        .led(led), 
        .seg(seg)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1'b0;
        sw = 3'b111;

        #100;
        rst = 1'b1;
        
        #2000;
        sw = 3'b110;
        #40;
        sw = 3'b111;
        
        #5000000;
        $finish;
    end

endmodule