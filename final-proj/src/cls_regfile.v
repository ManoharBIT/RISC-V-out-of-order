module regfile (
    input wire        clk,
    input wire        rst,
    input wire        write_en,
    input wire [4:0]  write_idx,
    input wire [31:0] write_data,
    input wire        read_en,
    input wire [4:0]  read_idx,
    output reg [31:0] read_data,
    output reg        read_valid
);

    // Register file and validity flags
    reg [31:0] regs [0:31];
    reg        vlds [0:31];

    integer i;

    // Reset logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'd0;
                vlds[i] <= 1'b1;
            end
        end else if (write_en) begin
            regs[write_idx] <= write_data;
            vlds[write_idx] <= 1'b1;
        end
    end

    // Read logic
    always @(posedge clk) begin
        if (read_en) begin
            read_data  <= regs[read_idx];
            read_valid <= vlds[read_idx];
        end else begin
            read_data  <= 32'd0;
            read_valid <= 1'b0;
        end
    end

    // Optional: Print the register file content
    task print_rf;
        begin
            $display("Register File Contents:");
            for (i = 0; i < 32; i = i + 1) begin
                $display("Index: %2d, Data: 0x%08h, Valid: %1b", i, regs[i], vlds[i]);
            end
            $display("\n");
        end
    endtask

endmodule
