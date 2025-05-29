 

//implemente em Verilog um PWM com período de 10 us a partir de uma 
//frequência de clock de 100 MHz. Utilize uma entrada de 4 bits para selecionar 10 
//valores de duty cycle entre 0% e 100% com passos de 10%.


module pwm (
	input clk,
	input reset,
	input[3:0] duty,
	output reg pwm_out
	);
	
	
	// constante para o período (999 em binário)
	localparam [9:0] periodo = 10'b1111100111;
	
	reg[9:0] preset;
	reg[9:0] cnt;
	
	// mux para o preset basado no duty cycle
	
	always@(*) begin
		case (duty)
			4'b1010: preset =10'b1111111111; //100%=1023
			4'b1001: preset =10'b1110011011; // 90%=923
			4'b1000: preset =10'b1100110011; // 80%=819
			4'b0111: preset =10'b1011001101; // 70%=717
			4'b0110: preset =10'b1001100110; // 60%=614
			4'b0101: preset =10'b1000000000; // 50%=515
			4'b0100: preset =10'b0110011010; // 40%=410
			4'b0011: preset =10'b0100110011; // 30%=307
			4'b0010: preset =10'b0011001101; // 20%=205
			4'b0001: preset =10'b0001100110; // 10%=102
			default: preset= 10'b0000000000; // 0% off
			
		endcase
	end
	
// processo do contador

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cnt <= 10'b0000000000;
		end else begin
			if (cnt == periodo) begin
				cnt <= 10'b0000000000;
			end else begin
				cnt <= cnt + 1;
			end
		end
	end
	
	
	always @(posedge clk) begin
		if (cnt<preset) 
			pwm_out <= 1;
		else 
			pwm_out <= 0;
		 
	end
	
	
endmodule 