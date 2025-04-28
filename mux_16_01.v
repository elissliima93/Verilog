module mux8x1 (
 input [3:0] Sel, // Entradas de seleção S[2:0]
 input [15:0] Dados, // Entradas de dados D[7:0]
 output reg Y // Saída Y
 );

		always @(*) begin
			case (Sel)
				4'b0000: Y = Dados[0];
				4'b0001: Y = Dados[1];
				4'b0010: Y = Dados[2];
				4'b0011: Y = Dados[3];
				4'b0100: Y = Dados[4];
				4'b0101: Y = Dados[5];
				4'b0110: Y = Dados[6];
				4'b0111: Y = Dados[7];
				4'b1000: Y = Dados[8];
				4'b1001: Y = Dados[9];
				4'b1010: Y = Dados[10];
				4'b1011: Y = Dados[11];
				4'b1100: Y = Dados[12];
				4'b1101: Y = Dados[13];
				4'b1111: Y = Dados[14];
			endcase 
		end
 endmodule
 
 