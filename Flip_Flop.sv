module Flip_Flop(
    input logic        clk,
    input logic        clear,
    input logic [7:0]  D,
    output logic [7:0] Q,
    output logic [7:0] Q_bar
    );
    
    always_ff @(posedge clk or posedge clear) begin 
        if(clear) 
            Q <= 8'h00;
        else 
            Q <= D;
    end
    
    assign Q_bar = ~Q;
    
endmodule
