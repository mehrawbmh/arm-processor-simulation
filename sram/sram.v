`timescale 1ns/1ns
module sram(
    clk,
    rst,
    SRAM_DQ,
    SRAM_ADDR,
    SRAM_UB_N,
    SRAM_LB_N,
    SRAM_WE_N,
    SRAM_CE_N,
    SRAM_OE_N
);
  
    inout  [15:0] SRAM_DQ;
    input [17:0] SRAM_ADDR;
    input clk, rst, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
  
    wire [15:0] www;
    reg [15:0] memory [0:63];
    reg [15:0] read_data;
    reg SRAM_WE_reg;
    integer i;
    always@(posedge rst)
    begin
        if (rst) 
        for(i = 0; i <= 63; i = i + 1) begin
            memory[i] = 16'b0;
        end
    end
  
    always@(posedge clk, negedge rst)begin
        if (rst)begin
            read_data <= 0;
            SRAM_WE_reg <= 0;
        end
        else if(~SRAM_WE_N) begin
        memory[SRAM_ADDR] <= SRAM_DQ;
        end 
        
        read_data <= memory[SRAM_ADDR];
        SRAM_WE_reg <= SRAM_WE_N;
        
        
    end


assign  SRAM_DQ = (SRAM_WE_reg==1'b1) ? read_data : 16'bzzzzzzzzzzzzzzzz;
assign  www = (SRAM_WE_reg==1'b1) ? read_data : 16'bzzzzzzzzzzzzzzzz;

endmodule
