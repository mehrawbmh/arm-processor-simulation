module Forwarding_unit(
    input src1,
    input src2,
    input dest_EX_reg,
    input dest_MA_reg,
    input wb_en_EX_reg,
    input wb_en_MA_reg,
    input forward_en,
    output[1:0] sel_src1,
    output[1:0] sel_src2
);
    always @(*) begin
        if (forward_en) begin
            if (wb_en_EX_reg && src1 == dest_EX_reg) begin
                sel_src1 = 2'b01;
            end
            else if (wb_en_MA_reg && src1 == dest_MA_reg) begin
                sel_src1 = 2'b10;
            end
            else begin
                sel_src1 = 2'b00;
            end
        end
        else sel_src1 = 2'b00;
    end


    always @(*) begin
        if (forward_en) begin
            if (wb_en_EX_reg && src2 == dest_EX_reg) begin
                sel_src2 = 2'b01;
            end
            else if (wb_en_MA_reg && src2 == dest_MA_reg) begin
                sel_src2 = 2'b10;
            end
            else begin
                sel_src2 = 2'b00;
            end
        end
        else sel_src2 = 2'b00;
    end

endmodule
