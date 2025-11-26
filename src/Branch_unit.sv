module BranchUnit(
    input logic signed [31:0] RUrs1,    // Registro RU(rs1) 
    input logic signed [31:0] RUrs2,    // Registro RU(rs2) 
    input logic [4:0] BrOp,             // Determina la operacion de la BranchUnit
    output logic NextPCSrc              // Salida que determina la siguiente direccion de memoria
);
    logic less, equal;
    assign equal = (RUrs1 == RUrs2);
    assign less = (RUrs1 < RUrs2);

    // 0 no salto
    // 1 salto

    always_comb begin
        NextPCSrc = 0;
        casez(BrOp)
        5'b01000 : if (equal) NextPCSrc = 1;                                    // BEQ
        5'b01001 : if (!equal) NextPCSrc = 1;                                   // BNQ
        5'b01100 : if (less) NextPCSrc = 1;                                     // BLT
        5'b01101 : if (!less) NextPCSrc = 1;                                    // BGE
        5'b01110 : if ($unsigned(RUrs1) < $unsigned(RUrs2)) NextPCSrc = 1;      // BLTU
        5'b01111 : if (!($unsigned(RUrs1) < $unsigned(RUrs2))) NextPCSrc = 1;   // BGEU
        5'b1???? : NextPCSrc = 1;                                               // JAL JALR
        5'b00??? : NextPCSrc = 0;                                               // NO SALTO
        default : NextPCSrc = 0;
        endcase
    end
endmodule