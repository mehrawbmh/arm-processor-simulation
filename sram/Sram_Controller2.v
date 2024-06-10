module Sram_Controller (
    input clk,
    input rst,

    input wr_en,
    input rd_en,
    input [31:0] address,
    input [31:0] writeData,
    input cache_hit,
    output [63:0] readData,

    output reg ready,

    inout [15:0] SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    
    output SRAM_UB_N,
    output SRAM_LB_N,
    output reg  SRAM_WE_N,
    output  SRAM_CE_N,
    output  SRAM_OE_N
);

localparam IDLE = 3'b000, READ1 = 3'b001, READ2 = 3'b010, S3_READ = 3'b011, S4_READ=3'b100;
localparam WRITE1 = 3'b101, WRITE2 = 3'b110, S3_WRITE = 3'b111;
assign {SRAM_LB_N, SRAM_UB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0000;


reg [2:0] ns, ps;

reg inc;
wire CO;
Count6 C6(clk, rst, inc, CO);

reg ld1, ld2, ld3, ld4;

Reg_Read RR1(clk, rst, ld1, SRAM_DQ, readData[15:0]);
Reg_Read RR2(clk, rst, ld2, SRAM_DQ, readData[31:16]);
Reg_Read RR3(clk, rst, ld3, SRAM_DQ, readData[47:32]);
Reg_Read RR4(clk, rst, ld4, SRAM_DQ, readData[63:48]);


always @(*) begin
    ns = IDLE;
    case (ps)
        IDLE: ns = cache_hit ? IDLE : 
                   rd_en? READ1 :
                   wr_en? WRITE1: IDLE;

        READ1:  ns = READ2;
        READ2:  ns = S3_READ ;
        S3_READ:  ns = S4_READ;
        S4_READ:  ns = CO ? IDLE : S4_READ;


        WRITE1:  ns =  WRITE2;
        WRITE2:  ns =  S3_WRITE;
        S3_WRITE:  ns =  CO ? IDLE : S3_WRITE;
        default : ns = IDLE;
    endcase
end



always @(posedge clk, posedge rst) begin
    if (rst)
        ps <= 3'b0;
    else 
        ps <= ns;

end

always @(*) begin
    ready = 1'b0;
    //SRAM_DQ = 16'bz;
    SRAM_WE_N = 1'b1;
    inc = 1'b0;
    SRAM_ADDR = 18'b0;
    ld1 = 1'b0;
    ld2 = 1'b0;
    ld3 = 1'b0;
    ld4 = 1'b0;
    //readData_1 = 32'b0;
    case(ps)
        IDLE : begin 
            ready = ~(wr_en || rd_en);
        end
        READ1 : begin
            ld1 = 1'b1;
			inc = 1'b1;
            SRAM_WE_N = 1'b1;
            SRAM_ADDR = {address[18 : 3], 2'b00};

        end
        READ2 : begin
            ld2 = 1'b1;
            inc = 1'b1;
            SRAM_WE_N = 1'b1;
            SRAM_ADDR = {address[18 : 3], 2'b01};
        end

        S3_READ : begin
            ld3=1'b1;
            inc = 1'b1;
            SRAM_WE_N = 1'b1;
            SRAM_ADDR = {address[18 : 3], 2'b10};
        end
        S4_READ : begin
            ld4=1'b1;
            inc = 1'b1;
            SRAM_WE_N = 1'b1;
            SRAM_ADDR = {address[18 : 3], 2'b11};
            ready = CO;
        end
        WRITE1 : begin
            inc = 1'b1;
            SRAM_WE_N = 1'b0;
            SRAM_ADDR = {address[18 : 2], 1'b0};
            //SRAM_DQ = writeData[15 : 0];

        end
        WRITE2 : begin
            inc = 1'b1;
            SRAM_WE_N = 1'b0;
            SRAM_ADDR = {address[18 : 2], 1'b1};
            //SRAM_DQ = writeData[31 : 16];
        end
        S3_WRITE : begin
            inc = 1'b1;
            ready = CO;
        end

    endcase
end

    assign SRAM_DQ = (ps == WRITE1)? writeData[15 : 0] :
                     (ps == WRITE2)? writeData[31 : 16] : 16'bz;

endmodule

module Count6(input clk, rst, inc, output CO);
    reg [2:0] counter = 3'b0;
    always @(posedge clk, posedge rst) begin
		  if(rst) counter <= 3'b000;
        else if (counter == 3'b100)
            counter <= 3'b000;
        else if (inc)
            counter <= counter + 3'b001;
    end
    assign CO = (counter == 3'b100);

endmodule 

module Reg_Read(input clk, rst, ld, input [15:0] data, output reg [15:0] data_out);
    always @(posedge clk, posedge rst) begin
        if (rst)
            data_out <= 16'b0;
        else if (ld)
            data_out[15:0] <= data;
        
    end


endmodule