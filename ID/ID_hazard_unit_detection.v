module ID_hazard_detection_unit(
    input[3 : 0] src1,
    input[3: 0] src2,
    input [3 : 0] Exe_Dest,
    input Exe_WB_En,
    input [3 : 0] Mem_Dest,
    input Mem_WB_En,
    inout Two_Src,
    output reg hazard_Detected
);

always@(*)begin
    hazard_Detected = 1'b0;
    if(Exe_WB_En && (src1 == Exe_Dest))
       hazard_Detected = 1'b1; 
    if(Mem_WB_En && (src1 == Mem_Dest))
        hazard_Detected = 1'b1;
    if(Exe_WB_En && Two_Src && (src2 == Exe_Dest))
        hazard_Detected = 1'b1;
    if(Mem_WB_En && Two_Src && (src2 == Mem_Dest))
        hazard_Detected = 1'b1;
end

endmodule