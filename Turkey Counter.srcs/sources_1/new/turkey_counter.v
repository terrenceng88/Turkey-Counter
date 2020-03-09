`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2020 09:57:34 PM
// Design Name: 
// Module Name: turkey_counter
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


module turkey_counter(
        input clk,
        input Up, //count enable (increment)
        input Dw, //not count enable (decrement)
        input LD,
        input [7:0] Din, //8 bit counter
        output [7:0] Q,
        output UTC,
        output DTC     
    );

    wire utc[1:0];
    wire dtc[1:0];
    
    countUD4L in0_1 (.clk(clk), .Up(Up & ~Dw), .Dw(Dw & ~Up), .LD(LD), .Din(Din[3:0]), .Q(Q[3:0]), .UTC(utc[0]), .DTC(dtc[0]));
    countUD4L in0_2 (.clk(clk), .Up(Up & ~Dw & utc[0]), .Dw(Dw & ~Up & dtc[0]), .LD(LD), .Din(Din[7:4]), .Q(Q[7:4]), .UTC(utc[1]), .DTC(dtc[1]));
    
    assign UTC = utc[1] & utc[0];
    assign DTC = dtc[1] & dtc[0];
    
endmodule
