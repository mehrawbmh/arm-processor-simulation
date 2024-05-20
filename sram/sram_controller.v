module sram_controller(
    input clk,rst
    // from memory
    input wr_en,
    input rd_en,
    input [31:0] address,
    input [31:0] write_data,

    // to next stage
    output [31:0] read_data,

    inout [15:0] SRAM_DQ,
    output [17:0] SRAM_ADDR,
    output SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N
    );

    


endmodule