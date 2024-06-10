module pc_reg(input clk,rst,freeze ,input [31:0] pcIn,output reg [31:0] pcOut,output reg s);
    
    always @(posedge clk, posedge rst) begin 
        if (rst) begin
            pcOut <= 32'd0;
            
        end
        else if(~freeze) 
            pcOut<=pcIn;
    end
    always@(posedge clk, posedge rst)begin
        if(rst)
            s=1'b0;
        else if(pcIn > 32'd164)
            s<=1'b1;


    end

endmodule