
module Reg_Read(input clk, rst, ld1, ld2, inout [15:0] data1, data2, output reg [31:0] data_out);
    always @(posedge clk, posedge rst) begin
        if (rst)
            data_out <= 32'b0;
        else if (ld1)
            data_out[15:0] <= data1;
        else if (ld2)
            data_out[31:16] <= data2;
        
    end
endmodule