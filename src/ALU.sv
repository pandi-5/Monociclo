module ALU (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] ALUOp,
    output logic [31:0] ALURes
);

    always @(*) begin
        case (ALUOp)
            4'b0111: ALURes = A & B; // AND
            4'b0110: ALURes = A | B; // OR
            4'b0000: ALURes = A + B; // ADD
            4'b1000: ALURes = A - B; // SUB
            4'b0010: ALURes = ($signed(A) < $signed(B)) ? 32'b1 : 32'b0; // SLT con signo
            4'b0011: ALURes = (A < B) ? 32'b1 : 32'b0; // SLT sin signo
            4'b0001: ALURes = A << B[4:0]; // SLL
            4'b0101: ALURes = A >> B[4:0]; // SRL
            4'b1101: ALURes = $signed(A) >>> B[4:0]; //SRA
            4'b0100: ALURes = A ^ B; // XOR
        endcase
    end    
endmodule