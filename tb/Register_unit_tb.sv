`timescale 1ns/1ps

module RegisterUnit_tb;

  // Señales de conexión con el módulo
  logic clk;
  logic RUWr;
  logic [4:0] rs1, rs2, rd;
  logic [31:0] DataWr;
  logic [31:0] RUrs1, RUrs2;

  // Instancia del módulo
  RegisterUnit RU_instance (
    .clk(clk),
    .RUWr(RUWr),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .DataWr(DataWr),
    .RUrs1(RUrs1),
    .RUrs2(RUrs2)
  );

  // Generador de reloj: periodo 10ns
  always #5 clk = ~clk;

  initial begin
    $dumpfile("sim/Register_unit_tb.vcd");
    $dumpvars(0, RegisterUnit_tb);

    // Inicialización
    clk = 0;
    RUWr = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;
    DataWr = 0;

    // ============================
    // Prueba 1: Verificar que x0 es siempre 0
    // ============================
    RUWr = 1;
    rd = 0;
    DataWr= 32'hABCD1234;
    #10;   // espera un flanco de reloj

    rs1 = 0;
    #10;

    // ============================
    // Prueba 2: Escribir en x5
    // ============================
    rd = 5;
    DataWr = 32'hA5A5A5A5;
    #10;

    rs1 = 5;
    #10;

    // ============================
    // Prueba 3: Escribir en x10 y leerlo por rs2
    // ============================
    rd = 10;
    DataWr = 32'hDEADBEEF;
    #10;

    rs2 = 10;
    #10;

    // ============================
    // Prueba 4: Leer SP inicial (x2)
    // ============================
    rs1 = 2;
    #10;

    // Terminar simulación
    $finish;
  end

endmodule
