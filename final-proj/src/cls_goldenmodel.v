module commit_checker (
    input wire clk,
    input wire rst,

    // Inputs from pipeline
    input wire branch_en,
    input wire jump_en,
    input wire flush_en,
    input wire WB_en1,
    input wire WB_en2,
    input wire store_en,
    input wire load_en,

    input wire [4:0] WB_target1,
    input wire [4:0] WB_target2,
    input wire [31:0] WB_data1,
    input wire [31:0] WB_data2,

    input wire [1:0] store_type,
    input wire [31:0] store_addr,
    input wire [31:0] store_value,

    input wire [31:0] branch_target_pc,
    input wire [31:0] jump_target_pc,
    input wire [31:0] ins_pc,

    input wire rob_full
);

    // Parameters for state encoding (e.g., commit type)
    localparam BRANCH = 2'b11;
    localparam JUMP = 2'b11;
    localparam WRITE = 2'b10;
    localparam STORE = 2'b01;

    // Simplified commit structure
    reg [31:0] commit_pc [0:31];
    reg [4:0]  commit_rd [0:31];
    reg [31:0] commit_val [0:31];
    reg [31:0] commit_addr [0:31];
    reg [1:0]  commit_LS [0:31];  // Load/Store: 2'b10 for Load, 2'b01 for Store
    reg [1:0]  commit_JB [0:31];  // Jump/Branch: 2'b11 for Branch/Jump
    integer commit_ptr = 0;

    // Commit logic for writeback, store, jump, and branch
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            commit_ptr <= 0;
        end else begin
            if (WB_en1) begin
                commit_pc[commit_ptr] <= ins_pc;
                commit_rd[commit_ptr] <= WB_target1;
                commit_val[commit_ptr] <= WB_data1;
                commit_LS[commit_ptr] <= 2'b00;
                commit_JB[commit_ptr] <= WRITE;
                commit_ptr <= commit_ptr + 1;
            end

            if (WB_en2) begin
                commit_pc[commit_ptr] <= ins_pc;
                commit_rd[commit_ptr] <= WB_target2;
                commit_val[commit_ptr] <= WB_data2;
                commit_LS[commit_ptr] <= 2'b00;
                commit_JB[commit_ptr] <= WRITE;
                commit_ptr <= commit_ptr + 1;
            end

            if (store_en) begin
                commit_pc[commit_ptr] <= ins_pc;
                commit_rd[commit_ptr] <= 5'd0;
                commit_val[commit_ptr] <= store_value;
                commit_addr[commit_ptr] <= store_addr;
                commit_LS[commit_ptr] <= STORE;
                commit_JB[commit_ptr] <= 2'b00;
                commit_ptr <= commit_ptr + 1;
            end

            if (branch_en) begin
                commit_pc[commit_ptr] <= ins_pc;
                commit_rd[commit_ptr] <= 5'd0;
                commit_val[commit_ptr] <= branch_target_pc;
                commit_LS[commit_ptr] <= 2'b00;
                commit_JB[commit_ptr] <= BRANCH;
                commit_ptr <= commit_ptr + 1;
            end

            if (jump_en) begin
                commit_pc[commit_ptr] <= ins_pc;
                commit_rd[commit_ptr] <= 5'd0;
                commit_val[commit_ptr] <= jump_target_pc;
                commit_LS[commit_ptr] <= 2'b00;
                commit_JB[commit_ptr] <= JUMP;
                commit_ptr <= commit_ptr + 1;
            end
        end
    end

    // Error checking logic (example for branch)
    always @(posedge clk) begin
        if (branch_en) begin
            if (commit_val[commit_ptr - 1] !== branch_target_pc) begin
                $display("[ERROR] Branch target mismatch at PC = %h", ins_pc);
            end
        end

        if (rob_full && commit_ptr < 28) begin
            $display("[ERROR] ROB full but commit_ptr = %d < 28", commit_ptr);
        end

        if (!rob_full && commit_ptr > 30) begin
            $display("[ERROR] ROB not full but commit_ptr = %d > 30", commit_ptr);
        end
    end

endmodule
