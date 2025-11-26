module Adder4 (
    input  logic [31:0] Pc,     // Direccion actual de memoria
    output logic [31:0] PcPlus4 // Direccion actual + 4 
);
    assign PcPlus4 = Pc + 32'd4;
endmodule
