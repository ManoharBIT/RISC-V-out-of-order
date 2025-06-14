// Verilog does not support object-oriented classes natively.
// We need to extract meaningful functionality from SystemVerilog classes into procedural code and module behavior.
// Below is a Verilog-style conversion (limited and simplified) of the SV `transaction` class for a testbench.

`include "ins_definition.v"

module transaction_logic;

   // Internal state variables
   reg [31:0] PC;
   reg [4:0] rec_rd;
   reg [4:0] rec_rs1;
   reg [11:0] rec_imm_12;

   // Function metadata table as ROM
   typedef struct {
      opfmt_t fmt;
      [6:0] bit_op;
      [2:0] bit_f3;
      [6:0] bit_f7;
   } funcmeta_t;

   // Instruction signals
   reg [31:0] instr;
   reg [4:0] rs1, rs2, rd;
   reg [11:0] imm_12;
   reg [19:0] imm_20;
   reg [2:0] func;
   reg [31:0] instr_mem [0:255];

   // State registers
   reg rst;
   reg valid;

   initial begin
      // Initialization
      PC = 0;
      rec_rd = 0;
      rec_rs1 = 0;
      rec_imm_12 = 0;
      rst = 0;
      valid = 0;

      // Sample sequence
      generate_instruction(5'd1, 5'd2, 5'd3, 12'hA0, 20'h10000, 3'd0, 0); // ADD
   end

   task generate_instruction(
      input [4:0] i_rd,
      input [4:0] i_rs1,
      input [4:0] i_rs2,
      input [11:0] i_imm_12,
      input [19:0] i_imm_20,
      input [2:0] i_func,
      input [2:0] i_fmt
   );
      begin
         rd = i_rd;
         rs1 = i_rs1;
         rs2 = i_rs2;
         imm_12 = i_imm_12;
         imm_20 = i_imm_20;
         func = i_func;

         case (i_fmt)
            FMT_R: instr = {7'b0000000, rs2, rs1, 3'b000, rd, 7'b0110011};
            FMT_I: instr = {imm_12, rs1, 3'b000, rd, 7'b0010011};
            FMT_S: instr = {imm_12[11:5], rs2, rs1, 3'b000, imm_12[4:0], 7'b0100011};
            FMT_U: instr = {imm_20, rd, 7'b0110111};
            default: instr = 32'd0;
         endcase

         // Store instruction in memory
         instr_mem[PC] = instr;
         $display("PC %0d: instr = 0x%h", PC, instr);
         PC = PC + 1;
      end
   endtask

endmodule