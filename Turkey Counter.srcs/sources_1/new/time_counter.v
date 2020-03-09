`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2020 02:50:36 PM
// Design Name: 
// Module Name: time_counter
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


module time_counter(
        input clk,
        input CE, //count enable
        input R, //Reset
        output [3:0] Q
    );
    
    wire F; //full time countr (15 seconds)
    
    assign F = Q[3] & Q[2] & Q[1] & Q[0] & 1'b1; //1111 = 15 = F
    
    Count_4b i0 (.clk(clk), .CE(CE & ~F), .R(R), .Q(Q[3:0])); //stops counting past F
    
endmodule
