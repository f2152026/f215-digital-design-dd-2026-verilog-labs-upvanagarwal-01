// and_beh_before.v
// Behavioral style AND gate with delay BEFORE evaluation.

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  // Delay before assignment: waits 5 time units, THEN evaluates 'a & b'
  always @(*) begin
    #5 y = a & b;
  end

endmodule