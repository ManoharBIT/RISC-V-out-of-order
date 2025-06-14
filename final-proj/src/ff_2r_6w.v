module ff_2r_6w #(parameter DATA_WIDTH = 32)
(
    input clk,
    input rst,
    input write1_en_i,
    input write2_en_i,
    input write3_en_i,
    input write4_en_i,
    input write5_en_i,
    input write6_en_i,
    input read1_en_i,
    input read2_en_i,
    input [DATA_WIDTH-1:0] data1_i,
    input [DATA_WIDTH-1:0] data2_i,
    input [DATA_WIDTH-1:0] data3_i,
    input [DATA_WIDTH-1:0] data4_i,
    input [DATA_WIDTH-1:0] data5_i,
    input [DATA_WIDTH-1:0] data6_i,
    output reg [DATA_WIDTH-1:0] data1_o,
    output reg [DATA_WIDTH-1:0] data2_o
);

reg [DATA_WIDTH-1:0] data_tmp;

// Priority-based synchronous write (first valid write wins)
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
        else if (write4_en_i)
            data_tmp <= data4_i;
        else if (write5_en_i)
            data_tmp <= data5_i;
        else if (write6_en_i)
            data_tmp <= data6_i;
    end
end

// Combinational read ports
always @(*) begin
    if (read1_en_i)
        data1_o = data_tmp;
    else
        data1_o = {DATA_WIDTH{1'b0}};

    if (read2_en_i)
        data2_o = data_tmp;
    else
        data2_o = {DATA_WIDTH{1'b0}};
end

endmodule
