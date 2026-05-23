`timescale 1ns / 1ps

module tb_Lab2;

    reg sw1_tb;
    reg sw2_tb;
    wire led_tb;

    Lab2 uut (
        .sw1(sw1_tb),
        .sw2(sw2_tb),
        .led(led_tb)
    );

    initial begin
    // Trường hợp 1: sw1=0 sw2=0
        sw1_tb = 0;
        sw2_tb = 0;
        #10;

    // Trường hợp 2: sw1=0 sw2=1
        sw1_tb = 0;
        sw2_tb = 1;
        #10;
        
    // Trường hợp 3: sw1=1 sw2=0
        sw1_tb = 1;
        sw2_tb = 0;
        #10;

    // Trường hợp 4: sw1=1 sw2=1
        sw1_tb = 1;
        sw2_tb = 1;
        #10;
        $stop;
    //   $finish;
    end

endmodule