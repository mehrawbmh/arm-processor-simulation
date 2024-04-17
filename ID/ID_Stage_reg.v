module ID_stage_reg(
    input clk, rst, flush,
    input wb_en_in, mem_r_en_in, mem_w_en_in,B_in,S_in,
    input [31:0] PC_in,
    input [3:0] exe_cmd_in,
    input [31:0] Val_Rn_in, Val_Rm_in,
    input imm_in,
    input [11:0] shit_operand_in,
    input [23:0] signed_imm_24_in,
    input [3:0] Dest_in,
    

    output reg wb_en, mem_r_en, mem_w_en,B,S,
    output reg [31:0] PC,
    output reg [3:0] exe_cmd,
    output reg [31:0] Val_Rn, Val_Rm,
    output reg imm,
    output reg [11:0] shift_operand,
    output reg [23:0] signed_imm_24,
    output reg [3:0] Dest
  );

    always@(posedge clk)begin
        if(rst || flush)begin
            wb_en <= 0;
            mem_r_en <= 0;
            mem_w_en <= 0;
            B <= 0;
            S <= 0;
            PC <= 32'd0;
            exe_cmd <= 4'd0;
            Val_Rn <= 32'd0;
            Val_Rm <= 32'd0;
            imm <= 0;
            shift_operand <= 12'd0;
            signed_imm_24 <= 24'd0;
            Dest <= 4'd0;
            
        end

        else begin
            wb_en <= wb_en_in;
            mem_r_en <= mem_r_en_in;
            mem_w_en <= mem_w_en_in;
            B <= B_in;
            S <= S_in;
            PC <= PC_in;
            exe_cmd <= exe_cmd_in;
            Val_Rn <= Val_Rn_in;
            Val_Rm <= Val_Rm_in;
            imm <= imm_in;
            shift_operand <= shit_operand_in;
            signed_imm_24 <= signed_imm_24_in;
            Dest <= Dest_in;
            
        end


    end

endmodule


