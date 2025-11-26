module ImmGen (
    input logic signed [31:7] inst,      // bits [31:7] contienen el inmediato repartido
    input logic [2:0] ImmSrc,     // tipo de inmediato: I, S, B, U, J
    output logic [31:0] ImmExt
);

    always @(*) begin
        case (ImmSrc)
            3'b000: ImmExt = {{20{inst[31]}}, inst[31:20]};                                         // tipo I
            3'b001: ImmExt = {{20{inst[31]}}, inst[31:25], inst[11:7]};                             // tipo S
            3'b010: ImmExt = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};    // tipo B
            3'b011: ImmExt = {inst[31:12], 12'b0};                                                  // tipo U
            3'b100: ImmExt = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};  // tipo J
            default: ImmExt = 32'b0;
        endcase
    end
endmodule