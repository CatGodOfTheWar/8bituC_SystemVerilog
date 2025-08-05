module Adder8bit(
    input logic        sub,
    input logic [7:0]  A,
    input logic [7:0]  B,
    output logic [7:0] C
);

    always_comb begin 
        C = A + (sub ? -B : B);
    end 
    
endmodule 