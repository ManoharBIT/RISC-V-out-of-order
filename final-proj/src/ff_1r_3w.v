module ff_1r_3w #(parameter DATA_WIDTH = 32)
(
    input clk,
    input rst,
    input write1_en_i,
    input write2_en_i,
    input write3_en_i,
    input read1_en_i,
    input [DATA_WIDTH-1:0] data1_i,
    input [DATA_WIDTH-1:0] data2_i,
    input [DATA_WIDTH-1:0] data3_i,
    output reg [DATA_WIDTH-1:0] data1_o
);

reg [DATA_WIDTH-1:0] data_tmp;

// Synchronous write (priority: write1 > write2 > write3)
always @(posedge clk) begin
    if (rst) begin
        data_tmp <= {DATA_WIDTH{1'b0}};
    end
    else begin
        if (write1_en_i)
            data_tmp <= data1_i;
        else if (write2_en_i)
            data_tmp <= data2_i;
        else if (write3_en_i)
            data_tmp <= data3_i;
    end
end

// Combinational read
always @(*) begin
    if (read1_en_i)
        data1_o = data_tmp;
    else
        data1_o = {DATA_WIDTH{1'b0}};
end

endmodule
