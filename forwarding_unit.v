module Forwarding_unit(
    input[3:0] src1,
    input[3:0] src2,
    input[3:0] dest_EX_reg,
    input[3:0] dest_MA_reg,
    input wb_en_EX_reg,
    input wb_en_MA_reg,
    input forward_en,
    input sram_freeze,
    output reg[1:0] sel_src1,
    output reg[1:0] sel_src2
);
    always @(*) begin
        if(~sram_freeze)begin
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
    end


    always @(*) begin
        if (~sram_freeze)begin
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
    end

endmodule
