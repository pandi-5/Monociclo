module ALU_block(
    input logic [3:0] ALUOp,        // Determina la operacion de la ALU
    input logic ALUASrc, ALUBSrc,   // Señales para determinar A y B de la ALU

    input logic [31:0] RUrs1, // Registro RU(rs1) 
    input logic [31:0] RUrs2, // Registro RU(rs1)
    input logic [31:0] ImmExt, // Inmediato extendido
    input logic [31:0] Pc,  // Direccion actual de memoria

    output logic [31:0] ALURes //Resultado de la ALU
);

    // MUX A
    logic [31:0] ALU_A;
    assign ALU_A = (ALUASrc) ? Pc : RUrs1;

    // MUX B
    logic [31:0] ALU_B;
    assign ALU_B = (ALUBSrc) ? ImmExt : RUrs2;

    // Instancia de la ALU
    ALU ALUInstance(
        .A(ALU_A),
        .B(ALU_B),
        .ALUOp(ALUOp),
        .ALURes(ALURes)
    );
    
endmodule