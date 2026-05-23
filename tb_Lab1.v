`timescale 1ns / 1ps

module tb_Lab1;

    // 1. Kích thích ngõ vào
    reg [2:0] sw_tb;
    // reg sw1_tb;
    // reg sw2_tb;
    // reg sw3_tb;

    // 2. Ngõ ra theo dõi
    wire [2:0] led_tb;
    // wire led1_tb;
    // wire led2_tb;
    // wire led3_tb;

    // 3. Gọi mạch cần kiểm tra (UUT)
    Lab1 uut (
        .sw(sw_tb),
        .led(led_tb)
        // .sw1(sw1_tb),
        // .sw2(sw2_tb),
        // .sw3(sw3_tb),
        // .led1(led1_tb),
        // .led2(led2_tb),
        // .led3(led3_tb)
    );

    initial begin
    // Trường hợp 1: 000 (led1&led2&led3=OFF)
        sw_tb = 3'b000;
        #10;
        // sw1_tb = 0; sw2_tb = 0; sw3_tb = 0; 
        // #10;

    // Trường hợp 2: 001 (led1=ON;led2&led3=OFF)
        sw_tb = 3'b001;
        #10;
        // sw1_tb = 1; sw2_tb = 0; sw3_tb = 0; 
        // #10;
        
    // Trường hợp 3: 010 (led2=ON;led1&led3=OFF)
        sw_tb = 3'b010;
        #10;
        // sw1_tb = 0; sw2_tb = 1; sw3_tb = 0; 
        // #10;

    // Trường hợp 4: 011 (led3=OFF;led2&led1=ON)
        sw_tb = 3'b011;
        #10;    
        // sw1_tb = 1; sw2_tb = 1; sw3_tb = 0; 
        // #10;

    // Trường hợp 5: 100 (led3=ON;led1&led2=OFF)
        sw_tb = 3'b100;
        #10;  
        // sw1_tb = 0; sw2_tb = 0; sw3_tb = 1; 
        // #10;

    // Trường hợp 6: 101 (led1&led3=ON;led2=OFF)
        sw_tb = 3'b101;
        #10;  
        // sw1_tb = 1; sw2_tb = 0; sw3_tb = 1; 
        // #10;

    // Trường hợp 7: 110 (led2&led3=ON;led1=OFF)
        sw_tb = 3'b110;
        #10;  
        // sw1_tb = 0; sw2_tb = 1; sw3_tb = 1; 
        // #10;

    // Trường hợp 8: 111 (led1&led2&led3=ON)
        sw_tb = 3'b111;
        #10;  
        // sw1_tb = 1; sw2_tb = 1; sw3_tb = 1; 
        // #10;
        $stop;
        //$finish;
    end

endmodule