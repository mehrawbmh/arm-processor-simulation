module DivideBy2 (
  input  logic clk,
  input  logic rstN,
  output logic clkOut
);

  always @(posedge clk or negedge rstN) begin
    if (!rstN) begin
      clkOut <= 0;
    end
    else begin
      clkOut <= ~clkOut;
    end
  end

endmodule