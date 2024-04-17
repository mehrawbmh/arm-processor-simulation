module pc_reg(input clk,rst,freeze ,input [31:0] pcIn,output reg [31:0] pcOut);
    
    always @(posedge clk, posedge rst) begin 
        if (rst) 
            pcOut <= 32'd0;
        else if(~freeze) 
            pcOut<=pcIn;
    end

endmodule