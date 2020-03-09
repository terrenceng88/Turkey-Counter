`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2020 02:42:59 PM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
        input clk, 
        input leftSen, //starts unblocked
        input rightSen, //starts unblocked
        output Show_time, //anode 3 
        output Reset_timer,
        output plus1, //right to left crossing (+1)
        output minus1 //left to right crossing (-1)
    );
    
    wire IDLE; //Q
    wire Left1, LeftRight, Right2; //Q
    wire Right1, RightLeft, Left2; //Q
    
    wire next_IDLE; //D
    wire next_Left1, next_LeftRight, next_Right2; //D
    wire next_Right1, next_RightLeft, next_Left2; //D
    
    assign next_IDLE = IDLE & (rightSen & leftSen) | IDLE & (~rightSen & ~leftSen) | //accounting for both sensor @ same time)
                       Right1 & (rightSen & leftSen) | Left1 & (rightSen & leftSen) | //first presses
                       Right2 & (rightSen & leftSen) | Left2 & (rightSen & leftSen); //finished full crosses
    //Left Side                   
    assign next_Left1 = IDLE & (rightSen & ~leftSen) | Left1 & (rightSen & ~leftSen) | LeftRight & (rightSen & ~leftSen); //enter on left side 
    assign next_LeftRight = Left1 & (~rightSen & ~leftSen) | LeftRight & (~rightSen & ~leftSen) | Right2 & (~rightSen & ~leftSen); //moves left to right blocking both sensors 
    assign next_Right2 = LeftRight & (~rightSen & leftSen) | Right2 & (~rightSen & leftSen); //moves left to right leaving left
    
    //Right Side 
    assign next_Right1 = IDLE & (~rightSen & leftSen) | Right1 & (~rightSen & leftSen) | RightLeft & (~rightSen & leftSen); //enter on righ side 
    assign next_RightLeft = Right1 & (~rightSen & ~leftSen) | RightLeft & (~rightSen & ~leftSen) | Left2 & (~rightSen & ~leftSen); //moves right to left blocking both sensors 
    assign next_Left2 = RightLeft & (rightSen & ~leftSen) | Left2 & (rightSen & ~leftSen); //moves right to left leaving right
    
    FDRE #(.INIT(1'b1)) Q_0FF (.C(clk), .CE(1'b1), .D(next_IDLE), .Q(IDLE) );
    FDRE #(.INIT(1'b0)) Q_1FF (.C(clk), .CE(1'b1), .D(next_Left1), .Q(Left1) );
    FDRE #(.INIT(1'b0)) Q_2FF (.C(clk), .CE(1'b1), .D(next_LeftRight), .Q(LeftRight) );
    FDRE #(.INIT(1'b0)) Q_3FF (.C(clk), .CE(1'b1), .D(next_Right2), .Q(Right2) );
    FDRE #(.INIT(1'b0)) Q_5FF (.C(clk), .CE(1'b1), .D(next_Right1), .Q(Right1) );
    FDRE #(.INIT(1'b0)) Q_6FF (.C(clk), .CE(1'b1), .D(next_RightLeft), .Q(RightLeft) );
    FDRE #(.INIT(1'b0)) Q_7FF (.C(clk), .CE(1'b1), .D(next_Left2), .Q(Left2) );
    
    assign Show_time = ~IDLE; //anode 3
    assign Reset_timer = (IDLE & ~rightSen & leftSen) | (IDLE & rightSen & ~leftSen); 
    assign plus1 = Left2 & rightSen & leftSen; //right to left crossing (+1)
    assign minus1 = Right2 & rightSen & leftSen; //left to right crossing (-1) 
    
endmodule








