module Mux_Seg(
    input logic        Clk,
    input logic [7:0]  Data_input,
    output logic [6:0] Seg_out,
    output logic [2:0] Digit_select
    );
    
    logic [3:0] Units_digit;
    logic [3:0] Tens_digit;
    logic [3:0] Hunderds_digit;
    logic [1:0] Current_digit;
    logic [3:0] BCD_current;
    
    always_comb begin
        Hunderds_digit = Data_input / 100;
        Tens_digit =     (Data_input % 100) / 10;
        Units_digit =    Data_input % 10;
    end
    
    always_ff @(posedge Clk) begin 
        if(Current_digit == 2'd2) 
            Current_digit <= 2'd0;
        else
            Current_digit <= Current_digit + 1;
    end
    
    always_comb begin 
        case(Current_digit)
            2'd0: BCD_current = Units_digit;
            2'd1: BCD_current = Tens_digit;
            2'd2: BCD_current = Hunderds_digit;
            default: BCD_current = 4'd0;
        endcase 
    end
    
    always_comb begin 
        Digit_select = 3'b111;
        Digit_select[Current_digit] = 1'b0;
    end
    
    
    BCD_7Seg U1 (
        .Binary_input(BCD_current),
        .Seg_out(Seg_out)
    );
    
    
    
endmodule
