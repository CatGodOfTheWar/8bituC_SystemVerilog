module Mux2to1(
    input logic        sel,
    input logic [4:0]  A,
    input logic [4:0]  B,
    output logic [4:0] C
);

    always_comb begin 
        C = sel? B : A;
    end

endmodule