module WB_Stage (
    input[31:0] alu_result,mem_read,
    input mem_r_en,
    output [31:0] out
);
    assign out = mem_r_en ? mem_read : alu_result;
endmodule