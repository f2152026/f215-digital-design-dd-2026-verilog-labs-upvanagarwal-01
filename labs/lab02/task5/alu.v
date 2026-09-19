// alu.v
// 1-bit-opcode ALU: op=0 -> add, op=1 -> sub. 4-bit operands.

module alu (
  input      [3:0] a,
  input      [3:0] b,
  input             op,      // 0 = add, 1 = sub
  output reg [3:0] result
);

  reg [3:0] b_inv;
  reg [3:0] b_twos;

  // Fix 1: Changed sensitivity list to @(*) to include 'op'
  always @(*) begin
    case (op)
      1'b0: begin
        result = a + b;                 // add
      end
      1'b1: begin
        // Fix 2: Changed non-blocking (<=) to blocking (=) for combinational updates
        b_inv  = ~b;                    // sub, via two's complement
        b_twos = b_inv + 4'b0001;
        result = a + b_twos;
      end
    endcase
  end

endmodule