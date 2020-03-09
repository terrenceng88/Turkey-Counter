`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2020 07:37:34 PM
// Design Name: 
// Module Name: state_sim
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


module state_sim();
        reg clk;
        reg leftSen; //starts unblocked
        reg rightSen; //starts unblocked
        wire Show_time; //anode 3 
        wire Reset_timer;
        wire plus1; //right to left crossing (+1)
        wire minus1; //left to right crossing (-1)
               
state_machine UUT(
        .clk(clk),
        .leftSen(leftSen),
        .rightSen(rightSen),
        .Show_time(Show_time),
        .Reset_timer(Reset_timer),
        .plus1(plus1),
        .minus1(minus1)
);

    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    
    initial    // Clock process for clkin
    begin
        #OFFSET
		  clk = 1'b1;
        forever
        begin		  
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;		  
        end		  
    end		  
    
    initial
    begin
        //current time is 0ns  
        //-------------------- both sensors blocked (IDLE)
        rightSen = 1'b0; //blocked              
        leftSen = 1'b0; //blocked       
        
        #1000; //current time is 1000ns
        //-------------------- both sensors blocked (IDLE)
        rightSen = 1'b0; //blocked              
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1100ns
        //-------------------- both sensors unblocked (IDLE) 
        rightSen = 1'b1; //unblocked
        leftSen = 1'b1; //unblocked
        
        //=====================================LEFT ENTER=========================================
        
        #100; //current time is 1200ns        
        //-------------------- left sensor blocked (Left1)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1300ns    
        //-------------------- left sensor blocked (Left1)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1400ns    
        //-------------------- both sensors blocked (LeftRight)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1500ns     
        //-------------------- both sensors blocked (LeftRight)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1600ns    
        //-------------------- left sensor unblocked (Right2)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 1700ns    
        //-------------------- left sensor unblocked (Right2)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 1800ns    
        //-------------------- both sensors blocked (LeftRight)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 1900ns    
        //-------------------- right sensor unblocked (Left1)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 2000ns    
        //-------------------- both sensors unblocked (IDLE)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 2100ns    
        //-------------------- left sensor blocked (Left1)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 2200ns    
        //-------------------- both sensors blocked (LeftRight)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 2300ns    
        //-------------------- left sensor unblocked (Right2)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 2400ns    
        //-------------------- both sensors unblocked (IDLE)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b1; //unblocked
        
        //===============================RIGHT ENTER====================================
        
        #100; //current time is 2500ns        
        //-------------------- left sensor blocked (Right1)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 2600ns    
        //-------------------- left sensor blocked (Right1)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 2700ns    
        //-------------------- both sensors blocked (RightLeft)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 2800ns     
        //-------------------- both sensors blocked (RightLeft)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 2900ns    
        //-------------------- left sensor unblocked (Left2)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 3000ns    
        //-------------------- left sensor unblocked (Left2)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 3100ns    
        //-------------------- both sensors blocked (RightLeft)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 3200ns    
        //-------------------- right sensor unblocked (Right1)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 33000ns    
        //-------------------- both sensors unblocked (IDLE)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 3400ns    
        //-------------------- left sensor blocked (Right1)
        rightSen = 1'b0; //blocked
        leftSen = 1'b1; //unblocked
        
        #100; //current time is 3500ns    
        //-------------------- both sensors blocked (RightLeft)
        rightSen = 1'b0; //blocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 3600ns    
        //-------------------- left sensor unblocked (Left2)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b0; //blocked
        
        #100; //current time is 3700ns    
        //-------------------- both sensors unblocked (IDLE)
        rightSen = 1'b1; //unblocked
        leftSen = 1'b1; //unblocked   
        
        #100; //current time is 3800ns
      
    end
    
endmodule


		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  