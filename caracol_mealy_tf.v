

`timescale 1ns / 1ps

module tb_caracol_mealy();

    reg clk;
    reg reset;
    reg x;
    wire y;

    // Instancia o módulo
    caracol_mealy uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    // Geração do clock 10ns (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Estímulos de entrada
    initial begin
        // Inicialização
        reset = 1;
        x = 0;
        #20;

        reset = 0;

        // Sequência de bits: 1101 -> deve ativar y
        x = 1; #10;
        x = 1; #10;
        x = 0; #10;
        x = 1; #10; // y = 1 aqui (detecta 1101)

        // Espera alguns ciclos
        x = 0; #20;

        // Sequência de bits: 1110 -> deve ativar y
        x = 1; #10;
        x = 1; #10;
        x = 1; #10;
        x = 0; #10; // y = 1 aqui (detecta 1110)

        // Outra sequência inválida (por exemplo, 1001)
        x = 1; #10;
        x = 0; #10;
        x = 0; #10;
        x = 1; #10; // não deve ativar y

        // Finaliza simulação
        #50;
        $finish;
    end

endmodule
