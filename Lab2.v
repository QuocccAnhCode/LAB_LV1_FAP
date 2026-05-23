module Lab2(
    input wire sw1,
    input wire sw2,
    output wire led
);
    assign led = sw1 & sw2;
endmodule
