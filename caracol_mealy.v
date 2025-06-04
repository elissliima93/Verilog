//Alterar o exemplo do caracol rob�tico para que o c�rebro do mesmo 
//seja uma FSM de Mealy cuja sa�da y = 1 quando o caracol deslizar 
//sobre o padr�o 1101 ou 1110. Esbo�ar o diagrama de estados e 
//implementar a FSM em HDL usando o menor n�mero poss�vel de 
//estados

module caracol_mealy (
    input clk,
    input reset,
    input x,
    output reg y
);

    // Codifica��o dos estados
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state, next_state;

    // Estado atual
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // L�gica de transi��o de estados
    always @(*) begin
        case (state)
            S0: next_state = (x == 1'b1) ? S1 : S0;
            S1: next_state = (x == 1'b1) ? S2 : S0;
            S2: next_state = (x == 1'b0) ? S3 : S4;
            S3: next_state = (x == 1'b1) ? S1 : S0;
            S4: next_state = (x == 1'b0) ? S3 : S4;
			
			
            default: next_state = S0;
        endcase
    end

    // L�gica de sa�da Mealy
    always @(*) begin
        case (state)
            S3: y = (x == 1'b1) ? 1'b1 : 1'b0; // detecta 1101
            S4: y = (x == 1'b0) ? 1'b1 : 1'b0; // detecta 1110
            default: y = 1'b0;
        endcase
    end

endmodule

