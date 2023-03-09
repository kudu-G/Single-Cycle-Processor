module inst_memory(
input [31:0] A,
output [31:0] RD 
);
reg [31:0] rom [264:0];

initial begin
    $readmemh("FIBONACCI_series_Machine_Code.hex", rom);
end

initial begin
    $monitor("rd %d ",RD);
end
assign RD = rom[A[31:2]]; 

endmodule