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
    parameter [3:0] IDLE = 0, W_LOW = 1, W_HIGH = 2, W_NE = 3, NOP = 4, R_E = 5, R_LOW = 6, R_HIGH = 7, Ready = 8;
    wire [15:0] d;
    assign d = SRAM_DQ;
    wire[31:0] address2;
    assign address2=address-32'd1024;

    always @(posedge clk) begin
		if (rst)
			ps <= IDLE;
		else
			ps <= ns;
    end

    always @(*) begin
        ns=IDLE;

        case(ps)
            IDLE : begin
                if(wr_en)
                    ns=W_LOW;
                if(rd_en)
                    ns=R_E;
            end
            
            W_LOW : 
                ns=W_HIGH;
            W_HIGH :
                ns= W_NE;
            W_NE :
                ns= NOP;
            NOP:
                ns=Ready;
            R_E:
                ns=R_LOW;
            R_LOW:
                ns=R_HIGH;
            R_HIGH:
                ns=NOP;
            Ready:
            ns=IDLE;
        endcase

    end

    always@(*)begin
        SRAM_WE_N=1'b1;
        ready=1'b0;
        SRAM_ADDR = 18'b0;
        sram_freeze=1'b0;
        case(ps)
            IDLE:begin
                sram_freeze=rd_en | wr_en;
            end
            W_LOW: begin
                SRAM_WE_N=1'b0;
                SRAM_ADDR={address2[18:2],1'b0};
                sram_freeze=1'b1;
            end
            W_HIGH:begin
                SRAM_WE_N=1'b0;
                SRAM_ADDR={address2[18:2],1'b1};
                sram_freeze=1'b1;
            end
            W_NE:begin
                sram_freeze=1'b1;
                SRAM_WE_N=1'b1;
            end
            R_E:begin
                SRAM_WE_N=1'b1;
                SRAM_ADDR={address2[18:2],1'b0};
                sram_freeze=1'b1;
            end
            R_LOW:begin
                SRAM_ADDR={address2[18:2],1'b1};
                read_data={16'b0,d};
                sram_freeze=1'b1;
            end
            NOP:
                sram_freeze=1'b1;
            R_HIGH:begin
                read_data[31:16]=d;
                sram_freeze=1'b1;
            end
            Ready:begin
                ready=1'b1;
                sram_freeze=1'b0;
            end

        endcase

    end
    assign {SRAM_UB_N,SRAM_LB_N,SRAM_CE_N,SRAM_OE_N} = 4'b0;
    assign SRAM_DQ = (ps == W_LOW) ? write_data[15 : 0] :
                (ps == W_HIGH) ? write_data[31 : 16] : 16'bz;

endmodule
