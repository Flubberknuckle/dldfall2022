`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset;
   logic switch;

   logic [63:0] seed, current_iteration;
   assign seed = 64'h0412_6424_0034_3C28;
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   control_logic dut (clk, reset, seed, switch, current_iteration);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("life.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b %h ||\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n %b\n", 
		     reset, seed, current_iteration[7:0], current_iteration[15:8], current_iteration[23:16],
               current_iteration[31:24],current_iteration[39:32],current_iteration[47:40],
               current_iteration[55:48],current_iteration[63:56]);
     end   
   
     initial 
     begin      
	#0  reset = 1'b1;
	#10  reset = 1'b0;
     #10 switch = 1'b1;
     end

endmodule // FSM_tb

