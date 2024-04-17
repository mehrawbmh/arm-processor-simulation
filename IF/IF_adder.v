module IF_adder(input clk,rst,input [31:0] pcOut,output reg [31:0] PC);

    always@(posedge clk,posedge rst)begin
        if (rst) begin
            PC = 32'd0;
        end
        else begin
            PC <= pcOut+32'd4;
        end

    end
endmodule