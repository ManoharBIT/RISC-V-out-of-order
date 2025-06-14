/**
 * Interface between ROB and LSQ
 * Handles:
 *  - Enqueue from ROB to LSQ
 *  - Issue (address generation)
 *  - Commit signals (load/store)
 *  - Flush handling
 */

interface ifc_rob_lsq #(
    parameter LSQ_INDEX_WIDTH = 5,
    parameter OPRAND_WIDTH    = 32
) ();

    // ========================
    // Enqueue from ROB to LSQ
    // ========================
    logic [2:0] ls_type1;
    logic       ls_valid1;
    logic [LSQ_INDEX_WIDTH-1:0] ls_entry1;

    logic [2:0] ls_type2;
    logic       ls_valid2;
    logic [LSQ_INDEX_WIDTH-1:0] ls_entry2;

    // ========================
    // Issue signals from ROB
    // ========================
    logic [LSQ_INDEX_WIDTH-1:0] addr_entry;
    logic                       addr_valid;
    logic [OPRAND_WIDTH-1:0]    store_data;

    // ========================
    // Commit signals from LSQ
    // ========================
    logic                       load_commit_valid;
    logic [LSQ_INDEX_WIDTH-1:0] load_commit_entry;
    logic [OPRAND_WIDTH-1:0]    load_data;

    logic                       store_commit_valid;
    logic [LSQ_INDEX_WIDTH-1:0] store_commit_entry;

    // ===============
    // Flush handling
    // ===============
    logic                       flush_valid;
    logic [LSQ_INDEX_WIDTH-1:0] flush_entry;

    // ========================
    // Modports
    // ========================

    modport rob (
        output ls_type1, ls_valid1, ls_type2, ls_valid2,
               addr_entry, addr_valid, store_data,
               load_commit_entry, load_commit_valid,
               store_commit_entry, store_commit_valid,
        input  ls_entry1, ls_entry2, load_data,
               flush_valid, flush_entry
    );

    modport lsq (
        input  ls_type1, ls_valid1, ls_type2, ls_valid2,
               addr_entry, addr_valid, store_data,
               load_commit_entry, load_commit_valid,
               store_commit_entry, store_commit_valid,
        output ls_entry1, ls_entry2, load_data,
               flush_valid, flush_entry
    );

endinterface

module rob_module (
    input logic clk,
    input logic rst,
    ifc_rob_lsq.rob rob_lsq_if
);
// Access signals like: rob_lsq_if.ls_valid1, rob_lsq_if.addr_entry, etc.
endmodule
module lsq_module (
    input logic clk,
    input logic rst,
    ifc_rob_lsq.lsq rob_lsq_if
);
// Access signals like: rob_lsq_if.ls_type1, rob_lsq_if.flush_valid, etc.
endmodule

