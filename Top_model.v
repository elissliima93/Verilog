module encoder16to4 (
    input  [4:0] in,
    output [15:0]  out
    
);
    wire enable_lower; // sinal q habilita o decodificador de 0 a 7
    wire enable_upper; // sinal q habilita o decoificador de 8 a 15

// ativa o decodificador certo baseado no bit mais significativo(in[3])

	assign enable_lower = ~in[3]; // se MSB =0, Ativa o decodificador inferior
	assign enable_upper =  in[3]; // se MSB =1, Ativa o decodificador superior;
	
// saidas intermediárias dos dois decodificadores 3pra8

	wire[7:0] out_lower;// saidas de 0 a 7
	wire[7:0] out_upper; //saidas de 8 a 15
	
	//iniciando o decodificador
	
    decod_base_3_8 low (
        .in(in[2:0]),  //usa apenas os 3bits menos significativos
        .en(enable_lower), //enable se MSB =0
        .out(out_lower) //saida conecta os bits 0-7 
    );
	
	 decod_base_3_8 upper (
        .in(in[2:0]),
        .en(enable_upper),
        .out(out_upper) //saida conecta os bits 8-15
    );
    
// juntando as saidas dos dois decods

    assign out = { out_lower,out_upper};
    
endmodule
