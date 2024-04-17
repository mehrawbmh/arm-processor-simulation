module ID_Register_file(
    input clk,rst,
    input [3:0] src1,src2,dest_wb,
    input [31:0] result_wb,
    input write_back_en,
    output reg [31:0] reg1,reg2
);

    reg [31:0] reg_mem [0:14] ;
    integer i;
    initial begin
        for (i = 0; i < 15 ; i = i+1) begin
            reg_mem[i] <= i;
        end
    end

    assign reg1=reg_mem[src1];
    assign reg2=reg_mem[src2]; 

    always @(negedge clk,posedge rst) begin
        if (rst) begin
            for (i = 0; i < 15 ; i = i+1) begin
                reg_mem[i] <= i;
            end
        end
        else if (write_back_en)
            reg_mem[dest_wb] <= result_wb;
    end
    
    



endmodule