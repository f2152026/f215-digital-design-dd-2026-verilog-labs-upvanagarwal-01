// ==========================================
// Top-Level DUT Wrapper
// ==========================================
module DUT (
  input  I0,
  input  I1,
  input  S,
  output Y
);

  // ---- Option 1: Dataflow version ----
  mux_df U1 (
    .I0 (I0),
    .I1 (I1),
    .S  (S),
    .Y  (Y)
  );

  // ---- Option 2: Behavioral version ----
  // To test Option 2, comment out mux_df U1 above and uncomment below:
  // mux_beh U1 (
  //   .I0 (I0),
  //   .I1 (I1),
  //   .S  (S),
  //   .Y  (Y)
  // );

endmodule