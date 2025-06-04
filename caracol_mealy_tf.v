

`timescale 1ns / 1ps

module tb_caracol_mealy();

    reg clk;
    reg reset;
    reg x;
    wire y;

    // Instancia o m�dulo
    caracol_mealy uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    // Gera��o do clock 10ns (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Est�mulos de entrada
    initial begin
        // Inicializa��o
        reset = 1;
        x = 0;
        #20;

        reset = 0;

        // Sequ�ncia de bits: 1101 -> deve ativar y
        x = 1; #10;
        x = 1; #10;
        x = 0; #10;
        x = 1; #10; // y = 1 aqui (detecta 1101)

        // Espera alguns ciclos
        x = 0; #20;

        // Sequ�ncia de bits: 1110 -> deve ativar y
        x = 1; #10;
        x = 1; #10;
        x = 1; #10;
        x = 0; #10; // y = 1 aqui (detecta 1110)

        // Outra sequ�ncia inv�lida (por exemplo, 1001)
        x = 1; #10;
        x = 0; #10;
        x = 0; #10;
        x = 1; #10; // n�o deve ativar y

        // Finaliza simula��o
        #50;
        $finish;
    end

endmodule
