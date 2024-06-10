module sram(
input clk,
input rst,
inout [15:0] SRAM_DQ,
input SRAM_WE_N,
input [17:0] SRAM_ADDR
);

reg [15 : 0] sram [2**18 - 1 : 0];
integer i;
always@(posedge clk)begin
if(rst)begin
for(i=0; i<2**18 - 1; i=i+1)begin
    sram[i] <= 16'b0;
end
end

if(~SRAM_WE_N) sram[SRAM_ADDR] <= SRAM_DQ;

end
assign  SRAM_DQ = (SRAM_WE_N) ? sram[SRAM_ADDR] : 16'bzzzzzzzzzzzzzzzz;
endmodule
