module alu_sub #(parameter OPRAND_WIDTH = 32,
                 parameter OP_FUNC_WIDTH = 17,
                 parameter IMM_WIDTH = 12)
(
    input  [OPRAND_WIDTH-1:0] oprand1_i, oprand2_i,
    input  [OP_FUNC_WIDTH-1:0] op_func_i,
    output [OPRAND_WIDTH-1:0] result_o
);

    // Output register
    reg [OPRAND_WIDTH-1:0] result_o;

    // Operation result
    wire res;
    
    // Signed operands
    wire signed [31:0] oprand11_i, oprand12_i;
    assign oprand11_i = oprand1_i;
    assign oprand12_i = oprand2_i;

    reg [OPRAND_WIDTH-1:0] oprand1, oprand2;

    // Opcodes
    parameter [OP_FUNC_WIDTH-1:0]
        BEQ  = 17'bxxxxxxx_000_1100011,
        BNE  = 17'bxxxxxxx_001_1100011,
        BLT  = 17'bxxxxxxx_100_1100011,
        BGE  = 17'bxxxxxxx_101_1100011,
        SB   = 17'bxxxxxxx_000_0100011,
        SH   = 17'bxxxxxxx_001_0100011,
        SW   = 17'bxxxxxxx_010_0100011,

        LB   = 17'bxxxxxxx_000_0000011,
        LH   = 17'bxxxxxxx_001_0000011,
        LW   = 17'bxxxxxxx_010_0000011,
        LBU  = 17'bxxxxxxx_100_0000011,
        LHU  = 17'bxxxxxxx_101_0000011,
        ADDI = 17'bxxxxxxx_000_0010011,
        SLTI = 17'bxxxxxxx_010_0010011,
        XORI = 17'bxxxxxxx_100_0010011,
        ORI  = 17'bxxxxxxx_110_0010011,
        ANDI = 17'bxxxxxxx_111_0010011,
        SLLI = 17'b0000000_001_0010011,
        SRLI = 17'b0000000_101_0010011,
        SRAI = 17'b0100000_101_0010011,

        ADD  = 17'b0000000_000_0110011,
        SUB  = 17'b0100000_000_0110011,
        SLL  = 17'b0000000_001_0110011,
        SLT  = 17'b0000000_010_0110011,
        XOR  = 17'b0000000_100_0110011,
        SRL  = 17'b0000000_101_0110011,
        SRA  = 17'b0100000_101_0110011,
        OR   = 17'b0000000_110_0110011,
        AND  = 17'b0000000_111_0110011,

        JAL  = 17'bxxxxxxx_xxx_1101111,
        JR   = 17'bxxxxxxx_xxx_1100111;

    always @(*) begin
        casez (op_func_i)
            ADD:  result_o = oprand11_i + oprand12_i;
            SUB:  result_o = oprand11_i - oprand12_i;

            SLL, SLLI: result_o = oprand1_i << oprand2_i[4:0];
            SRL, SRLI: result_o = oprand1_i >> oprand2_i[4:0];
            SRA, SRAI: result_o = oprand11_i >>> oprand2_i[4:0];

            SLT: begin
                oprand1 = oprand1_i;
                oprand2 = oprand2_i;
                result_o = {{(OPRAND_WIDTH-1){1'b0}}, res};
            end

            XOR:  result_o = oprand1_i ^ oprand2_i;
            OR:   result_o = oprand1_i | oprand2_i;
            AND:  result_o = oprand1_i & oprand2_i;

            ADDI: result_o = oprand1_i + {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};
            SLTI: begin
                oprand1 = oprand1_i;
                oprand2 = {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};
                result_o = {{(OPRAND_WIDTH-1){1'b0}}, res};
            end
            XORI: result_o = oprand1_i ^ {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};
            ORI:  result_o = oprand1_i | {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};
            ANDI: result_o = oprand1_i & {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};

            LB, LH, LW, LBU, LHU, SH, SB, SW:
                result_o = oprand11_i + {{20{oprand2_i[IMM_WIDTH-1]}}, oprand2_i[IMM_WIDTH-1:0]};

            BEQ: result_o = (oprand1_i == oprand2_i);
            BNE: result_o = (oprand1_i != oprand2_i);
            BLT: begin
                oprand1 = oprand1_i;
                oprand2 = oprand2_i;
                result_o = {{(OPRAND_WIDTH-1){1'b0}}, res};
            end
            BGE: begin
                oprand1 = oprand1_i;
                oprand2 = oprand2_i;
                result_o = {{(OPRAND_WIDTH-1){1'b0}}, ~res};
            end
            JAL: result_o = oprand1_i + 1;
            JR:  result_o = 0;

            default: result_o = 0;
        endcase
    end

    // Instantiate signed comparator
    comparator_signed #( .DATA_WIDTH(OPRAND_WIDTH) ) comp_less (
        .oprand1_i(oprand1),
        .oprand2_i(oprand2),
        .res_o(res)
    );

endmodule
