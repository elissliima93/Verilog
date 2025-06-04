module bcd_para_excesso3 (
    input clk,
    input reset,
    input Bin,           // Entrada serial (bit a bit)
    output reg Bout      // Saída serial (Excesso-3)
);

    // Codificação de estados
    parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4,
              S5 = 3'd5, S6 = 3'd6, S7 = 3'd7, S8 = 3'd8, S9 = 3'd9;

    reg [3:0] shift_reg = 4'b0000;
    reg [2:0] state, next_state;

    // Registrador de deslocamento (entrada BCD)
    always @(posedge clk or posedge reset) begin
        if (reset)
            shift_reg <= 0;
        else
            shift_reg <= {Bin, shift_reg[3:1]}; // shift com LSB primeiro
    end

    // Máquina de estados
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Próximo estado
    always @(*) begin
        case (state)
            S0: next_state = shift_reg == 4'd0 ? S0 :
                             shift_reg == 4'd1 ? S1 :
                             shift_reg == 4'd2 ? S2 :
                             shift_reg == 4'd3 ? S3 :
                             shift_reg == 4'd4 ? S4 :
                             shift_reg == 4'd5 ? S5 :
                             shift_reg == 4'd6 ? S6 :
                             shift_reg == 4'd7 ? S7 :
                             shift_reg == 4'd8 ? S8 :
                             shift_reg == 4'd9 ? S9 : S0;
            default: next_state = S0;
        endcase
    end

    // Saída serial (Excesso-3 = valor + 3)
    always @(*) begin
        case (state)
            S0: Bout = 3 + 4'd0 >> 0;
            S1: Bout = 3 + 4'd1 >> 0;
            S2: Bout = 3 + 4'd2 >> 0;
            S3: Bout = 3 + 4'd3 >> 0;
            S4: Bout = 3 + 4'd4 >> 0;
            S5: Bout = 3 + 4'd5 >> 0;
            S6: Bout = 3 + 4'd6 >> 0;
            S7: Bout = 3 + 4'd7 >> 0;
            S8: Bout = 3 + 4'd8 >> 0;
            S9: Bout = 3 + 4'd9 >> 0;
            default: Bout = 0;
        endcase
    end

endmodule
