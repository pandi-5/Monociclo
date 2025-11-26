module InstructionMemory (
    input  logic [31:0] Address,
    output logic [6:0]  OpCode,
    output logic [4:0]  rd,
    output logic [2:0]  Funct3,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [6:0]  Funct7,
    output logic [31:7] inst
);
    logic [31:0] mem [0:255]; // memoria con 256 palabras de 32 bits
    logic [31:0] instruction;

    initial begin
        mem[0] = 32'h00500093; // ADDI x1, x0, 5
        mem[1] = 32'h00110133; // ADD x2, x1, x1
        mem[2] = 32'h00208663; // BEQ x1, x2, 8
        mem[3] = 32'h00900193; // ADDI x3, x0, 9
    end

    // acceso por palabra: Address[9:2] (ya que las direcciones son múltiplos de 4)
    assign instruction = mem[Address[9:2]];

    // decodificación de campos de la instrucción
    assign OpCode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign Funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign Funct7 = instruction[31:25];
    assign inst   = instruction[31:7];
endmodule
