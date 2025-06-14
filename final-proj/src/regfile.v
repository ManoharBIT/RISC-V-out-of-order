# Saving the provided SystemVerilog regfile module as a Verilog-style module without interfaces and parameter default expressions
sv_code = '''\
module regfile #(parameter OPRAND_WIDTH = 16,
				 parameter ARRAY_ENTRY = 32,
				 parameter REGNAME_WIDTH = 5)
  (input clk, rst,
   input [REGNAME_WIDTH-1:0] dec_read11_addr, dec_read12_addr, dec_read21_addr, dec_read22_addr,
   input dec_read11_en, dec_read12_en, dec_read21_en, dec_read22_en,
   input [REGNAME_WIDTH-1:0] dec_write1_addr, dec_write2_addr,
   input dec_write1_en, dec_write2_en,
   input [REGNAME_WIDTH-1:0] rob_WB_target1, rob_WB_target2,
   input [OPRAND_WIDTH-1:0] rob_WB_data1, rob_WB_data2,
   input rob_WB_en1, rob_WB_en2,
   output [OPRAND_WIDTH-1:0] rob_read11_data, rob_read12_data, rob_read21_data, rob_read22_data,
   output rob_read11_ready, rob_read12_ready, rob_read21_ready, rob_read22_ready,
   output rob_read11_valid_bit, rob_read12_valid_bit, rob_read21_valid_bit, rob_read22_valid_bit
  );

// internal logic
wire read11_ready_data, read12_ready_data, read21_ready_data, read22_ready_data;
wire read11_ready_valid, read12_ready_valid, read21_ready_valid, read22_ready_valid;

wire [OPRAND_WIDTH-1:0] read11_data, read12_data, read21_data, read22_data;
wire read11_valid_bit, read12_valid_bit, read21_valid_bit, read22_valid_bit;

// RAM modules
ram_4r_2w #(.OPRAND_WIDTH(OPRAND_WIDTH),
            .ARRAY_ENTRY(ARRAY_ENTRY),
            .REGNAME_WIDTH(REGNAME_WIDTH)) data_ram (
    .clk(clk),
    .rst(rst),
    .write1_data_i(rob_WB_data1),
    .write2_data_i(rob_WB_data2),
    .write1_addr_i(rob_WB_target1),
    .write2_addr_i(rob_WB_target2),
    .read11_addr_i(dec_read11_addr),
    .read12_addr_i(dec_read12_addr),
    .read21_addr_i(dec_read21_addr),
    .read22_addr_i(dec_read22_addr),
    .write1_en_i(rob_WB_en1),
    .write2_en_i(rob_WB_en2),
    .read11_en_i(dec_read11_en),
    .read12_en_i(dec_read12_en),
    .read21_en_i(dec_read21_en),
    .read22_en_i(dec_read22_en),
    .read11_data_o(read11_data),
    .read12_data_o(read12_data),
    .read21_data_o(read21_data),
    .read22_data_o(read22_data),
    .read11_ready_o(read11_ready_data),
    .read12_ready_o(read12_ready_data),
    .read21_ready_o(read21_ready_data),
    .read22_ready_o(read22_ready_data)
);

ram_4r_4w #(.OPRAND_WIDTH(1),
            .ARRAY_ENTRY(ARRAY_ENTRY),
            .REGNAME_WIDTH(REGNAME_WIDTH)) valid_ram (
    .clk(clk),
    .rst(rst),
    .write11_data_i(1'b0),
    .write12_data_i(1'b0),
    .write21_data_i(1'b1),
    .write22_data_i(1'b1),
    .write11_addr_i(dec_write1_addr),
    .write12_addr_i(dec_write2_addr),
    .write21_addr_i(rob_WB_target1),
    .write22_addr_i(rob_WB_target2),
    .read11_addr_i(dec_read11_addr),
    .read12_addr_i(dec_read12_addr),
    .read21_addr_i(dec_read21_addr),
    .read22_addr_i(dec_read22_addr),
    .write11_en_i(dec_write1_en),
    .write12_en_i(dec_write2_en),
    .write21_en_i(rob_WB_en1),
    .write22_en_i(rob_WB_en2),
    .read11_en_i(dec_read11_en),
    .read12_en_i(dec_read12_en),
    .read21_en_i(dec_read21_en),
    .read22_en_i(dec_read22_en),
    .read11_data_o(read11_valid_bit),
    .read12_data_o(read12_valid_bit),
    .read21_data_o(read21_valid_bit),
    .read22_data_o(read22_valid_bit),
    .read11_ready_o(read11_ready_valid),
    .read12_ready_o(read12_ready_valid),
    .read21_ready_o(read21_ready_valid),
    .read22_ready_o(read22_ready_valid)
);

// Output assignments
assign rob_read11_ready = read11_ready_data & read11_ready_valid;
assign rob_read12_ready = read12_ready_data & read12_ready_valid;
assign rob_read21_ready = read21_ready_data & read21_ready_valid;
assign rob_read22_ready = read22_ready_data & read22_ready_valid;

assign rob_read11_valid_bit = (rob_WB_target1 == dec_read11_addr && rob_WB_en1) ? 1'b1 :
                              (rob_WB_target2 == dec_read11_addr && rob_WB_en2) ? 1'b1 :
                              read11_valid_bit;

assign rob_read11_data = (rob_WB_target1 == dec_read11_addr && rob_WB_en1) ? rob_WB_data1 :
                         (rob_WB_target2 == dec_read11_addr && rob_WB_en2) ? rob_WB_data2 :
                         read11_data;

assign rob_read12_valid_bit = (rob_WB_target1 == dec_read12_addr && rob_WB_en1) ? 1'b1 :
                              (rob_WB_target2 == dec_read12_addr && rob_WB_en2) ? 1'b1 :
                              read12_valid_bit;

assign rob_read12_data = (rob_WB_target1 == dec_read12_addr && rob_WB_en1) ? rob_WB_data1 :
                         (rob_WB_target2 == dec_read12_addr && rob_WB_en2) ? rob_WB_data2 :
                         read12_data;

assign rob_read21_valid_bit = (dec_write1_addr == dec_read21_addr && dec_write1_en) ? 1'b0 :
                              (rob_WB_target1 == dec_read21_addr && rob_WB_en1) ? 1'b1 :
                              (rob_WB_target2 == dec_read21_addr && rob_WB_en2) ? 1'b1 :
                              read21_valid_bit;

assign rob_read21_data = (dec_write1_addr == dec_read21_addr && dec_write1_en) ? read21_data :
                         (rob_WB_target1 == dec_read21_addr && rob_WB_en1) ? rob_WB_data1 :
                         (rob_WB_target2 == dec_read21_addr && rob_WB_en2) ? rob_WB_data2 :
                         read21_data;

assign rob_read22_valid_bit = (dec_write1_addr == dec_read22_addr && dec_write1_en) ? 1'b0 :
                              (rob_WB_target1 == dec_read22_addr && rob_WB_en1) ? 1'b1 :
                              (rob_WB_target2 == dec_read22_addr && rob_WB_en2) ? 1'b1 :
                              read22_valid_bit;

assign rob_read22_data = (dec_write1_addr == dec_read22_addr && dec_write1_en) ? read22_data :
                         (rob_WB_target1 == dec_read22_addr && rob_WB_en1) ? rob_WB_data1 :
                         (rob_WB_target2 == dec_read22_addr && rob_WB_en2) ? rob_WB_data2 :
                         read22_data;

endmodule
'''

# Write to a .v file
file_path = "/mnt/data/regfile.v"
with open(file_path, "w") as f:
    f.write(sv_code)

file_path
