module MA_Stage_reg(input clk,rst,input [31:0] pcIn,output reg [31:0] pc);
    
    always@(posedge clk, posedge rst)begin
        if(rst)
            pc<=32'h0;
        else
            pc<=pcIn;
    end

endmodule