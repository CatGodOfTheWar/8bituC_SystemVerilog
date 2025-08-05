module Mux4to1(
    input logic [1:0] sel,
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [7:0] C,
    input logic [7:0] D,
    output logic [7:0] E
);

    always_comb begin 
        case(sel) 
            2'd0: E = A;
            2'd1: E = B; 
            2'd2: E = C;
            2'd3: E = D;
            default: E = 8'h00;
        endcase
    end

endmodule



