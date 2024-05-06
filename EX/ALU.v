module ALU (
    input[31:0] val1,
    input[31:0] val2,
    input carry,
    input [3:0] exe_command,
    output reg [31:0] result,
    output [3:0] status
);

    assign carry_bar = !carry;
	
	reg cout;

    always @(*) begin
		cout = 1'b0;
        case (exe_command)
            4'b0001: result = val2;
            4'b1001: result = ~val2;
            4'b0010: {cout, result} = val1 + val2;
            4'b0011: {cout, result} = val1 + val2 + carry;
            4'b0100: result = val1 - val2;
            4'b0101: result = val1 - val2 - carry_bar;
            4'b0110: result = val1 & val2;
            4'b0111: result = val1 | val2;
            4'b1000: result = val1 ^ val2;
            default: result = 32'd0;
        endcase
    end

    assign status[0] = ((exe_command==4'b0010)||((exe_command==4'b0011))) ? (result[31]&&(~val2[31])&&(~val1[31]))||((~result[31])&&(val2[31])&&(val1[31])) :
               ((exe_command==4'b0100)||((exe_command==4'b0101))) ? ((~result[31])&&(~val2[31])&&(val1[31]))||((result[31])&&(val2[31])&&(~val1[31])):
               1'b0; //v bit for overflow
    assign status[1] = cout;
    assign status[2] = (result == 32'd0); // z bit for zero detection
    assign status[3] = result[31]; //n bit for negative result
    
endmodule