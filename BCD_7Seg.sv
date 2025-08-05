module BCD_7Seg(
    input logic [3:0]  Binary_input,
    output logic [6:0] Seg_out
    );
    
    const logic [6:0] Seg_lut [0:15] = {
        7'b0000001, // 0
        7'b1001111, // 1
        7'b0010010, // 2
        7'b0000110, // 3
        7'b1001100, // 4
        7'b0100100, // 5
        7'b0100000, // 6
        7'b0001111, // 7
        7'b0000000, // 8
        7'b0000100, // 9
        7'b1111111, // 10 - blank/error
        7'b1111111, // 11 - blank/error
        7'b1111111, // 12 - blank/error
        7'b1111111, // 13 - blank/error
        7'b1111111, // 14 - blank/error
        7'b1111111  // 15 - blank/error
    };
    
    assign Seg_out = Seg_lut[Binary_input];
    
endmodule
