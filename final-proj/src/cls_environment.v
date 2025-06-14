`ifndef ENVIRONMENT_V
`define ENVIRONMENT_V

module environment;

   // Configuration Registers
   reg dbg_msg = 0;
   reg ass_chk = 0;
   reg verbose = 0;
   integer cycles = 10000;
   reg auto_config = 0;
   integer random_seed = 0;
   reg data_ctrl = 0;
   reg data_depend = 0;
   reg mem_ctrl = 0;
   reg mem_depend = 0;
   reg auto_mem_data = 1;
   reg preload_mem = 1;
   reg per_check = 0;

   // Densities (real equivalents, use integers in Verilog)
   real d_rst_real = 0.0002;
   real d_noop_real = 0.001;
   real d_op_real = 0.999;
   real d_alu_real = 0.8;
   real d_ls_real = 0.15;
   real d_bj_real = 0.05;

   // Cycles
   integer d_rst_cycle;
   integer d_noop_cycle;
   integer d_op_cycle;
   integer d_alu_cycle;
   integer d_ls_cycle;
   integer d_bj_cycle;

   // Masks
   reg [4:0] m_reg_rd = 5'b11111;
   reg [4:0] m_reg_r1 = 5'b11111;
   reg [4:0] m_reg_r2 = 5'b11111;

   reg [11:0] m_imm_12 = 12'hfff;
   reg [20:0] m_imm_20 = 20'hfffff;

   // Initialize environment
   initial begin
      update_cycles_from_density();

      if (!auto_config)
         $display("Randomization disabled (auto_config = 0)");

      if (data_ctrl && data_depend == 0 &&
          d_noop_cycle == 0 && d_alu_cycle == cycles)
         per_check = 1;
      else
         per_check = 0;

      print_config();
   end

   // Task to update cycles based on real densities
   task update_cycles_from_density;
      begin
         d_op_real = 1.0 - d_noop_real;
         d_alu_real = 1.0 - (d_ls_real + d_bj_real);

         d_rst_cycle  = d_rst_real  * cycles;
         d_noop_cycle = d_noop_real * cycles;
         d_op_cycle   = d_op_real   * cycles;
         d_alu_cycle  = d_alu_real  * cycles;
         d_ls_cycle   = d_ls_real   * cycles;
         d_bj_cycle   = d_bj_real   * cycles;
      end
   endtask

   // Print configuration task
   task print_config;
      begin
         $display("---- Environment Configuration ----");
         $display("debug_msg: %0d", dbg_msg);
         $display("assert_check: %0d", ass_chk);
         $display("verbose: %0d", verbose);
         $display("cycles: %0d", cycles);
         $display("auto_config: %0d", auto_config);
         $display("random_seed: %0d", random_seed);
         $display("data_control: %0d", data_ctrl);
         $display("data_dependency: %0d", data_depend);
         $display("mem_control: %0d", mem_ctrl);
         $display("mem_dependency: %0d", mem_depend);
         $display("auto_memory_data: %0d", auto_mem_data);
         $display("preload_memory: %0d", preload_mem);
         $display("performance_check: %0d", per_check);

         $display("density_reset: %f", d_rst_real);
         $display("density_noop: %f", d_noop_real);
         $display("density_op: %f", d_op_real);
         $display("density_alu: %f", d_alu_real);
         $display("density_ls: %f", d_ls_real);
         $display("density_bj: %f", d_bj_real);

         $display("mask_reg_rd: 0x%h", m_reg_rd);
         $display("mask_reg_r1: 0x%h", m_reg_r1);
         $display("mask_reg_r2: 0x%h", m_reg_r2);
         $display("mask_imm_12: 0x%h", m_imm_12);
         $display("mask_imm_20: 0x%h", m_imm_20);
         $display("------------------------------------");
      end
   endtask

   // Debug task
   task dbg;
      input [1023:0] str;
      if (dbg_msg)
         $display("%t: [dbg] %s", $realtime, str);
   endtask

endmodule

`endif
