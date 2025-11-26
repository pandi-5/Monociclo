module ImmGen_tb;

    logic signed [31:7] inst_tb;
    logic [2:0] ImmSrc_tb;
    logic [31:0] ImmExt_tb;

    // Instanciación y concección de señales
    ImmGen InstanceImmGen(
        .inst(inst_tb),
        .ImmSrc(ImmSrc_tb),
        .ImmExt(ImmExt_tb)
    );

    initial begin
        $dumpfile("sim/ImmGen_tb.vcd");
        $dumpvars(0, ImmGen_tb);

        // Casos de prueba
        inst_tb = 25'b0000001101100101110101001;  ImmSrc_tb = 3'b000; #10;  // Tipo I Imm = 54 : 000000110110imm/01011rs1/101fun3/01001rd
        inst_tb = 25'b0000001110110101110110110;  ImmSrc_tb = 3'b001; #10;  // Tipo S Imm = 54 : 0000001imm/11011rs2/01011rs1/101fun3/10110imm
        inst_tb = 25'b0000001110110101110110110;  ImmSrc_tb = 3'b010; #10;  // Tipo B Imm = 54 : 0000001imm/11011rs2/01011rs1/101fun3/10110imm
        inst_tb = 25'b0000000000000011011001001;  ImmSrc_tb = 3'b011; #10;  // Tipo U Imm = 54 : 00000000000000110110imm/01001rd
        inst_tb = 25'b0000001101100000000001001;  ImmSrc_tb = 3'b100; #10;  // Tipo J Imm = 54 : 00000011011000000000imm/01001rd

        $finish
    end    
endmodule