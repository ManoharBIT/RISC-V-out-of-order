module ff_valid #(parameter DATA_WIDTH = 32)
(
    input clk,
    input rst,
    input write11_en_i,
    input write12_en_i,
    input write21_en_i,
    input write22_en_i,
    input read11_en_i,
    input read12_en_i,
    input read21_en_i,
    input read22_en_i,
    input [DATA_WIDTH-1:0] data11_i,
    input [DATA_WIDTH-1:0] data12_i,
    input [DATA_WIDTH-1:0] data21_i,
    input [DATA_WIDTH-1:0] data22_i,
    output reg [DATA_WIDTH-1:0] data11_o,
    output reg [DATA_WIDTH-1:0] data12_o,
    output reg [DATA_WIDTH-1:0] data21_o,
    output reg [DATA_WIDTH-1:0] data22_o
);

reg [DATA_WIDTH-1:0] data_tmp;

// 2-ported synchronous write
always @(posedge clk) begin
    if (rst) begin
        data_tmp <= {DATA_WIDTH{1'b1}};
    end else begin
        if (write11_en_i)
            data_tmp <= data11_i;
        else if (write12_en_i)
            data_tmp <= data12_i;
        else if (write21_en_i)
            data_tmp <= data21_i;
        else if (write22_en_i)
            data_tmp <= data22_i;
        else
            data_tmp <= data_tmp;
    end
end

// 4-ported combinational read
always @(*) begin
    data11_o = read11_en_i ? data_tmp : {DATA_WIDTH{1'b0}};
    data12_o = read12_en_i ? data_tmp : {DATA_WIDTH{1'b0}};
    data21_o = read21_en_i ? data_tmp : {DATA_WIDTH{1'b0}};
    data22_o = read22_en_i ? data_tmp : {DATA_WIDTH{1'b0}};
end

endmodule
