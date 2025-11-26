module Branch_tb;

    // Declaracion de señales internas
    logic signed [31:0] rs1_tb, rs2_tb;
    logic [4:0] BrOp_tb;
    logic NextPCSrc_tb;

    // Instancia y conección de señales
    BranchUnit branch_instance (
        .rs1(rs1_tb),
        .rs2(rs2_tb),
        .BrOp(BrOp_tb),
        .NextPCSrc(NextPCSrc_tb)
    );

    // Ruta y nombre archivo vcd
    initial begin
        $dumpfile("sim/Branch_tb.vcd");
        $dumpvars(0, Branch_tb);

        // Pruebas de las operaciones branch
        rs1_tb = 4;    rs2_tb = 8;    BrOp_tb = 5'b01000; #10;    //beq 4 == 8? = 0
        rs1_tb = 8;    rs2_tb = 8;    BrOp_tb = 5'b01000; #10;    //beq 8 == 8? = 1
        rs1_tb = 12;   rs2_tb = 8;    BrOp_tb = 5'b01001; #10;    //bnq 12 != 8? = 1
        rs1_tb = 16;   rs2_tb = 16;   BrOp_tb = 5'b01001; #10;    //bnq 16 != 16? = 0
        rs1_tb = -4;   rs2_tb = 8;    BrOp_tb = 5'b01100; #10;    //blt -4 < 8? = 1
        rs1_tb = 16;   rs2_tb = -4;   BrOp_tb = 5'b01100; #10;    //blt 16 < -4? = 0
        rs1_tb = 4;    rs2_tb = 8;    BrOp_tb = 5'b01101; #10;    //bge 4 >= 8? = 0
        rs1_tb = 8;    rs2_tb = 8;    BrOp_tb = 5'b01101; #10;    //bge 8 >= 8? = 1
        rs1_tb = 12;   rs2_tb = 8;    BrOp_tb = 5'b01101; #10;    //bge 12 >= 8? = 1
        rs1_tb = -12;  rs2_tb = 8;    BrOp_tb = 5'b01110; #10;    //bltu -12 < 8? = 0
        rs1_tb = -4;   rs2_tb = 4;    BrOp_tb = 5'b01110; #10;    //bltu -4 < 4? = 0
        rs1_tb = 4;    rs2_tb = -16;  BrOp_tb = 5'b01110; #10;    //bltu 4 < -16? = 1
        rs1_tb = 4;    rs2_tb = -8;   BrOp_tb = 5'b01111; #10;    //bgeu 4 >= -8? = 0
        rs1_tb = -8;    rs2_tb = 8;   BrOp_tb = 5'b01111; #10;    //bgeu -8 >= 8? = 1
        rs1_tb = -12;   rs2_tb = 8;   BrOp_tb = 5'b01111; #10;    //bgeu -12 >= 8? = 1
        rs1_tb = -12;   rs2_tb = 8;   BrOp_tb = 5'b11010; #10;    //jal = 1
        rs1_tb = -12;   rs2_tb = 8;   BrOp_tb = 5'b10001; #10;    //jalr = 1
        $finish;
    end


    
endmodule