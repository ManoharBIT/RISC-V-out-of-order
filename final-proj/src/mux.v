module mux #(
    parameter WIDTH = 5,      // index bit width
    parameter WID = 32,       // data bit width
    parameter DEPTH = 1 << WIDTH // number of input entries
)(
    input [WIDTH-1:0] index_i,
    input [WID*DEPTH-1:0] data_i, // Flattened input array
    input read_en_i,
    output reg [WID-1:0] data_o,
    output reg read_ready_o
);

integer i;
reg match_found;

always @(*) begin
    data_o = {WID{1'b0}};
    read_ready_o = 0;
    match_found = 0;

    for (i = 0; i < DEPTH; i = i + 1) begin
        if (!match_found && (index_i == i) && read_en_i) begin
            data_o = data_i[i*WID +: WID];
            read_ready_o = 1;
            match_found = 1; // simulate "break"
        end
    end
end

endmodule
