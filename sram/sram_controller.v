module sram_controller(
    input clk,rst,
    // from memory
    input wr_en,
    input rd_en,
    input [31:0] address,
    input [31:0] write_data,

    // to next stage
    output reg[31:0] read_data,
    output reg sram_freeze,
    inout reg [15:0] SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    output reg SRAM_WE_N,ready,
    output  SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N
    );

    reg [3:0] ps,ns;
    parameter [3:0]
    mem =0 , w_low=1,w_high=2,w_ne=3,noop=4,r_e=5,r_low=6,r_high=7,Ready=8;
    wire [15:0] d;
    assign d = SRAM_DQ;

    always @(posedge clk)begin
		if(rst)
			ps <= mem;
		else
			ps <= ns;
    end
    always @(*)begin
        ns=mem;
        case(ps)
        mem : begin
        if(wr_en)
            ns=w_low;
        if(rd_en)
            ns=r_e;
        end
        w_low : 
            ns=w_high;
        w_high :
            ns= w_ne;
        w_ne :
            ns= noop;
        noop:
            ns=ready;
        r_e:
            ns=r_low;
        r_low:
            ns=r_high;
        r_high:
            ns=noop;
        endcase

    end

    always@(*)begin
        

        SRAM_WE_N=1'b1;
        ready=1'b0;
        SRAM_ADDR = 18'b0;
        case(ps)
            mem:begin
                sram_freeze=rd_en | wr_en;
            end
            w_low: begin
                SRAM_WE_N=1'b0;
                SRAM_ADDR={address[18:2],1'b0};
                
            end
            w_high:begin
                SRAM_WE_N=1'b0;
                SRAM_ADDR={address[18:2],1};
            end
            w_ne:
                SRAM_WE_N=1'b1;
            r_e:begin
                SRAM_WE_N=1'b1;
                SRAM_ADDR={address[18:2],1'b0};
            end
            r_low:begin
                SRAM_ADDR={address[18:2],1'b1};
                read_data={16'b0,d};
            end
            r_high:begin
                read_data[31:16]=d;
            end
            Ready:begin
                ready=1'b1;
                sram_freeze=1'b0;
            end





        endcase

    end
assign {SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N}=4'b0;
assign SRAM_DQ=(ps == w_low)? write_data[15 : 0] :
                (ps == w_high)? write_data[31 : 16] : 16'bz;


endmodule