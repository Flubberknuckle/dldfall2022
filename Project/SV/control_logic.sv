module control_logic(clk, reset, seed, switch, toDataPath);
    logic [63:0] next_iteration, next;
    input logic clk, reset, switch;
    input logic [63:0] seed;
    output logic [63:0] toDataPath;
    
    //mux-specific variables
    logic choice;
    logic [63:0] current_iteration;
    //instantiation
    FSM FSM (clk, reset, switch, next_iteration, current_iteration, choice);
    mux mux(seed, current_iteration, choice, toDataPath);
    datapath iteration (toDataPath, next_iteration);

endmodule

module FSM(clk, reset, switch, next_iteration, current_iteration, decision);
input logic clk, reset, switch;
input logic [63:0] next_iteration;
output logic [63:0] current_iteration;
output logic decision;


typedef enum 	logic {S0, S1} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk)
     if (reset) begin
      state <= S0;
     end
     else begin 
      state <= nextstate;
     end

   // next state logic
   always_comb
     case (state)

       S0: begin
       decision <= 0;
       if (switch) begin nextstate <= S1;
       end
       end

       S1: begin
        decision <=1;
        //current_iteration <= next_iteration;
        nextstate <=S1;
       end

       default: begin
        nextstate <= S0;
       end
     endcase

endmodule



module mux(seed, grid, decision, current_iteration);
    input logic [63:0] seed, grid;
    input logic decision;
    output logic [63:0] current_iteration;

    assign current_iteration=decision==1?seed:grid;

    endmodule