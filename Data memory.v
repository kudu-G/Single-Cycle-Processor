module data_mem(
    input clk,WE,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD


);

initial begin
    $readmemh("data_memory.hex", mem);
end 
reg [31:0] mem [0:63];
always@(posedge clk)begin
    if(WE)
    mem[A]<=WD;
end

assign RD = mem[A];
endmodule