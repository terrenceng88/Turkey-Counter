`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2020 11:52:43 AM
// Design Name: 
// Module Name: top_sim
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


module top_sim();
        reg clkin; 
        reg btnL; //left sensor 
        reg btnR; //right sensor
        reg btnU; //global reset
        wire [15:0] led;
        wire [3:0] an;
        wire [6:0] seg;
           
Top_level UUT(
        .clkin(clkin),
        .btnL(btnL),
        .btnR(btnR),
        .btnU(btnU),
        .led(led),
        .an(an),
        .seg(seg)
);

    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    
    initial    // Clock process for clkin
    begin
        #OFFSET
		  clkin = 1'b1;
        forever
        begin		  
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;		  
        end		  
    end		  
    
    initial
    begin
        //current time is 0ns  
        //-------------------- both sensors blocked (IDLE)
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked
        btnU = 1'b0; 
        
        #1000; //current time is 1000ns
        //-------------------- both sensors blocked (IDLE)
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked
        btnU = 1'b0;
        
        #100; //current time is 1100ns
        //-------------------- both sensors unblocked (IDLE)         
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        //============================================ LEFT ENTER RETURN LEFTS =============================================================
        
        #100; //current time is 1200ns
        //-------------------- enters left (Left1) 0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 1300ns
        //-------------------- leaves left (IDLE) 0
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 1400ns
        //-------------------- enters left (Left1) 0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 1500ns
        //-------------------- in middle (LeftRight) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 1600ns
        //-------------------- leaves right (Left1) 0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 1700ns
        //-------------------- leaves left(IDLE) 0
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked 
        
        #100; //current time is 1800ns
        //-------------------- enters left (Left1)0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 1900ns
        //-------------------- in middle (LeftRight) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 2000ns
        //-------------------- leave left (Right2) 0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 2100ns
        //-------------------- in middle (LeftRight) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 2200ns
        //-------------------- leave right (Left1) 0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 2300ns
        //-------------------- leave left (IDLE) 0
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked
        
        //============================================ RIGHT ENTER RETURN RIGHTS =============================================================
        #100; //current time is 2400ns
        //-------------------- enters right (Right1) 0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 2500ns
        //-------------------- leaves right (IDLE) 0
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 2600ns
        //-------------------- enters right (Right1) 0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 2700ns
        //-------------------- in middle (RightLeft) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 2800ns
        //-------------------- leaves left (Right1) 0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 2900ns
        //-------------------- leaves right(IDLE) 0
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked 
        
        #100; //current time is 3000ns
        //-------------------- enters right (Right1)0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 3100ns
        //-------------------- in middle (RightLeft) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 3200ns
        //-------------------- leave right (Left2) 0
        btnR =1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 3300ns
        //-------------------- in middle (RightLeft) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 3400ns 
        //-------------------- leave left (Right1) 0
        btnR =1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 3500ns
        //-------------------- leave right (IDLE) 0
        btnR =1'b0; //unblocked
        btnL = 1'b0; //unblocked
        
        //============================================ RIGHT TO LEFT CROSSES =============================================================
        
        #100; //current time is 3600ns
        //-------------------- enter right (Right1) 0
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 3700ns
        //-------------------- in middle (RightLeft) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 3800ns
        //-------------------- leave right (Left2) 0
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 3900ns
        //-------------------- leave left (IDLE) 1
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
          
        #100; //current time is 4000ns
        //-------------------- enter right (Right1) 1
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 4100ns
        //-------------------- in middle (RightLeft) 1
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 4200ns
        //-------------------- leave right (Left2) 1
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 4300ns
        //-------------------- leave left (IDLE) 2
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
        
        //============================================ LEFT TO RIGHT CROSSES =============================================================
        
        #100; //current time is 4400ns
        //-------------------- enter left (Left1) 2
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked 
        
        #100; //current time is 4500ns
        //-------------------- in middle (LeftRight) 2
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 4600ns
        //-------------------- leave left (Right2) 2
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 4700ns
        //-------------------- leave left (IDLE) 1
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
         
        #100; //current time is 4800ns
        //-------------------- enter left (Left1) 1
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked 
        
        #100; //current time is 4900ns
        //-------------------- in middle (LeftRight) 1
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 5000ns
        //-------------------- leave left (Right2) 1
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 5100ns
        //-------------------- leave left (IDLE) 0
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
         
        #100; //current time is 5200ns
        //-------------------- enter left (Left1) 0
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked 
        
        #100; //current time is 5300ns
        //-------------------- in middle (LeftRight) 0
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 5400ns
        //-------------------- leave left (Right2) 0
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 5500ns
        //-------------------- leave left (IDLE) -1
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
         
        #100; //current time is 5600ns
        //-------------------- enter left (Left1) -1
        btnR = 1'b0; //unblocked
        btnL = 1'b1; //blocked 
        
        #100; //current time is 5700ns
        //-------------------- in middle (LeftRight) -1
        btnR =1'b1; //blocked
        btnL = 1'b1; //blocked
        
        #100; //current time is 5800ns
        //-------------------- leave left (Right2) -1
        btnR = 1'b1; //blocked
        btnL = 1'b0; //unblocked
        
        #100; //current time is 5900ns
        //-------------------- leave left (IDLE) -2
        btnR = 1'b0; //unblocked
        btnL = 1'b0; //unblocked  
         
        #100; //current time is 6000ns
      
    end

endmodule
