// and_df.v
// Dataflow style AND gate with inertial continuous assignment delay (#5).

module and_df (
  input  a,
  input  b,
  output y
);

  // Continuous assignment delay: acts as an inertial delay
  assign #5 y = a & b;

endmodule