module Pc_calc(
input PCScr,
input [31:0] ImmExt, Pc,
output reg [31:0] PcNext
);
always @(*) begin
    if(PCScr)begin
        PcNext=Pc+ImmExt;
    end
    else begin
        PcNext=Pc+4;
    end
    
end
endmodule