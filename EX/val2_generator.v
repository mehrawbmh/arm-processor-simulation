module val2_generator(
    input[31:0] val_rm,
    input imm,
    input [11:0] shift_operand,
    input mem_R_en, mem_W_en,
    output reg [31:0] val2
);

    wire load_store_cmd;
    assign load_store_cmd = mem_R_en | mem_W_en;

    wire[3:0] rotate_imm;
    assign rotate_imm = shift_operand[11:8];
    
    wire[7:0] immed_8;
    assign immed_8 = shift_operand[7:0];

    wire [31:0] immed_32;
    assign immed_32 = imm ? {24'd0, immed_8} : val_rm;

    wire [63:0] tmp, tmp2;
    assign tmp = {immed_32, immed_32};
    assign tmp2 = tmp >> (2 * rotate_imm);

    wire [31:0] tmp_shifted;
    assign tmp_shifted = tmp2[63:32];

    always @(*) begin
        if (load_store_cmd)
            val2 = shift_operand[11] ? {20'b1, shift_operand} : {20'd0, shift_operand};
        else 
            val2 = tmp_shifted;
    end



endmodule