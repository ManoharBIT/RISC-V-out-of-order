module decoder #(parameter WIDTH = 5, // index bit width
                 parameter DEPTH = (1 << WIDTH)) // number of outputs
(
    input  [WIDTH-1:0] index_i,
    output reg [DEPTH-1:0] index_depth_o
);

integer i;

always @(*) begin
    index_depth_o = {DEPTH{1'b0}}; // Clear all outputs first
    for (i = 0; i < DEPTH; i = i + 1) begin
        if (index_i == i)
            index_depth_o[i] = 1'b1;
    end
end

endmodule


