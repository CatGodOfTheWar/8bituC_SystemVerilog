module Register8bit(
    input logic  clk, 
    input logic  clear, 
    input logic  load,
    input logic  [7:0] D,
    output logic [7:0] Q
    );

    always_ff @(posedge clk or posedge clear) begin
        if(clear)
            Q <= '0;
        else if(load)
            Q <= D;
    end

endmodule
