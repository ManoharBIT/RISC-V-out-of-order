interface ifc_rob_dec #(parameter INS=32)();

	logic           ins1_valid;
	logic           ins2_valid;
	logic [INS-1:0] ins1;
	logic [INS-1:0] ins2;
	logic [INS-1:0] PC1;
	logic [INS-1:0] PC2;

	modport dec (
		output ins1_valid, ins1,
		       ins2_valid, ins2,
               PC1, PC2
	);

	modport rob (
		 input ins1_valid, ins1,
		       ins2_valid, ins2,
               PC1, PC2
	);

endinterface
module rob_receiver #(parameter INS = 32)(
    input logic clk,
    input logic rst,

    // Interface instance
    ifc_rob_dec.rob rob_dec_if,

    // Outputs for internal pipeline (for example)
    output logic [INS-1:0] rob_ins1,
    output logic [INS-1:0] rob_ins2,
    output logic [INS-1:0] rob_pc1,
    output logic [INS-1:0] rob_pc2,
    output logic rob_ins1_valid,
    output logic rob_ins2_valid
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rob_ins1        <= 0;
            rob_ins2        <= 0;
            rob_pc1         <= 0;
            rob_pc2         <= 0;
            rob_ins1_valid  <= 0;
            rob_ins2_valid  <= 0;
        end else begin
            rob_ins1        <= rob_dec_if.ins1;
            rob_ins2        <= rob_dec_if.ins2;
            rob_pc1         <= rob_dec_if.PC1;
            rob_pc2         <= rob_dec_if.PC2;
            rob_ins1_valid  <= rob_dec_if.ins1_valid;
            rob_ins2_valid  <= rob_dec_if.ins2_valid;
        end
    end

endmodule
