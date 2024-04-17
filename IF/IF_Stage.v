module IF_Stage (
    input clk,
    input rst,
    input freeze,
    input branch_taken,
    input [31:0] branch_addr,
    output  [31:0] PC,
    output  [31:0] instruction
);
    wire [31:0] pcOut,pcIn; 
    instruction_Memory aa(pcOut,instruction);
    pc_reg bb(clk,rst,freeze,pcIn,pcOut);
    IF_mux cc(branch_taken,PC,branch_addr,pcIn);
    IF_adder dd(clk,rst,pcOut,PC);
    
endmodule