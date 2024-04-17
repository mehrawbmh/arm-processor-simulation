module ALU (
    input[31:0] val1,
    input[31:0] val2,
    input carry,
    input [3:0] exe_command,
    output reg result
);

    assign carry_bar = !carry;

    always @(*) begin
        case (exe_command)
            4'b0001: result = val2;
            4'b1001: result = ~val2;
            4'b0010: result = val1 + val2;
            4'b0011: result = val1 + val2 + carry;
            4'b0100: result = val1 - val2;
            4'b0101: result = val1 - val2 - carry_bar;
            4'b0110: result = val1 & val2;
            4'b0111: result = val1 | val2;
            4'b1000: result = val1 ^ val2;
            default: result = 32'dx;
        endcase

    end


endmodule