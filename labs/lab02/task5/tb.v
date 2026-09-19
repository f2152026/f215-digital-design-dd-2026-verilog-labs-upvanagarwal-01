// tb.v
// Self-checking testbench for 4-bit ALU

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer i, j;
  integer errors;

  // Instantiate DUT
  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;

    // Test 1: Check op sensitivity (changing op while a, b remain constant)
    t_a = 4'd7;
    t_b = 4'd3;
    t_op = 1'b0; // Expected ADD: 7 + 3 = 10
    #5;
    if (t_result !== 4'd10) begin
      $display("ERROR [Sensitivity-ADD]: A=%d B=%d op=%b | Exp=10, Got=%d", t_a, t_b, t_op, t_result);
      errors = errors + 1;
    end

    t_op = 1'b1; // Expected SUB: 7 - 3 = 4 (Tests if op change triggers logic)
    #5;
    if (t_result !== 4'd4) begin
      $display("ERROR [Sensitivity-SUB]: A=%d B=%d op=%b | Exp=4, Got=%d", t_a, t_b, t_op, t_result);
      errors = errors + 1;
    end

    // Test 2: Exhaustive testing of all operand combinations
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i;
        t_b = j;

        // Check addition
        t_op = 1'b0;
        exp_result = t_a + t_b;
        #5;
        if (t_result !== exp_result) begin
          $display("ERROR [ADD]: A=%d B=%d | Exp=%d, Got=%d", t_a, t_b, exp_result, t_result);
          errors = errors + 1;
        end

        // Check subtraction
        t_op = 1'b1;
        exp_result = t_a - t_b;
        #5;
        if (t_result !== exp_result) begin
          $display("ERROR [SUB]: A=%d B=%d | Exp=%d, Got=%d", t_a, t_b, exp_result, t_result);
          errors = errors + 1;
        end
      end
    end

    // Final Reporting
    if (errors == 0) begin
      $display("--------------------------------------------------");
      $display("TEST PASSED: All ALU test cases passed!");
      $display("--------------------------------------------------");
    end else begin
      $display("--------------------------------------------------");
      $display("TEST FAILED: Total errors found: %0d", errors);
      $display("--------------------------------------------------");
    end

    $finish;
  end

  initial
    $monitor($time, " a=%d b=%d op=%b | result=%d", t_a, t_b, t_op, t_result);

endmodule