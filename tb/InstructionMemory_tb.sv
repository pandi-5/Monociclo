module InstructionMemory_tb;

    logic [31:0] Address_tb;
    logic [6:0]  OpCode_tb;
    logic [4:0]  rd_tb;
    logic [2:0]  Funct3_tb;
    logic [4:0]  rs1_tb;
    logic [4:0]  rs2_tb;
    logic [6:0]  Funct7_tb;
    logic [31:7] inst_tb;

    // Instancia del módulo
    InstructionMemory InstanceIM (
        .Address(Address_tb),
        .OpCode(OpCode_tb),
        .rd(rd_tb),
        .Funct3(Funct3_tb),
        .rs1(rs1_tb),
        .rs2(rs2_tb),
        .Funct7(Funct7_tb),
        .inst(inst_tb)
    );

    // Inicialización
    initial begin
        $dumpfile("sim/InstructionMemory_tb.vcd");
        $dumpvars(0, InstructionMemory_tb);

        // Cargar instrucciones manualmente en la memoria
        InstanceIM.mem[0] = 32'b00000000000100000000000010010011;  // ADDI x1, x0, 1
        InstanceIM.mem[1] = 32'b00000000001000001000000100010011;  // ADDI x2, x1, 2
        InstanceIM.mem[2] = 32'b00000000001000010000000110110011;  // ADD x3, x2, x1
        InstanceIM.mem[3] = 32'b01000000001100010000001000110011;  // SUB x4, x2, x3

        // Leer direcciones
        Address_tb = 0;     #10; // mem[0]
        Address_tb = 4;     #10; // mem[1]
        Address_tb = 8;     #10; // mem[2]
        Address_tb = 12;    #10; // mem[3]

        $finish;
    end

endmodule
