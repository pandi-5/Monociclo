module RU_mux (
    input logic [31:0] PcPlus4,     // Direccion de memoria actual + 4
    input logic [31:0] DataRd,      // Dato leido desde la DM
    input logic [31:0] ALURes,      // Resultado de la ALU
    input logic [1:0] RUDataWrSrc,  // Determina que se escribe en RU
    output logic [31:0] DataWr      // Dato a escribir en RU
);

    always_comb begin
        case (RUDataWrSrc)
            2'b10: DataWr = PcPlus4;
            2'b01: DataWr = DataRd;
            2'b00: DataWr = ALURes;
            default: DataWr = ALURes;
        endcase
    end
    
endmodule