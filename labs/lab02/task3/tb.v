// tb.v
// Self-checking testbench for 2-bit magnitude comparator

module tb;

  // Signal declarations
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  // Expected output variables
  reg exp_gt, exp_lt, exp_eq;
  integer i, j;
  integer errors;

  // Instantiate DUT
  comp2 dut_inst (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut_inst);
    end
  end

  // Self-checking stimulus logic
  initial begin
    errors = 0;

    // Test all 16 input combinations (A: 0-3, B: 0-3)
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        // Golden model comparison logic
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        // Check actual output against expected output
        if ((t_gt !== exp_gt) || (t_lt !== exp_lt) || (t_eq !== exp_eq)) begin
          $display("ERROR at time %0t ns: A=%0d, B=%0d | Expected: GT=%b LT=%b EQ=%b | Got: GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, exp_gt, exp_lt, exp_eq, t_gt, t_lt, t_eq);
          errors = errors + 1;
        end
      end
    end

    // Final test reporting
    if (errors == 0) begin
      $display("--------------------------------------------------");
      $display("TEST PASSED: All 16 combinations matched expected outputs!");
      $display("--------------------------------------------------");
    end else begin
      $display("--------------------------------------------------");
      $display("TEST FAILED: Found %0d error(s).", errors);
      $display("--------------------------------------------------");
    end

    $finish;
  end

endmodule