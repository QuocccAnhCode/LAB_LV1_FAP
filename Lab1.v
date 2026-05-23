module Lab1(
    input  wire [2:0] sw,
    output wire [2:0] led
);
    assign led = sw;
endmodule
// module Lab1(
//   input  wire sw1,
//   input  wire sw2,
//   input  wire sw3,
//   output wire led1,
//   output wire led2,
//   output wire led3
// );
//  assign led1 = sw1;
//  assign led2 = sw2;
//  assign led3 = sw3;
//  endmodule