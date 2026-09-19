// tb.v
// Testbench for parameterized LUT module

module tb;

  parameter WIDTH = 8;
  parameter DEPTH = 4;

  // Signal declarations
  reg  [$clog2(DEPTH)-1:0] t_sel;
  wire [WIDTH-1:0]         t_dout;

  integer i;

  // Instantiate DUT
  lut #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Apply inputs across all address lines
  initial begin
    t_sel = 0;
    #5;

    for (i = 0; i < DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
    end

    $finish;
  end

  // Monitor output
  initial
    $monitor($time, " sel = %d | dout = %d (0x%h)", t_sel, t_dout, t_dout);

endmodule