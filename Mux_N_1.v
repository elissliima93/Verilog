//	Elabore uma descrição parametrizável de um multiplexador
//Nx1, com N entradas de dados de 1 bit e uma saída de 1 bit.
 // Simule para N = 4
 
 module mux_n_1 #( parameter N=4)
	 (
	 input wire [N-1:0] in,  //vetor de entrada-1 bit cada 
	 input wire [$clog2(N)-1:0] sel, // qtd de bits suficientes para selecionar entre N entradas
	 output wire out
);
	 
	 
	 assign out =in[sel]; //saida é o bit de entrada selecionado
	 
	 endmodule
	 
	 
	 