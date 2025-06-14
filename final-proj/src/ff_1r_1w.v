module ff_1r_1w #(parameter DATA_WIDTH = 32)
(
    input clk,
    input rst,
    input write_en_i,
    input read_en_i, 
    input [DATA_WIDTH-1:0] data_i, 
    output reg [DATA_WIDTH-1:0] data_o
);

reg [DATA_WIDTH-1:0] data_tmp;

// 1-ported synchronous write
always @(posedge clk) begin
    if (rst) begin
        data_tmp <= {DATA_WIDTH{1'b0}};
    end
    else begin
        if (write_en_i) begin
            data_tmp <= data_i;
        end
    end
end

// 1-ported read (combinational)
always @(*) begin
    if (read_en_i)
        data_o = data_tmp;
    else
        data_o = {DATA_WIDTH{1'b0}};
end

endmodule
