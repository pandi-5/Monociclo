module ControlUnit_tb;

    // Entradas
    logic [6:0] OpCode;
    logic [2:0] Funct3;
    logic [6:0] Funct7;

    // Salidas
    logic [4:0] BrOp;
    logic [3:0] ALUOp;
    logic [2:0] DMCtrl;
    logic [2:0] ImmSrc;
    logic [1:0] RUDataWrSrc;
    logic ALUASrc;
    logic ALUBSrc;
    logic DMWr;
    logic RUWr;

    // Instancia del módulo
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

    // Para simular
    initial begin
        $dumpfile("sim/ControlUnit_tb.vcd");
        $dumpvars(0, ControlUnit_tb);

        // ========================
        // INSTRUCCIONES TIPO R
        // ========================
        
        // ADD
        OpCode = 7'b0110011; Funct3 = 3'b000; Funct7 = 7'b0000000; #10;

        // SUB
        Funct7 = 7'b0100000; #10;

        // AND
        Funct3 = 3'b111; Funct7 = 7'b0000000; #10;

        // OR
        Funct3 = 3'b110; #10;


        // ========================
        // TIPO I (ADDI, ANDI, ORI...)
        // ========================

        OpCode = 7'b0010011; Funct3 = 3'b000; Funct7 = 7'b0000000; #10;

        Funct3 = 3'b111; #10; // ANDI

        Funct3 = 3'b110; #10; // ORI


        // ========================
        // TIPO LOAD (LW, LH, LB)
        // ========================

        OpCode = 7'b0000011; Funct3 = 3'b010; #10;

        // ========================
        // TIPO STORE (SW)
        // ========================

        OpCode = 7'b0100011; Funct3 = 3'b010; #10;

        // ========================
        // TIPO B (BEQ, BNE, BLT...)
        // ========================

        OpCode = 7'b1100011; Funct3 = 3'b000; #10; // BEQ

        Funct3 = 3'b001; #10; // BNE

        // ========================
        // TIPO U (LUI)
        // ========================

        OpCode = 7'b0110111; Funct3 = 3'b000; #10;

        // ========================
        // TIPO U (AUIPC)
        // ========================

        OpCode = 7'b0010111; #10;

        // ========================
        // TIPO J (JAL)
        // ========================

        OpCode = 7'b1101111; #10;

        // ========================
        // TIPO J (JALR)
        // ========================

        OpCode = 7'b1100111; Funct3 = 3'b000; #10;
        
        $finish;
    end

endmodule
