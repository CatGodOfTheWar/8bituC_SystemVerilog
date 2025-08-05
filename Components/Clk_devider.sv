module Clk_devider(
    input logic  Clk_in,
    output logic Clk_out
    );
    
    logic [24:0] counter = 25'd0;
    
    always_ff @(posedge Clk_in) begin 
        if(counter == 24_999_999) begin
            Clk_out <= ~Clk_out;
            counter <= 25'd0;
        end else begin 
            counter <= counter + 1;
        end
    end 
    
endmodule
