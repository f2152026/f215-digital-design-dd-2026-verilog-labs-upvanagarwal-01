// and_beh_intra.v
// Behavioral style AND gate with intra-assignment delay.

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  // Intra-assignment delay: evaluates 'a & b' immediately when triggered,
  // but delays updating 'y' for 5 time units
  always @(*) begin
    y = #5 (a & b);
  end

endmodule