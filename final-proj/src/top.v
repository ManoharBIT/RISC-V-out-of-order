module top;

   reg clk = 1'b1;  // Clock signal as reg in Verilog

   // Clock generator: toggle clk every 5 time units
   always #5 clk = ~clk;

   // Generate VCD dump file (works with typical Verilog simulators)
   initial begin
      $dumpfile("waveform.vcd"); 
      $dumpvars(0, top);
   end

   // Instantiate the interface signals as wires/reg as needed
   // Since Verilog does not support interfaces, you need to connect signals manually.
   // Here, assuming you have modules named ifc_test, bench, superscalar
   // You have to manually declare signals connecting these modules.

   // Example placeholder signals (adjust based on your design)
   wire rst;
   wire [31:0] instruction1, instruction2;
   wire ins1_valid, ins2_valid;
   // ... other signals that ifc_test, bench, and DUT need

   // Instantiate ifc_test module (assuming clk input and outputs/inputs)
   ifc_test IFC_TEST (
      .clk(clk),
      .rst(rst),
      .instruction1(instruction1),
      .instruction2(instruction2),
      .ins1_valid(ins1_valid),
      .ins2_valid(ins2_valid)
      // connect other ports as needed
   );

   // Instantiate bench module (connect appropriate signals)
   bench BENCH (
      // Connect ports that match the module interface
      // For example, if it requires clock, reset, etc.
      .clk(clk),
      .rst(rst),
      .instruction1(instruction1),
      .instruction2(instruction2),
      .ins1_valid(ins1_valid),
      .ins2_valid(ins2_valid)
      // add other connections as necessary
   );

   // Instantiate superscalar DUT module
   superscalar DUT (
      .clk(clk),
      .rst(rst),
      .instruction1(instruction1),
      .instruction2(instruction2),
      .ins1_valid(ins1_valid),
      .ins2_valid(ins2_valid)
      // connect other signals as per your DUT interface
   );

endmodule
