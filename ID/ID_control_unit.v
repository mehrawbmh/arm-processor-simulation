
module ID_control_Unit (
    input S_in, 
    input [3 : 0] op_code, 
    input [1 : 0] mode,
    output reg S_out, B, mem_r_en, mem_w_en, wb_en, 
    output reg [3 : 0] exe_cmd);
    always@(S_in,op_code,mode) begin
        {exe_cmd,B,mem_r_en,mem_w_en,wb_en}=8'd0;
        S_out=S_in;
        if(mode!=2'b10)begin
            case(op_code)
                4'b1101:begin  //mov
                    exe_cmd=4'b0001;
                    wb_en=1'b1;
                end
                4'b1111:begin   ///mvn
                    exe_cmd=4'b1001;
                    wb_en=1'b1;
                end
                4'b0100:begin  ///add ldr str
                    exe_cmd=4'b0010;
                    if(mode==2'b00)begin //add
                        wb_en=1'b1;
                    end
                    else if(mode==2'b01) begin
                        if(S_in==1'b1) begin  // ldr
                            wb_en=1'b1;
                            mem_r_en=1'b1;
                        end
                        else begin  //str
                            wb_en=1'b0;
                            mem_r_en=1'b1;
                        end

                    end
                end
                4'b0101:begin ///adc
                    exe_cmd=4'b0011;
                    wb_en=1'b1;
                end
                4'b0010:begin // sub
                    exe_cmd=4'b0100;
                    wb_en=1'b1;
                end

                4'b0110:begin//sbc
                    exe_cmd=4'b0101;
                    wb_en=1'b1;
                end
                4'b0000:begin//and
                    exe_cmd=4'b0110;
                    wb_en=1'b1;
                end
                4'b1100:begin//ORR
                    exe_cmd=4'b0111;
                    wb_en=1'b1;
                end
                4'b0001:begin //eor
                    exe_cmd=4'b1000;
                    wb_en=1'b1;
                end
                4'b1010:begin //cmp
                    exe_cmd=4'b0100;
                    wb_en=1'b0;
                end
                4'b1000:begin //tst
                    exe_cmd=4'b0110;
                    wb_en=1'b0;
                end
            endcase
        end
        else begin
            if(op_code[3]==1'b0)
                B=1'b1;
        end

    end
    






endmodule