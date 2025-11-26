module Top_level_tb;

    logic clk;
    logic reset;

    // Instancia del procesador completo
    Top_level DUT (
        .clk(clk),
        .reset(reset)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/Top_level_tb.vcd");
        $dumpvars(0, Top_level_tb);

        clk = 0;
        reset = 1;

        // Liberamos reset después de unos ciclos
        #20 reset = 0;

        // Simulamos 100 ciclos
        repeat (10) @(posedge clk);

        $finish;
    end

endmodule