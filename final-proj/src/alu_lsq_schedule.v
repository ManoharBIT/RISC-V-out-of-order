module alu_lsq_schedule #(parameter OPRAND_WIDTH = 32,
                          parameter OP_WIDTH = 7)
   (
    input  [OPRAND_WIDTH-1:0] result1_i,
    input  [OPRAND_WIDTH-1:0] result2_i, 
    input  [OP_WIDTH-1:0]     op_func1_i, 
    input  [OP_WIDTH-1:0]     op_func2_i,
    output [OPRAND_WIDTH-1:0] address_o
    );

   // Define STORE and LOAD opcodes
   parameter [OP_WIDTH-1:0] STORE = 7'b0100011;
   parameter [OP_WIDTH-1:0] LOAD  = 7'b0000011;

   reg [OPRAND_WIDTH-1:0] address_reg;
   assign address_o = address_reg;

   always @(*) begin
      if (op_func1_i == STORE || op_func1_i == LOAD)
         address_reg = result1_i;
      else if (op_func2_i == STORE || op_func2_i == LOAD)
         address_reg = result2_i;
      else
         address_reg = {OPRAND_WIDTH{1'b0}};
   end

endmodule
