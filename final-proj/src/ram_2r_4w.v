`include "src/sub_units/ff_2r_4w.v"

module ram_2r_4w #(
    parameter OPRAND_WIDTH = 32,
    parameter ARRAY_ENTRY = 32,
    parameter REGNAME_WIDTH = 5
)(
    input clk, rst,
    input [OPRAND_WIDTH-1:0]  write11_data_i, write12_data_i, write21_data_i, write22_data_i,
    input [REGNAME_WIDTH-1:0] write11_addr_i, write12_addr_i, write21_addr_i, write22_addr_i,
    input [REGNAME_WIDTH-1:0] read1_addr_i, read2_addr_i,
    input write11_en_i, write12_en_i, write21_en_i, write22_en_i,
    input read1_en_i, read2_en_i,
    output [OPRAND_WIDTH-1:0] read1_data_o, read2_data_o,
    output read1_ready_o, read2_ready_o
);

wire [ARRAY_ENTRY-1:0] write11_en;
wire [ARRAY_ENTRY-1:0] write12_en;
wire [ARRAY_ENTRY-1:0] write21_en;
wire [ARRAY_ENTRY-1:0] write22_en;
wire [ARRAY_ENTRY-1:0] read1_en;
wire [ARRAY_ENTRY-1:0] read2_en;

wire [ARRAY_ENTRY-1:0] index_data11_write;
wire [ARRAY_ENTRY-1:0] index_data12_write;
wire [ARRAY_ENTRY-1:0] index_data21_write;
wire [ARRAY_ENTRY-1:0] index_data22_write;
wire [ARRAY_ENTRY-1:0] index_read1;
wire [ARRAY_ENTRY-1:0] index_read2;

wire [OPRAND_WIDTH-1:0] read1_data [0:ARRAY_ENTRY-1];
wire [OPRAND_WIDTH-1:0] read2_data [0:ARRAY_ENTRY-1];

genvar i;
generate
    for (i = 0; i < ARRAY_ENTRY; i = i + 1) begin : gen_mem
        assign write11_en[i] = write11_en_i & index_data11_write[i];
        assign write12_en[i] = write12_en_i & index_data12_write[i];
        assign write21_en[i] = write21_en_i & index_data21_write[i];
        assign write22_en[i] = write22_en_i & index_data22_write[i];
        assign read1_en[i]   = read1_en_i   & index_read1[i];
        assign read2_en[i]   = read2_en_i   & index_read2[i];

        ff_2r_4w #(.DATA_WIDTH(OPRAND_WIDTH)) ff_2r_4w_inst (
            .clk(clk),
            .rst(rst),

            .write11_en_i(write11_en[i]),
            .write12_en_i(write12_en[i]),
            .write21_en_i(write21_en[i]),
            .write22_en_i(write22_en[i]),

            .read1_en_i(read1_en[i]),
            .read2_en_i(read2_en[i]),

            .data11_i(write11_data_i),
            .data12_i(write12_data_i),
            .data21_i(write21_data_i),
            .data22_i(write22_data_i),

            .data1_o(read1_data[i]),
            .data2_o(read2_data[i])
        );
    end
endgenerate

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_data1 (
    .index_i(write11_addr_i),
    .index_depth_o(index_data11_write)
);

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_data2 (
    .index_i(write12_addr_i),
    .index_depth_o(index_data12_write)
);

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_data3 (
    .index_i(write21_addr_i),
    .index_depth_o(index_data21_write)
);

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_data4 (
    .index_i(write22_addr_i),
    .index_depth_o(index_data22_write)
);

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_read1 (
    .index_i(read1_addr_i),
    .index_depth_o(index_read1)
);

decoder #(.WIDTH(REGNAME_WIDTH)) decoder_read2 (
    .index_i(read2_addr_i),
    .index_depth_o(index_read2)
);

mux #(.WIDTH(REGNAME_WIDTH), .WID(OPRAND_WIDTH)) mux_read1_data (
    .index_i(read1_addr_i),
    .data_i(read1_data),
    .read_en_i(read1_en_i),
    .data_o(read1_data_o),
    .read_ready_o(read1_ready_o)
);

mux #(.WIDTH(REGNAME_WIDTH), .WID(OPRAND_WIDTH)) mux_read2_data (
    .index_i(read2_addr_i),
    .data_i(read2_data),
    .read_en_i(read2_en_i),
    .data_o(read2_data_o),
    .read_ready_o(read2_ready_o)
);

endmodule
