module PC_Mux(
    input  logic [31:0] PcPlus4,    // PC + 4 (siguiente instrucción)
    input  logic [31:0] ALURes,     // Dirección destino desde la ALU
    input  logic NextPCSrc,         // Control: 0 = PC+4, 1 = ALU_res
    output logic [31:0] PcNext      // Resultado del MUX (siguiente PC)
);
    // Mux selecciona la dirección siguiente
    assign PcNext = (NextPCSrc) ? ALURes : PcPlus4;

endmodule
