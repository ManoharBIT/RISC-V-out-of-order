// Verilog equivalent of ifc_test interface
module ifc_test_verilog (
    input clk,
    input rst,

    // Instruction Inputs to DUT
    input [31:0] PC_in1,
    input [31:0] instruction1,
    input        ins1_valid,

    input [31:0] PC_in2,
    input [31:0] instruction2,
    input        ins2_valid,

    // Memory Access
    output       mem_store_en,
    output [1:0] mem_store_type,
    output [31:0] mem_store_addr,
    output [31:0] mem_store_value,

    output       mem_load_en,
    output [1:0] mem_load_type,
    output [31:0] mem_load_addr,
    input  [31:0] mem_load_value,
    input        mem_load_valid,

    // Feedback
    input        ROB_full,
    input  [31:0] jump_PC,
    input        jump_en,
    input  [31:0] branch_PC,
    input        branch_en,
    input  [31:0] flush_PC,
    input        flush_en,

    // Commit Outputs
    input  [4:0]  WB_target1,
    input  [31:0] WB_data1,
    input         WB_en1,

    input  [4:0]  WB_target2,
    input  [31:0] WB_data2,
    input         WB_en2
);
    // This module just groups signals; no behavior here
endmodule
