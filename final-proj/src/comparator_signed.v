module comparator_signed #(parameter DATA_WIDTH = 32) 
(
    input  [DATA_WIDTH-1:0] oprand1_i,
    input  [DATA_WIDTH-1:0] oprand2_i,
    output reg              res_o // Set to 1 if oprand1_i < oprand2_i (signed), else 0
);

always @(*) begin
    if (oprand1_i[DATA_WIDTH-1] < oprand2_i[DATA_WIDTH-1]) begin
        // oprand1 is positive, oprand2 is negative => oprand1 > oprand2
        res_o = 1'b0;
    end else if (oprand1_i[DATA_WIDTH-1] > oprand2_i[DATA_WIDTH-1]) begin
        // oprand1 is negative, oprand2 is positive => oprand1 < oprand2
        res_o = 1'b1;
    end else begin
        // Both have same sign, compare remaining bits
        if (oprand1_i[DATA_WIDTH-2:0] < oprand2_i[DATA_WIDTH-2:0]) begin
            res_o = 1'b1;
        end else begin
            res_o = 1'b0;
        end
    end
end

endmodule
