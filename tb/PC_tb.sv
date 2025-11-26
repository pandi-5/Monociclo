`timescale 1ns/1ps

module ProgramCounter_tb;

  // Señales del TB
  logic clk;
  logic reset;
  logic [31:0] PcNext;
  logic [31:0] Pc;

  // Instancia del módulo
  ProgramCounter pc_instance (
    .clk(clk),
    .reset(reset),
    .PcNext(PcNext),
    .Pc(Pc)
  );

  // Generación del reloj (10 ns)
  always #5 clk = ~clk;

  initial begin
    $dumpfile("sim/PC_tb.vcd");
    $dumpvars(0, ProgramCounter_tb);

    // Inicialización
    clk = 0;
    reset = 0;
    PcNext = 0;

    // --- Prueba de reset ---
    reset = 1; #10;
    reset = 0; #10;

    // --- Prueba de avance ---
    PcNext = 32'h00000004; #10;  // PC = 4
    PcNext = 32'h00000008; #10;  // PC = 8
    PcNext = 32'h0000000C; #10;  // PC = 12

    // --- Reset final ---
    reset = 1; #10;
    reset = 0; #10;

    $finish;
  end

endmodule
