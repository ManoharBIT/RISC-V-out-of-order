// Example signal declarations in your top-level module

parameter REGNAME_WIDTH = 5;

// Write interface
wire write1_en;
wire write2_en;
wire [REGNAME_WIDTH-1:0] write1_addr;
wire [REGNAME_WIDTH-1:0] write2_addr;

// Read interface
wire read11_en;
wire read12_en;
wire read21_en;
wire read22_en;
wire [REGNAME_WIDTH-1:0] read11_addr;
wire [REGNAME_WIDTH-1:0] read12_addr;
wire [REGNAME_WIDTH-1:0] read21_addr;
wire [REGNAME_WIDTH-1:0] read22_addr;
decoder u_decoder (
    .write1_en(write1_en),
    .write2_en(write2_en),
    .write1_addr(write1_addr),
    .write2_addr(write2_addr),
    .read11_en(read11_en),
    .read12_en(read12_en),
    .read21_en(read21_en),
    .read22_en(read22_en),
    .read11_addr(read11_addr),
    .read12_addr(read12_addr),
    .read21_addr(read21_addr),
    .read22_addr(read22_addr)
);
register_file u_register_file (
    .write1_en(write1_en),
    .write2_en(write2_en),
    .write1_addr(write1_addr),
    .write2_addr(write2_addr),
    .read11_en(read11_en),
    .read12_en(read12_en),
    .read21_en(read21_en),
    .read22_en(read22_en),
    .read11_addr(read11_addr),
    .read12_addr(read12_addr),
    .read21_addr(read21_addr),
    .read22_addr(read22_addr)
);`
define DEC_RF_IFC \
    input write1_en, write2_en, \
    input [REGNAME_WIDTH-1:0] write1_addr, write2_addr, \
    input read11_en, read12_en, read21_en, read22_en, \
    input [REGNAME_WIDTH-1:0] read11_addr, read12_addr, read21_addr, read22_addr


module decoder (
    `DEC_RF_IFC
);
// logic ...
endmodule


