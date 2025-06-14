module ins_parse #(parameter INS_WIDTH = 32) (
    input ins1_valid_i, ins2_valid_i,
    input [INS_WIDTH-1:0] ins1_i, ins2_i,
    output reg [2:0] ls_type1_o, ls_type2_o,
    output reg ls_valid1_o, ls_valid2_o
);

parameter [16:0] SB = 17'bxxxxxxx0000100011,
                 SH = 17'bxxxxxxx0010100011,
                 SW = 17'bxxxxxxx0100100011,
                 LB = 17'bxxxxxxx0000000011,
                 LH = 17'bxxxxxxx0010000011,
                 LW = 17'bxxxxxxx0100000011;

// Parse instructions
always @(*) begin
    // Default assignments
    ls_valid1_o = 0;
    ls_type1_o = 3'b111;
    ls_valid2_o = 0;
    ls_type2_o = 3'b111;

    if (ins1_valid_i) begin
        casez ({ins1_i[31:25], ins1_i[14:12], ins1_i[6:0]})
            LW: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b000;
            end
            LH: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b001;
            end
            LB: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b010;
            end
            SW: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b100;
            end
            SH: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b101;
            end
            SB: begin
                ls_valid1_o = 1;
                ls_type1_o = 3'b110;
            end
            default: begin
                ls_valid1_o = 0;
                ls_type1_o = 3'b111;
            end
        endcase
    end

    if (ins2_valid_i) begin
        casez ({ins2_i[31:25], ins2_i[14:12], ins2_i[6:0]})
            LW: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b000;
            end
            LH: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b001;
            end
            LB: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b010;
            end
            SW: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b100;
            end
            SH: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b101;
            end
            SB: begin
                ls_valid2_o = 1;
                ls_type2_o = 3'b110;
            end
            default: begin
                ls_valid2_o = 0;
                ls_type2_o = 3'b111;
            end
        endcase
    end
end

endmodule
