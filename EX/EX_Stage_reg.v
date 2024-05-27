module ex_stage_reg(
    input clk,
    input rst,
    input freeze,
    input wb_en_in,
    input mem_r_en_in,
    input mem_w_en_in,
    input [3:0] dest_in,
    input [3:0] src1_in, src2_in,
    input [31:0] alu_result_in, st_val_in,
    output reg wb_en_out, mem_r_en_out, mem_w_en_out,
    output reg [31:0] alu_result_out, st_val_out,
    output reg [3:0] dest_out,
    output reg [3:0] src1_out, src2_out
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            wb_en_out <= 1'b0;
            mem_r_en_out <= 1'b0;
            mem_w_en_out <= 1'b0;
            dest_out <= 4'b0000;
            alu_result_out <= 32'd0;
            st_val_out <= 32'd0;
            src1_out <= 4'd0;
            src2_out <= 4'd0;

        end
        else if (~freeze) begin
            wb_en_out <= wb_en_in;
            mem_r_en_out <= mem_r_en_in;
            mem_w_en_out <= mem_w_en_in;
            dest_out <= dest_in;
            alu_result_out <= alu_result_in;
            st_val_out <= st_val_in;
            src1_out <= src1_in;
            src2_out <= src2_in;
        end
    end

endmodule