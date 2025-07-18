module pc_alu #(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] pc_alu_operand1_i,
    input [DATA_WIDTH-1:0] pc_alu_operand2_i,
    output [DATA_WIDTH-1:0] pc_alu_result
);

assign pc_alu_result = pc_alu_operand1_i + pc_alu_operand2_i;

endmodule
