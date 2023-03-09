module reg_file(
    input clk,areset,WE3,
    input [4:0] A1,A2,A3,
    input [31:0] WD3,
    output [31:0] RD1,RD2
);

reg [31:0] mem [0:31];

integer i ;

initial begin
    for (i =0 ;i<32 ;i=i+1 ) begin
        mem[i]<={32{1'b0}};
    end
    $display("here");
end

always @(posedge clk  or negedge areset) begin
    if(!areset) begin
        for (i =0 ;i<32 ;i=i+1 ) begin
        mem[i]<={32{1'b0}};
        end
    end
    else if(WE3) begin
        mem[A3]<= WD3;
    end
end

assign RD1= mem[A1] ;
assign RD2= mem[A2] ;

endmodule