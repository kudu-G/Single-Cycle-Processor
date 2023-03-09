module ALU(
input [31:0] ScrA,ScrB,
input [2:0] ALUControl,
output Zero, sign_flag,
output reg [31:0] ALUResult
);
always @(*) begin
    $display("src a: %d", ScrA);
    case(ALUControl)
    3'b000: ALUResult=ScrA+ScrB;
    3'b001:ALUResult=ScrA<<(ScrB);
    3'b010:ALUResult=ScrA-ScrB;
    3'b100:ALUResult=ScrA^ScrB;
    3'b101:ALUResult=ScrA>>(ScrB);
    3'b110:ALUResult=ScrA|ScrB;
    3'b111:ALUResult=ScrA&ScrB;
    default:ALUResult=0;
        
    endcase
    
end
assign Zero=ALUResult? 0:1;
assign sign_flag=ALUResult[31];

endmodule