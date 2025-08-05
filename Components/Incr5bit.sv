module Incr5bit(
    input logic  [4:0] D,
    output logic [4:0] Q
);
    always_comb begin
        Q = D + 1;
    end

endmodule 