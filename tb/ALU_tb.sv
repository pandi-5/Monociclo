`timescale 1ns/1ps

module ALU_tb;
  // Cables de conexion con el modulo
  logic signed [31:0] Atb, Btb;
  logic [3:0]  ALUOptb;
  logic signed [31:0] ALURestb;

  // Instancia de la ALU y pineado
  ALU alu_instance (
    .A(Atb),
    .B(Btb),
    .ALUOp(ALUOptb),
    .ALURes(ALURestb)
  );

  initial begin
    $dumpfile("sim/ALU_tb.vcd");
    $dumpvars(0, ALU_tb);

    // Pruebas básicas
    Atb = 0;  Btb = 0;  ALUOptb = 4'b0000; #10; // ADD: 0 + 0
    Atb = 3;  Btb = 5;  ALUOptb = 4'b0000; #10; // ADD: 3 + 5 = 8
    Atb = 3;  Btb = 5;  ALUOptb = 4'b1000; #10; // SUB: 3 - 5 = -2
    Atb = 1;  Btb = 2;  ALUOptb = 4'b0001; #10; // SLL: 1 << 2 = 4
    Atb = -2; Btb = 3;  ALUOptb = 4'b0010; #10; // SLT: -2 < 3 = 1
    Atb = 2;  Btb = 3;  ALUOptb = 4'b0010; #10; // SLTU: 2 < 3 = 1
    Atb = 4;  Btb = 1;  ALUOptb = 4'b0101; #10; // SRL: 4 >> 1 = 2
    Atb = -8; Btb = 2;  ALUOptb = 4'b1101; #10; // SRA: -8 >>> 2 = -2
    Atb = 3;  Btb = 6;  ALUOptb = 4'b0100; #10; // XOR: 3 ^ 6 = 5
    Atb = 3;  Btb = 6;  ALUOptb = 4'b0110; #10; // OR:  3 | 6 = 7
    Atb = 3;  Btb = 6;  ALUOptb = 4'b0111; #10; // AND: 3 & 6 = 2
    $finish;

  end
endmodule
