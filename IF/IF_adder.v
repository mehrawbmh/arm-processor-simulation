module IF_adder(input clk,rst,input [31:0] pcOut,output reg [31:0] PC);
    assign PC = pcOut + 32'd4;
endmodule
