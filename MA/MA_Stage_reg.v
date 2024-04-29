module MA_Stage_reg(
    input clk,rst,wb_en_in,mem_r_en_in,
    input[31:0] alu_result_in,mem_read_value_in,
    input [3:0] Dest_in,
    output reg wb_en,mem_r_en,
    output reg [31:0] alu_result,mem_read_value,
    output reg [3:0] Dest
    );
    
    always@(posedge clk, negedge rst)begin
        if(rst)begin
        wb_en <= 1'b0;
        mem_r_en <= 1'b0;
        alu_result <= 32'b0;
        mem_read_value <= 32'b0;
        Dest <= 4'b0;
    end
	 else begin
        wb_en <= wb_en_in;
        mem_r_en <= mem_r_en_in;
        alu_result <= alu_result_in;
        mem_read_value <= mem_read_value_in;
        Dest <= Dest_in;
	end
    end

endmodule