module insdec
#(
    parameter PC = 16,
    parameter INS = 32
)
(
    // Interface ifc_dec_rf.dec rf - manually expand these signals
    // Example:
    // output wire [4:0] rf_rs1,
    // output wire [4:0] rf_rs2,
    // input wire [31:0] rf_rd_data,

    // Interface ifc_rob_dec.dec rob - manually expand these signals
    // Example:
    // output wire rob_valid,
    // output wire [3:0] rob_dest,

    input [INS-1:0] instruction1, 
    input           ins1_valid, 
    input [PC-1:0]  PC_in1,
    input [INS-1:0] instruction2,
    input           ins2_valid,
    input [PC-1:0]  PC_in2
);

// Logic will go here
// Use always @(*) or always @(posedge clk) depending on what the module does

endmodule
