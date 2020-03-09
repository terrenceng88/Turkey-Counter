`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 09:24:04 PM
// Design Name:  
// Module Name: Top_level
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


module Top_level(
    input clkin, 
    input btnL, //left sensor 
    input btnR, //right sensor
    input btnU, //global reset
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
    
    );
    
    wire clk, digsel, qsec; //quarter second
    wire [3:0] rings; //output of ring counter 
    wire [3:0] sel; //output of selector
    wire [15:0] bits; //15 to 12 = time, 11 to 8 = neg, 7 to 0 = turkey count
    wire showTime, showNeg, resetTimer, plus, minus, dummy; 
    wire [7:0] turkeyCount; //current turkey count
    wire [7:0] turkeyInitial; //output of turkey count 
    wire [7:0] turkeyComp; //twos complement of turkey count
    wire [3:0] osecTime; //used to keep track of every 1 second interval
    wire [6:0] segm; //used to determine segment value
    
    lab6_clks slowit (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    state_machine state (.clk(clk), .leftSen(~btnL), .rightSen(~btnR), .Show_time(showTime), .Reset_timer(resetTimer), .plus1(plus), .minus1(minus) );
    
    Count_4b c4b (.clk(clk), .CE(qsec), .R(osecTime[2]), .Q(osecTime[3:0])); //one second counter
    time_counter TimeC (.clk(clk), .CE(osecTime[2]), .R(resetTimer), .Q(bits[15:12]) );   
    
    turkey_counter TurkeyC (.clk(clk), .Up(plus), .Dw(minus), .LD(1'b0), .Din({8{1'b0}}), .Q(turkeyInitial), .UTC(dummy), .DTC(dummy) ); //load isnt used
    twos_comp tcomp (.count(turkeyInitial[7:0]), .s(turkeyComp[7:0])); //gets twos complement to use if negative (2's comp of FFFF is 0001)
    m2_1x8 turCount (.in0(turkeyInitial[7:0]), .in1(turkeyComp[7:0]), .sel(turkeyInitial[7]), .o(turkeyCount[7:0]) ); //determines if negative
    
    assign bits[7] = 1'b0; //turkey counter is a 7 bit number so 8th bit is 0
    assign bits[6:0] = turkeyCount[6:0];
    assign showNeg = turkeyInitial[7];  
    
    RingCounter r4 (.clk(clk), .Advance(digsel), .Q(rings[3:0]));
    Selector s16 (.sel(rings[3:0]) , .N(bits[15:0]), .H(sel[3:0]));
    hex7seg seven (.n3(sel[3]), .n2(sel[2]), .n1(sel[1]), .n0(sel[0]), .a(segm[0]), .b(segm[1]), .c(segm[2]), .d(segm[3]), .e(segm[4]), .f(segm[5]), .g(segm[6]));
    
    assign bits[11:8] = {4{1'b0}}; //inverse of 0 is negative (not used, just placeholder)  
    wire dummy_ns;
    m2_1x8 ns (.in0({1'b0,segm[6:0]}), .in1(8'b00111111), .sel(turkeyInitial[7] & rings[2]), .o({dummy_ns,seg[6:0]}) ); //set segments to negative sign if most significant bit is 1
    
    assign an[3] = ~(rings[3] & showTime); //time
    assign an[2] = ~(rings[2] & showNeg); //negative sign (inverting 0 in hex7seg produces negative sign
    assign an[1] = ~rings[1]; //always on (active low)
    assign an[0] = ~rings[0]; //always on (active low)
    
    assign led[14:10] = {5{1'b0}}; //always off 
    assign led[8:0] = {9{1'b0}}; //always off 
    assign led[15] = ~btnL; //on when button L isnt pressed 
    assign led[9] = ~btnR; //on when button R isnt pressed  
    
endmodule
