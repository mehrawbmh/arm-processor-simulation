module IF_Stage_reg(
    input clk, rst, freeze, flush,
    input [31:0] pcIn, instructionIn, 
    output reg [31:0] pc, instruction
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            pc = 32'd0;
            instruction = 32'd0;
        end
		  else if (flush) begin
				pc = 32'd0;
				instruction = 32'd0;
		  end
        else if(~freeze) begin
            pc = pcIn;
            instruction = instructionIn;
        end        
    end

endmodule