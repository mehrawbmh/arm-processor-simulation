module EX_Stage (
    input clk,
    input rst,
    input [3:0] exe_command,
    input mem_R_en,
    input mem_W_en,
    input [31:0] pc,
    input [31:0] val_rn,
    input [31:0] val_rm,
    input imm,
    input [11:0] shift_operand,
    input [23:0] sigend_imm_24,
    input [3:0] status_reg,
    output [31:0] alu_result, br_addr,
    output [3:0] status
); 
    wire [31:0] val2;
    
    wire [31:0] imm32;
    assign imm32 = sigend_imm_24[23] ? {8'b1, sigend_imm_24} : {8'd0, sigend_imm_24};

    val2_generator valGen(val_rm, imm,shift_operand,mem_R_en, mem_W_en, val2);
    ALU alu (val_rn, val2, status_reg[1], exe_command, alu_result, status);

    assign br_addr = pc + (imm32 <<< 2);

endmodule
