module ProgramCounter(
    input logic clk,            // Señal de reloj
    input logic reset,          // Señal de reset
    input logic [31:0] PcNext,  // Proxima direccion de memoria
    output logic [31:0] Pc      // Direccion de memoria actual
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            Pc <= 32'b0;
        else
            Pc <= PcNext;
    end
endmodule