module instruction_Memory(input[31:0] addr, output [31:0] memOut);
    reg [31:0] mem [0:63] ;
	

	 initial begin
		$readmemb("instruction_map.txt", mem);
    end
	 assign memOut = mem[addr[31:2]];


endmodule