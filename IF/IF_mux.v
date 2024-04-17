module IF_mux(input branch_taken,input [31:0] PC,branch_addr,output [31:0]  pcIn);
    assign pcIn = branch_taken?branch_addr:PC;
endmodule