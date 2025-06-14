module ff_2r_4w #(parameter DATA_WIDTH = 32)
(
    input clk,
    input rst,
    input write11_en_i,
    input write12_en_i,
    input write21_en_i,
    input write22_en_i,
    input read1_en_i,
    input read2_en_i,
    input [DATA_WIDTH-1:0] data11_i,
    input [DATA_WIDTH-1:0] data12_i,
    input [DATA_WIDTH-1:0] data21_i,
    input [DATA_WIDTH-1:0] data22_i,
    output reg [DATA_WIDTH-1:0] data1_o,
    output reg [DATA_WIDTH-1:0] data2_o
);

reg [DATA_WIDTH-1:0] data_tmp;

// 4-way write port (1 at a time), synchronous
always @(posedge clk) begin
    if (rst) begin
        data_tmp <= {DATA_WIDTH{1'b0}};
    end
    else begin
        if (write11_en_i)
            data_tmp <= data11_i;
        else if (write12_en_i)
            data_tmp <= data12_i;
        else if (write21_en_i)
            data_tmp <= data21_i;
        else if (write22_en_i)
            data_tmp <= data22_i;
    end
end

// 2-port read (combinational)
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
