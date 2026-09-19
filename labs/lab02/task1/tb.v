// tb.v
// Starter testbench template for 2-to-1 MUX

module tb;

  // Signal declarations
  reg  t_i0, t_i1, t_s;
  wire t_y;

  // Instantiate DUT
  DUT dut_inst (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut_inst);
    end
  end

  // Apply all 8 input combinations (5 time units apart)
  initial begin
    t_s = 0; t_i1 = 0; t_i0 = 0; #5;
    t_s = 0; t_i1 = 0; t_i0 = 1; #5;
    t_s = 0; t_i1 = 1; t_i0 = 0; #5;
    t_s = 0; t_i1 = 1; t_i0 = 1; #5;
    t_s = 1; t_i1 = 0; t_i0 = 0; #5;
    t_s = 1; t_i1 = 0; t_i0 = 1; #5;
    t_s = 1; t_i1 = 1; t_i0 = 0; #5;
    t_s = 1; t_i1 = 1; t_i0 = 1; #5;
    $finish;
  end

  // Monitor output
  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule