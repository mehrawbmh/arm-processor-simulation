module status_reg (
    input clk,
    input rst,
    input s,
    input [3:0] status,
    output reg [3:0] out
);

always @(negedge clk, posedge rst) begin
    if (rst) out <= 4'b0000;
    else if (s) out <= status;
end


endmodule