module program_counter(
input [31:0] PcNext,
input clk,areset,load,
output reg [31:0] Pc
);

always@(posedge clk or negedge areset)begin
    if(!areset)
    begin
        Pc<=0;
    end
    else if(load)begin
        Pc<=PcNext;
    end
end


endmodule 