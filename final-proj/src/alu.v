`include "src/sub_units/alu_sub.v"
`include "src/sub_units/alu_lsq_schedule.v"

module alu #(parameter OPRAND_WIDTH = 32,
             parameter OP_FUNC_WIDTH = 17)
(
    // You need to define the structure of ifc_rob_alu.alu manually in Verilog
    input  [OPRAND_WIDTH-1:0] operand11,
    input  [OPRAND_WIDTH-1:0] operand12,
    input  [OP_FUNC_WIDTH-1:0] op_func1,
    input  [OPRAND_WIDTH-1:0] operand21,
    input  [OPRAND_WIDTH-1:0] operand22,
    input  [OP_FUNC_WIDTH-1:0] op_func2,
    output [OPRAND_WIDTH-1:0] result1,
    output [OPRAND_WIDTH-1:0] result2,
    output [OPRAND_WIDTH-1:0] address_o
);

    wire [OPRAND_WIDTH-1:0] result1_wire;
    wire [OPRAND_WIDTH-1:0] result2_wire;

    assign result1 = result1_wire;
    assign result2 = result2_wire;

    alu_sub #(.OPRAND_WIDTH(OPRAND_WIDTH), .OP_FUNC_WIDTH(OP_FUNC_WIDTH)) alu1 (
        .oprand1_i(operand11),
        .oprand2_i(operand12),
        .op_func_i(op_func1),
        .result_o(result1_wire)
    );

    alu_sub #(.OPRAND_WIDTH(OPRAND_WIDTH), .OP_FUNC_WIDTH(OP_FUNC_WIDTH)) alu2 (
        .oprand1_i(operand21),
        .oprand2_i(operand22),
        .op_func_i(op_func2),
        .result_o(result2_wire)
    );

    alu_lsq_schedule #(.OPRAND_WIDTH(OPRAND_WIDTH), .OP_WIDTH(7)) alu_lsq_schedule_inst (
        .result1_i(result1_wire),
        .result2_i(result2_wire),
        .op_func1_i(op_func1[6:0]),
        .op_func2_i(op_func2[6:0]),
        .address_o(address_o)
    );

endmodule
