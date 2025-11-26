module ControlUnit (
    input  logic [6:0] OpCode,   // [6:0]
    input  logic [2:0] Funct3,   // [14:12]
    input  logic [6:0] Funct7,   // [31:25]
    output logic [4:0] BrOp,
    output logic [3:0] ALUOp,    // código de operación para ALU
    output logic [2:0] DMCtrl,
    output logic [2:0] ImmSrc,
    output logic [1:0] RUDataWrSrc,
    output logic ALUASrc,
    output logic ALUBSrc,
    output logic DMWr,
    output logic RUWr
);

    always @(*) begin
        
        // --- Valores por defecto ---
        BrOp        = 5'b00000;
        ALUOp       = 4'b0000; // ADD por defecto
        DMCtrl      = 3'b000;
        ImmSrc      = 3'b000;
        RUDataWrSrc = 2'b00;
        ALUASrc     = 0;
        ALUBSrc     = 0;
        DMWr        = 0;
        RUWr        = 0;

        case (OpCode)
            // Instrucciones tipo R
            7'b0110011: begin
                RUWr = 1;
                ALUASrc = 0;
                ALUBSrc = 0;

                case (Funct3)
                    3'b000: ALUOp = (Funct7[5]) ? 4'b1000 : 4'b0000; // SUB / ADD
                    3'b111: ALUOp = 4'b0111; // AND
                    3'b110: ALUOp = 4'b0110; // OR
                    3'b100: ALUOp = 4'b0100; // XOR
                    3'b010: ALUOp = 4'b0010; // SLT
                    3'b001: ALUOp = 4'b0001; // SLL
                    3'b101: ALUOp = (Funct7[5]) ? 4'b1101 : 4'b0101; // SRA / SRL
                    default: ALUOp = 4'b0000;
                endcase
            end

            // Instrucciones tipo I
            7'b0010011: begin
                RUWr = 1;
                ALUBSrc = 1;
                ImmSrc = 3'b000;

                case (Funct3)
                    3'b000: ALUOp = 4'b0000; // ADDI
                    3'b111: ALUOp = 4'b0111; // ANDI
                    3'b110: ALUOp = 4'b0110; // ORI
                    3'b100: ALUOp = 4'b0100; // XORI
                    3'b010: ALUOp = 4'b0010; // SLTI
                    3'b001: ALUOp = 4'b0001; // SLLI
                    3'b101: ALUOp = (Funct7[5]) ? 4'b1101 : 4'b0101; // SRAI / SRLI
                    default: ALUOp = 4'b0000;
                endcase
            end

            // Tipo L
            7'b0000011: begin
                RUWr = 1;
                ALUBSrc = 1;
                ALUOp = 4'b0000; // dirección = rs1 + imm
                DMCtrl = Funct3;
                RUDataWrSrc = 2'b10; // dato viene de Data Memory
            end

            // Tipo S
            7'b0100011: begin
                ALUBSrc = 1;
                ALUOp = 4'b0000; // dirección = rs1 + imm
                DMCtrl = Funct3;
                DMWr = 1;
            end

            // Tipo B
            7'b1100011: begin
                ALUOp = 4'b1000; // resta para comparación
                BrOp  = {2'b01, Funct3};
            end

            // Tipo U
            7'b0110111: begin // LUI
                RUWr = 1;
                ALUASrc = 0;
                ALUBSrc = 1;
                ImmSrc = 3'b011; // tipo U
                ALUOp = 4'b0000; // pasa el inmediato (ADD)
                RUDataWrSrc = 2'b00;
            end

            // Tipo U
            7'b0010111: begin // AUIPC
                RUWr = 1;
                ALUASrc = 1;
                ALUBSrc = 1;
                ImmSrc = 3'b011;
                ALUOp = 4'b0000; // ADD
                RUDataWrSrc = 2'b00;
            end


            // Tipo J
            7'b1101111: begin // JAL
                RUWr = 1;
                ALUASrc = 1;
                ALUBSrc = 1;
                ImmSrc = 3'b100; // tipo J
                ALUOp = 4'b0000;
                RUDataWrSrc = 2'b10; // PC + 4
                BrOp = 5'b10000;     // salto incondicional
            end

            // Tipo J
            7'b1100111: begin // JALR
                RUWr = 1;
                ALUASrc = 0;
                ALUBSrc = 1;
                ImmSrc = 3'b000; // tipo I
                ALUOp = 4'b0000;
                RUDataWrSrc = 2'b10;
                BrOp = 5'b10001;
            end

            default: begin
                // sin operación
            end
        endcase
    end
endmodule
