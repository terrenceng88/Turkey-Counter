`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 02:28:22 AM
// Design Name: 
// Module Name: twos_comp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module twos_comp( 
        input [7:0] count, //current counter value
        output [7:0] s //sum (8th bit determines pos/neg)
    );
    wire [7:0] w;
    wire dummy; 
    
    //get 2's complement by inverting and adding 1
    full_adder f0 (.a(~count[0]), .b(1'b1), .Cin(1'b0), .Cout(w[0]), .Sum(s[0]));
    full_adder f1 (.a(~count[1]), .b(1'b0), .Cin(w[0]), .Cout(w[1]), .Sum(s[1]));
    full_adder f2 (.a(~count[2]), .b(1'b0), .Cin(w[1]), .Cout(w[2]), .Sum(s[2]));
    full_adder f3 (.a(~count[3]), .b(1'b0), .Cin(w[2]), .Cout(w[3]), .Sum(s[3]));
    full_adder f4 (.a(~count[4]), .b(1'b0), .Cin(w[3]), .Cout(w[4]), .Sum(s[4]));
    full_adder f5 (.a(~count[5]), .b(1'b0), .Cin(w[4]), .Cout(w[5]), .Sum(s[5]));
    full_adder f6 (.a(~count[6]), .b(1'b0), .Cin(w[5]), .Cout(w[6]), .Sum(s[6]));
    full_adder f7 (.a(~count[7]), .b(1'b0), .Cin(w[6]), .Cout(dummy), .Sum(s[7]));
    //ignore last cout because can't support 9 bit output
    
endmodule
