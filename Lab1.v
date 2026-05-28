module Lab1(
    input  wire [2:0] sw,
    output wire [2:0] led
);
    assign led = ~sw;
endmodule
