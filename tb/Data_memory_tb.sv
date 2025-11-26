`timescale 1ns/1ps

module DataMemory_tb;

  // Señales de conexión
  logic [31:0] Address_tb;
  logic [31:0] DataWr_tb;
  logic        DMWr_tb;       
  logic [2:0]  DMCtrl_tb;     
  logic [31:0] DataRd_tb;

  // Instancia del módulo
  DataMemory DM_instance (
    .Address(Address_tb),
    .DataWr(DataWr_tb),
    .DMWr(DMWr_tb),
    .DMCtrl(DMCtrl_tb),
    .DataRd(DataRd_tb)
  );

  initial begin
    $dumpfile("sim/Data_memory_tb.vcd");
    $dumpvars(0, DataMemory_tb);

    // Inicialización
    Address_tb = 0;
    DataWr_tb  = 0;
    DMWr_tb    = 0;
    DMCtrl_tb  = 3'b000;

    // =====================================================
    // PRUEBA 1 — SW: escribir palabra completa
    // =====================================================
    Address_tb = 32'h00000000;
    DataWr_tb  = 32'hAABBCCDD;
    DMWr_tb    = 1;
    DMCtrl_tb  = 3'b010;   // SW
    #10;

    // Leer la palabra
    DMWr_tb    = 0;
    #10;

    // =====================================================
    // PRUEBA 2 — SB: escribir byte bajo
    // =====================================================
    Address_tb = 32'h00000004;   // dirección siguiente
    DataWr_tb  = 32'h000000EE;
    DMWr_tb    = 1;
    DMCtrl_tb  = 3'b000;   // SB
    #10;

    // Leer byte (LB)
    DMWr_tb    = 0;
    DMCtrl_tb  = 3'b000;   // LB
    #10;

    // Leer byte sin signo (LBU)
    DMCtrl_tb  = 3'b100;   // LBU
    #10;

    // =====================================================
    // PRUEBA 3 — SH: escribir HALFWORD
    // =====================================================
    Address_tb = 32'h00000008;
    DataWr_tb  = 32'h0000FACE;
    DMCtrl_tb  = 3'b001;   // SH
    DMWr_tb    = 1;
    #10;

    // Leer HALFWORD (LH)
    DMWr_tb    = 0;
    DMCtrl_tb  = 3'b001;   // LH
    #10;

    // Leer HALFWORD sin signo (LHU)
    DMCtrl_tb  = 3'b101;   // LHU
    #10;

    // =====================================================
    // PRUEBA 4 — LW: verificar lectura de palabra completa
    // =====================================================
    Address_tb = 32'h00000000;
    DMCtrl_tb  = 3'b010;  // LW
    #10;

    // Fin de simulación
    $finish;
  end

endmodule
