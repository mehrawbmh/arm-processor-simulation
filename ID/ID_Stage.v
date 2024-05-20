module ID_Stage (
    input clk,rst,
    // IF
    input [31:0] instruction,
    // WB
    input [31:0] Result_WB,
    input writeBackEn,
    input [3:0] dest_wb,
    // hazard
    input hazard,
    // status 
    input [3:0] SR,
    // to next stage
    output wb_en,mem_r_en,mem_w_en,B,S,
    output [3:0] exe_cmd,
    output [31:0] Val_Rn, Val_Rm,
    output imm,
    output [11:0] shift_operand,
    output [23:0] signed_imm_24,
    output [3:0] Dest,
    // to hazard
    output [3:0] src1,src2,
    output Two_src);

    wire S_out,B_out,mem_r_en_out, mem_w_en_out,wb_en_out;
    wire [3:0] exe_cmd_out;
    wire check_res;
    wire [8 : 0] control_out;
    wire [8 : 0] control_in;
    wire mux_sel;    
    
    assign src1 = instruction[19:16]; //Rn
    
    
    mux #(4) reg_mux(mem_w_en,instruction[3:0], instruction [15:12],src2);


    ID_Register_file aa(clk,rst,src1,src2,dest_wb,Result_WB,writeBackEn,Val_Rn,Val_Rm);
    ID_control_Unit bb(instruction[20],instruction[24:21],instruction[27:26],S_out,B_out,
    mem_r_en_out,mem_w_en_out,wb_en_out,exe_cmd_out);
    ID_condition_check cc(.Cond(instruction[31:28]),.Z(SR[2]),.C(SR[1]),.N(SR[3]),.V(SR[0]),.sel(check_res));

    mux #(9) control_mux(mux_sel, control_in, 9'b0, control_out); 
    assign mux_sel = hazard | ~check_res;
    assign control_in={S_out,B_out,mem_r_en_out,mem_w_en_out,wb_en_out,exe_cmd_out};

    assign Dest=instruction[15:12]; //Rd
    assign signed_imm_24=instruction[23:0];
    assign shift_operand=instruction[11:0];
    assign imm= instruction[25];
    assign Two_src=mem_w_en | (~imm);

    assign S = control_out[8];
    assign B = control_out[7];
    assign mem_r_en = control_out[6];
    assign mem_w_en = control_out[5];
    assign wb_en =control_out[4];
    assign exe_cmd = control_out[3 : 0];

endmodule