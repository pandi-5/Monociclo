module Top_level (
    input  logic clk,     // Reloj principal
    input  logic reset    // Reset global
);

// ===============================
// PC
// ===============================

    // Señales internas del PC
    logic [31:0] Pc;       // Valor actual del PC
    logic [31:0] PcNext;   // Valor siguiente del PC
    logic [31:0] PcPlus4;

    // Instancia sumador
    Adder4 Adder4Instance(
        .Pc(Pc),
        .PcPlus4(PcPlus4)
    );
    
    // Instancia
    ProgramCounter PCInstance (
        .clk(clk),
        .reset(reset),
        .PcNext(PcNext),
        .Pc(Pc)
    );

// ===============================
// Instruction Memory
// ===============================

    // Señales internas
    logic [6:0]  OpCode;
    logic [4:0]  rd;
    logic [2:0]  Funct3;
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [6:0]  Funct7;
    logic [31:7] inst;

    // Instancia
    InstructionMemory IMInstance(
        .Address(Pc),
        .OpCode(OpCode),
        .rd(rd),
        .Funct3(Funct3),
        .rs1(rs1),
        .rs2(rs2),
        .Funct7(Funct7),
        .inst(inst)
    );

// ===============================
// Control Unit
// ===============================

    // Señales internas 
    logic [4:0] BrOp;
    logic [3:0] ALUOp;    
    logic [2:0] DMCtrl;
    logic [2:0] ImmSrc;
    logic [1:0] RUDataWrSrc;
    logic ALUASrc;
    logic ALUBSrc;
    logic DMWr;
    logic RUWr;

    // Instancia
    ControlUnit CUInstance(
        .OpCode(OpCode),
        .Funct3(Funct3),
        .Funct7(Funct7),
        .BrOp(BrOp),
        .ALUOp(ALUOp),
        .DMCtrl(DMCtrl),
        .ImmSrc(ImmSrc),
        .RUDataWrSrc(RUDataWrSrc),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .DMWr(DMWr),
        .RUWr(RUWr)  
    );

// ===============================
// Register Unit
// ===============================

    // Señales internas
    logic [31:0] DataWr;
    logic [31:0] RUrs1, RUrs2;

    // Instancia
    RegisterUnit RUInstance(
        .clk(clk),
        .RUWr(RUWr),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .DataWr(DataWr),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2)
    );

// ===============================
// Immediate Generator
// ===============================

    // Señales internas
    logic [31:0] ImmExt;

    // Instancia
    ImmGen IGInstance(
        .inst(inst),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

// ===============================
// ALU Block
// ===============================

    // Señales internas
    logic [31:0] ALURes;

    // Instancia
    ALU_block A_BlockInstance(
        .ALUOp(ALUOp),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2),
        .ImmExt(ImmExt),
        .Pc(Pc),
        .ALURes(ALURes)
    );

// ===============================
// Branch
// ===============================

    // Señales internas
    logic NextPCSrc;

    // Instancia
    BranchUnit BUInstance(
        .RUrs1(RUrs1),
        .RUrs2(RUrs2),
        .BrOp(BrOp),
        .NextPCSrc(NextPCSrc)
    );

// ===============================
// Data Memory
// ===============================

    // Señales internas
    logic [31:0] DataRd;

    // Instancia
    DataMemory DMInstance(
        .Address(ALURes),
        .DataWr(RUrs2),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .DataRd(DataRd)
    );

// ===============================
// PC MUX
// ===============================

    // Señales internas
        // ya estan todas declaradas

    // Instancia
    PC_Mux PCMInstance(
        .PcPlus4(PcPlus4),
        .ALURes(ALURes),
        .NextPCSrc(NextPCSrc),
        .PcNext(PcNext)
    );

// ===============================
// RU MUX
// ===============================

    // Señales internas
        // ya estan todas declaradas

    // Instancia
    RU_mux RUMInstance(
        .PcPlus4(PcPlus4),
        .DataRd(DataRd),
        .ALURes(ALURes),
        .RUDataWrSrc(RUDataWrSrc),
        .DataWr(DataWr)
    );

endmodule