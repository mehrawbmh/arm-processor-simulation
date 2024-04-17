module ID_condition_check(input [3:0] Cond, input Z, C, N, V, output reg sel);
    always @(*) begin
        case(Cond)
            4'd0 : sel = Z;
            4'd1 : sel = ~Z;
            4'd2 : sel = C;
            4'd3 : sel = ~C;
            4'd4 : sel = N;
            4'd5 : sel = ~N;
            4'd6 : sel = V;
            4'd7 : sel = ~V;
            4'd8 : sel = C && ~Z;
            4'd9 : sel = ~C || Z;
            4'd10: sel = (N && V) || (~N && ~V);
            4'd11: sel = (N && ~V) || (~N && V);
            4'd12: sel = (~Z) && ((N && V) || (~N && ~V));
            4'd13: sel = Z || (((N && ~V) || (~N && V)));
            4'd14: sel = 1'b1;
            4'd15: sel = 1'b0;

        endcase

    end
endmodule