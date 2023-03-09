module main_decoder(
    input Zero,sign_flag,
    input [6:0] op,
    input [2:0] funct3,
    output reg PCSrc,
    output reg ResultSrc,MemWrite,ALUSrc,RegWrite,
    output reg [1:0] ALUOp,ImmSrc
);
reg Branch;
always@(*)begin
    case(op)
    7'b000_0011:begin
        Branch=0;
        ResultSrc=1;
        MemWrite=0;
        ALUSrc=1;
        RegWrite=1;
        ImmSrc=2'b00;
        ALUOp=2'b00;
    end
    7'b010_0011:begin
        Branch=0;
        ResultSrc=0;
        MemWrite=1;
        ALUSrc=1;
        RegWrite=0;
        ImmSrc=2'b01;
        ALUOp=2'b00;
    end
    7'b011_0011:begin
        Branch=0;
        ResultSrc=0;
        MemWrite=0;
        ALUSrc=0;
        RegWrite=1;
        ImmSrc=2'b00;
        ALUOp=2'b10;
    end
    7'b001_0011:begin
        Branch=0;
        ResultSrc=0;
        MemWrite=0;
        ALUSrc=1;
        RegWrite=1;
        ImmSrc=2'b00;
        ALUOp=2'b10;
    end
    7'b110_0011:begin
        Branch=1;
        ResultSrc=0;
        MemWrite=0;
        ALUSrc=0;
        RegWrite=0;
        ImmSrc=2'b10;
        ALUOp=2'b01;
    end
    default:begin
        Branch=0;
        ResultSrc=0;
        MemWrite=0;
        ALUSrc=0;
        RegWrite=0;
        ImmSrc=2'b00;
        ALUOp=2'b00;
    end
    endcase
    case(funct3)
    3'b000:begin
        PCSrc= Zero & Branch;
    end
    3'b001:begin
        PCSrc= ~(Zero) & Branch;
    end
    3'b100:begin
        PCSrc= sign_flag & Branch;
    end
    default: PCSrc=0;
    endcase
     $dislay("كاعد منتظر عودة  كايدو");
end
endmodule