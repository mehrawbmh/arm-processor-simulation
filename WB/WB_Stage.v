module WB_Stage (
    input clk,
    input rst,
    input [31:0] pcIn,
    output [31:0] pcOut
);
    assign pcOut = pcIn;
endmodule