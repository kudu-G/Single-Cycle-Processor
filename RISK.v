module RISK (input clk ,areset);
    wire [31: 0] PCNext, PC, Instr, SrcA, SrcB, ALUResult, ReadData, WriteData, PCPluse4, PCTarget, ImmExt, Result;
    wire Zero, Sign, load, PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite,Branch;
    wire [2:0] ALUControl;
    wire [1:0] ImmSrc,ALUOp;

    /* Program Ccounter */
    Pc_calc P0 (
        .PCScr(PCSrc),
        .ImmExt(ImmExt), 
        .Pc(PC), 
        .PcNext(PCNext)
    );

    program_counter     P1 (
        .PcNext(PCNext), 
        .clk(clk), 
        .areset(areset), 
        .load(1'b1), 
        .Pc(PC)
    );

    /* Instruction Memory */
    inst_memory M0 (
        .A(PC), 
        .RD(Instr)
    );

    /* Register File */ 
    reg_file R0 (
        .WD3(Result), 
        .A1(Instr[19:15]), 
        .A2(Instr[24:20]), 
        .A3(Instr[11:7]), 
        .clk(clk), 
        .areset(areset), 
        .WE3(RegWrite), 
        .RD1(SrcA), 
        .RD2(WriteData)
    );

    /* Extend */
    sign_extension E0 (
        .instr(Instr), 
        .ImmSrc(ImmSrc), 
        .ImmExt(ImmExt)
    );

    /* ALUSrc Selction */
    mux X0 (
        .in1(WriteData), 
        .in2(ImmExt), 
        .sel(ALUSrc), 
        .out(SrcB)
        );

    /* ALU */
    
    ALU A0 (
        .ScrA(SrcA), 
        .ScrB(SrcB), 
        .ALUControl(ALUControl), 
        .ALUResult(ALUResult), 
        .Zero(Zero), 
        .sign_flag(Sign)
        );


    /* Data Memory */
    data_mem M1 (
        .clk(clk), 
        .WE(MemWrite), 
        .WD(WriteData), 
        .A(ALUResult), 
        .RD(ReadData)
        );

    /* ResultSrc Selection */
    mux X1 (
        .in1(ALUResult), 
        .in2(ReadData), 
        .sel(ResultSrc), 
        .out(Result)
        );

    /* Control Unit */
    main_decoder C0 (
        .op(Instr[6:0]),
        .Zero(Zero), 
        .sign_flag(Sign), 
        .PCSrc(PCSrc), 
        .ResultSrc(ResultSrc), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp),
        .funct3(Instr[14:12])  
        );
    ALU_decoder C1 (
        .funct3(Instr[14:12]), 
        .funct7(Instr[30]),
        .op5(Instr[5]),
        .ALUControl(ALUControl),
        .ALUOp(ALUOp)
    );   

endmodule
