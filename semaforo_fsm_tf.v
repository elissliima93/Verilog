`timescale 1ns/1ps

module tb_semaforo_fsm();

    // Entradas
    reg clk;
    reg reset;
    reg [2:0] sensor;

    // Saídas
    wire [1:0] cancela;
    wire [1:0] semaforo;

    // Instancia o módulo
    semaforo_fsm uut (
        .clk(clk),
        .reset(reset),
        .sensor(sensor),
        .cancela(cancela),
        .semaforo(semaforo)
    );

    // Gera clock de 10ns
    always #5 clk = ~clk;

    // Estímulos
    initial begin
        $display("Iniciando simulação...");
        $dumpfile("semaforo_fsm.vcd");
        $dumpvars(0, tb_semaforo_fsm);

        // Inicializa sinais
        clk = 0;
        reset = 1;
        sensor = 3'b000;

        // Espera 10 ns e libera o reset
        #10 reset = 0;

        // ---- Testa sequência da direita para esquerda ----
        #10 sensor = 3'b001; // S0 -> S1
        #10 sensor = 3'b010; // S1 -> S2
        #10 sensor = 3'b011; // S2 -> S3
        #10 sensor = 3'b001; // S3 -> S4
        #10 sensor = 3'b001; // S4 -> S1 (loop)
        
        // ---- Testa sequência da esquerda para direita ----
        #10 sensor = 3'b101; // S1 -> S5
        #10 sensor = 3'b011; // S5 -> S3
        #10 sensor = 3'b010; // S3 -> S2
        #10 sensor = 3'b110; // S2 -> S0

        // ---- Testa comportamento com entradas não previstas ----
        #10 sensor = 3'b111; // estado atual permanece
        #10 sensor = 3'b000;

        #20 $finish;
    end

endmodule
