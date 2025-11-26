module RegisterUnit (
    input  logic clk,
    input  logic RUWr,                  // write enable
    input  logic [4:0]  rs1, rs2, rd,   // direcciones
    input  logic [31:0] DataWr,         // dato a escribir
    output logic [31:0] RUrs1, RUrs2    // datos leídos
);

logic [31:0] regs [31:0];  // 32 registros de 32 bits

    //Inicializar valores
    initial begin
        regs[2] = 32'h000003FC;  // Stack pointer
    end

    // Lectura combinacional
    assign RUrs1 = regs[rs1];
    assign RUrs2 = regs[rs2];

    // Escritura sincronizada
    always_ff @(posedge clk) begin
        if (RUWr && (rd != 0))
            regs[rd] <= DataWr;
    end
endmodule