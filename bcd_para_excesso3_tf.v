
`timescale 1ns / 1ps

module tb_bcd_para_excesso3();

    reg clk;
    reg reset;
    reg Bin;
    wire Bout;

    // Instancia o conversor
    bcd_para_excesso3 uut (
        .clk(clk),
        .reset(reset),
        .Bin(Bin),
        .Bout(Bout)
    );

    // Geração de clock 100 MHz
    initial clk = 0;
    always #5 clk = ~clk;

    // Estímulo
    initial begin
        // Inicializa
        reset = 1;
        Bin = 0;
        #20;
        reset = 0;

        // Envia BCD 5 (0101), LSB primeiro
        send_bit(1); // LSB
        send_bit(0);
        send_bit(1);
        send_bit(0); // MSB

        // Aguarda tempo para ver a resposta
        #100;

        $finish;
    end

    // Tarefa para enviar 1 bit por ciclo de clock
    task send_bit(input bit);
        begin
            Bin = bit;
            #10; // espera 1 ciclo de clock
        end
    endtask

endmodule
