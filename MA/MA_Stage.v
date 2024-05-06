module MA_stage(
    input clk,mem_r_en, mem_w_en,
    input [31:0] addresss,data,
    output[31:0] mem_result);

    reg [31:0] memory [0:63];
    wire [31:0] true_addr=(addresss-32'd1024)>>2;
    always@(posedge clk)begin

        if(mem_w_en)begin
            memory[true_addr] <= data;
        end
        
    end
    assign mem_result=(mem_r_en)?memory[true_addr] :32'bz;
endmodule