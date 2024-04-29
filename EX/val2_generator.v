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
    assign immed_32 = {24'd0, immed_8};

    wire [63:0] tmp, tmp2;
    assign tmp = {immed_32, immed_32};
    assign tmp2 = tmp >> (2 * rotate_imm);

    wire [31:0] tmp_shifted;
    assign tmp_shifted = tmp2[31:0];
	
	wire shift_case;
	assign shift_case = shift_operand[6:5];
	
	wire [63:0] rotate_right;
	assign rotate_right = {val_rm, val_rm} >> rotate_imm;

    always @(*) begin
        if (load_store_cmd)
            val2 = shift_operand[11] ? {20'b1, shift_operand} : {20'd0, shift_operand};
        else if (imm)
            val2 = tmp_shifted;
		else begin
			case (shift_case)
				2'b00: val2 = val_rm << rotate_imm;
				2'b01: val2 = val_rm >> rotate_imm;
				2'b10: val2 = val_rm >>> rotate_imm;
				2'b11: val2 = rotate_right[31:0];
				default:
					val2 = 32'dx;
			endcase
		end
    end



endmodule