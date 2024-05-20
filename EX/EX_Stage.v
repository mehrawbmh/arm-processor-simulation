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
    input [1:0] sel_src1, sel_src2,
    input [31:0] EXR_ALU_value, WBR_value,
    output [31:0] alu_result, br_addr,
    output [3:0] status
); 
    wire [31:0] val2, real_val_rm, real_val_rn;
    
    wire [31:0] imm32;
    assign imm32 = sigend_imm_24[23] ? {8'b11111111, sigend_imm_24} : {8'd0, sigend_imm_24};

    assign real_val_rn = (sel_src1 == 2'b01) ? EXR_ALU_value : (sel_src1 == 2'b10) ? WBR_value : val_rn;
    assign real_val_rm = (sel_src1 == 2'b01) ? EXR_ALU_value : (sel_src1 == 2'b10) ? WBR_value : val_rm;
	
    val2_generator valGen(real_val_rm, imm,shift_operand,mem_R_en, mem_W_en, val2);
    ALU alu (real_val_rn, val2, status_reg[1], exe_command, alu_result, status);

    assign br_addr = pc + (imm32 <<< 2);

endmodule
