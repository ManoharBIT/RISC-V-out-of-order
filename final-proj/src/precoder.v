module precoder #(
    parameter WIDTH = 5,
    parameter DEPTH = 1 << WIDTH
)(
    input  [WIDTH-1:0] head,
    input  [DEPTH-1:0] search_valid_i,
    output [DEPTH-1:0] search_valid_o
);

reg [DEPTH-1:0] search_valid_o;
integer iter;
reg [WIDTH-1:0] i;

always @(*) begin
    for (iter = 0; iter < 32; iter = iter + 1) begin
        i = iter + head;
        search_valid_o[iter] = search_valid_i[i];
    end
end

endmodule
