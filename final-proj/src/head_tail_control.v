module head_tail_control #(parameter INDEX_WIDTH = 5)
(
    input clk, rst,
    input [INDEX_WIDTH-1:0] head_i, tail_i,
    input [1:0] comcnt_i,
    input [INDEX_WIDTH-1:0] tail_branch_jump_i, tail_lsq_flush_i,
    input ins1_valid_i, ins2_valid_i,
    output reg [INDEX_WIDTH-1:0] head_o, tail_o,
    output reg full_o,
    output reg [INDEX_WIDTH-1:0] flush_index_o
);

reg [INDEX_WIDTH:0] full_cnt;
wire [INDEX_WIDTH-1:0] tail_temp1, tail_temp2;
reg [INDEX_WIDTH-1:0] tail_temp3, tail_temp4;

assign tail_temp1 = {INDEX_WIDTH{1'b0}}; // Placeholder
assign tail_temp2 = {INDEX_WIDTH{1'b0}}; // Placeholder

// Compute distances
always @(*) begin
    tail_temp3 = tail_i - tail_temp1;
    tail_temp4 = tail_i - tail_temp2;
end

// Compute flush index
always @(*) begin
    if (tail_temp3 < tail_temp4)
        flush_index_o = tail_temp2;
    else
        flush_index_o = tail_temp1;
end

// Full counter logic
always @(posedge clk) begin
    if (rst)
        full_cnt <= 6'd0;
    else if (ins1_valid_i && ins2_valid_i)
        full_cnt <= full_cnt + 6'd2 - comcnt_i;
    else if (ins1_valid_i || ins2_valid_i)
        full_cnt <= full_cnt + 6'd1 - comcnt_i;
    else
        full_cnt <= full_cnt - comcnt_i;
end

// Set full flag
always @(*) begin
    if (full_cnt >= 6'd29)
        full_o = 1'b1;
    else
        full_o = 1'b0;
end

// Head pointer logic
always @(posedge clk) begin
    if (rst)
        head_o <= 5'd0;
    else if (head_i + comcnt_i > 5'd31)
        head_o <= head_i + comcnt_i - 6'd32;
    else
        head_o <= head_i + comcnt_i;
end

// Tail pointer logic
always @(posedge clk) begin
    if (rst) begin
        tail_o <= 5'd0;
    end else begin
        if (tail_temp3 < tail_temp4) begin
            tail_o <= tail_temp2;
        end else if (tail_temp3 > tail_temp4) begin
            tail_o <= tail_temp1;
        end else if (ins1_valid_i && ins2_valid_i) begin
            if (tail_i + 5'd2 > 5'd31)
                tail_o <= tail_i + 5'd2 - 6'd32;
            else
                tail_o <= tail_i + 5'd2;
        end else if (ins1_valid_i || ins2_valid_i) begin
            if (tail_i + 5'd1 > 5'd31)
                tail_o <= tail_i + 5'd1 - 6'd32;
            else
                tail_o <= tail_i + 5'd1;
        end
    end
end

endmodule
