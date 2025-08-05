module One_shot(
    input logic Clk,
    input logic Btn_input,
    output logic Pulse_out
    );
    
    logic Btn_input_prev;
    
    always_ff @(posedge Clk) begin
        Pulse_out <= Btn_input & ~Btn_input_prev;
        Btn_input_prev <= Btn_input;
    end
    
endmodule
