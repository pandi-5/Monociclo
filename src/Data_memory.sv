module DataMemory (
    input  logic [31:0] Address,    // dirección calculada por la ALU
    input  logic [31:0] DataWr,     // dato a escribir (desde rs2)
    input  logic DMWr,              // 1 = escribir, 0 = leer
    input  logic [2:0]  DMCtrl,     // controla tipo de acceso (byte, half, word)
    output logic [31:0] DataRd      // dato leído
);

    // Memoria de datos (256 palabras = 1 KB)
    logic [31:0] mem [0:255];

    // Escritura combinacional
    always @(*) begin
        if (DMWr) begin
            case (DMCtrl)
                3'b000: mem[Address[9:2]][(Address[1:0]*8) +: 8]  = DataWr[7:0];    // SB
                3'b001: mem[Address[9:2]][(Address[1]*16) +: 16]  = DataWr[15:0];   // SH
                3'b010: mem[Address[9:2]]                          = DataWr;        // SW
                default: ;
            endcase
        end
    end

    // Lectura combinacional
    always @(*) begin
        case (DMCtrl)
            3'b000: DataRd = {{24{mem[Address[9:2]][(Address[1:0]*8)+7]}},
                               mem[Address[9:2]][(Address[1:0]*8) +: 8]};       // LB
            3'b001: DataRd = {{16{mem[Address[9:2]][(Address[1]*16)+15]}},
                               mem[Address[9:2]][(Address[1]*16) +: 16]};       // LH
            3'b010: DataRd = mem[Address[9:2]];                                 // LW
            3'b100: DataRd = {24'b0, mem[Address[9:2]][(Address[1:0]*8) +: 8]}; // LBU
            3'b101: DataRd = {16'b0, mem[Address[9:2]][(Address[1]*16) +: 16]}; // LHU
            default: DataRd = 32'b0;
        endcase
    end

endmodule
