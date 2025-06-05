

module semaforo_fsm (
    input clk,
    input reset,
    input [2:0] sensor,
    output reg [1:0] cancela,
    output reg [1:0] semaforo
	
);

    // Codificação dos estados
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100,
              S5 = 3'b101;

    reg [2:0] state, next_state;

    // Estado atual
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica de transição de estados
    always @(*) begin
        case (state)
			
			
           // S0: next_state = (sensor == 3'b001) ? S1 : S0; //d1 =1 //--->
			 S0: if(sensor == 3'b001) begin 
					next_state = S1; // se d=1 //--->
			end else if( sensor == 3'b101) begin
					next_state = S5; // se d=5 //<----
			end	else begin
					next_state = S0; 
		    end
			
            S1: next_state = (sensor == 3'b010) ? S2 : S1; //d2 =1 //--->
			
           // S2: next_state = (x == 3'b011) ? S3 : S2;// d3=1
		    S2: if(sensor == 3'b011) begin 
					next_state = S3; // se d3=1 //--->
			end else if( sensor == 3'b110) begin
					next_state = S0; // se d6=1 //<----
			end	else begin
					next_state = S2; 
		    end
			
			
           //S3: next_state = (x == 3'b100) ? S4 : S3; //d4=1
			S3: if(sensor == 3'b001) begin 
					next_state = S4; // se d4=1 //--->
			end else if( sensor == 3'b010) begin
					next_state = S2; // se d2=1 //<----
			end	else begin
					next_state = S3; 
		    end
			
			
            S4: if(sensor == 3'b001) begin 
					next_state = S1; // se d=1 //--->
			end else if( sensor == 3'b101) begin
					next_state = S5; // se d=5 //<----
			end	else begin
					next_state = S4; 
		    end
			
			
			//sentido da direita pra esquerda
			S5: next_state = (sensor == 3'b011) ? S3 : S5; //d3=1 //<----
			
			
            default: next_state = S0;
        endcase
    end

    // Lógica de saída Mealy
    always @(*) begin
        case (state)
           // S3: y = (sensor == 3'b100) ? 1'b1 : 1'b0; // detecta 1101
           //S4: y = (sensor == 3'b000) ? 1'b1 : 1'b0; // detecta 1110
		   
		    S0: if(sensor == 3'b001) begin // se d=1 --->
					cancela = 2'b01; 
					semaforo = 2'b01; 
					
			end else if(sensor == 3'b101) begin // se d=5 //<----
					 cancela = 2'b01; 
					semaforo = 2'b00; //ambos desligados
			end	else begin
					cancela = 2'b00; 
					semaforo = 2'b00;
		    end
			
	 // S1: next_state = (sensor == 3'b010) ? S2 : S1; //d2 =1 //--->
		S1: if(sensor == 3'b010) begin // se d2=1 --->
					cancela = 2'b00; 
					semaforo = 2'b00; 
					
			end	else begin // mantem a saida do estado anterior
					cancela = 2'b01; 
					semaforo = 2'b01;
		    end
			
		S2: if(sensor == 3'b011) begin // se d3=1 --->
					cancela = 2'b10; 
					semaforo = 2'b00;
			end else if( sensor == 3'b110) begin // se d6=1 <----
					cancela = 2'b00; 
					semaforo = 2'b00;
			end	else begin
					cancela = 2'b00; 
					semaforo = 2'b00;
		    end
			
		S3: if(sensor == 3'b001) begin // se d4=1 --->
					cancela = 2'b00; 
					semaforo = 2'b00;
			end else if( sensor == 3'b010) begin // se d2=1 <----
					cancela = 2'b10; 
					semaforo = 2'b00;
			end	else begin
					cancela = 2'b00; 
					semaforo = 2'b00;
		    end	
			
		 S4: if(sensor == 3'b001) begin // se d1=1 //--->
					cancela = 2'b01; 
					semaforo = 2'b01;
			end else if( sensor == 3'b101) begin // se d=5 //<----
				    cancela = 2'b10; 
					semaforo = 2'b10;
			end	else begin
					cancela = 2'b00; 
					semaforo = 2'b00; 
		    end	
			
		// S5: next_state = (sensor == 3'b011) ? S3 : S5; //d3=1 //<----
		  S5: if(sensor == 3'b011) begin // <---- d3=1
					cancela = 2'b00; 
					semaforo = 2'b00;
			end	else begin
					cancela = 2'b00; 
					semaforo = 2'b00; 
		    end	
           default: begin
			cancela = 2'b00;
			semaforo = 2'b00;
			end
			
        endcase
    end

endmodule