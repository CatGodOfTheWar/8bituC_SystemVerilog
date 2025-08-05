module EC_2_fpga(
    input logic        Reset,
    input logic        Enter,
    input logic        Clk,
    input logic [7:0]  Data_input,
    output logic       Halt,
    output logic [6:0] Segs,
    output logic [2:0] Digit_select
    );
    
    logic One_shot_enter;
    logic Clk_out_devider;
    logic [7:0] Data_output_EC_2;
    
    EC_2 U1 (
        .Enter(One_shot_enter),
        .Clk(Clk_out_devider),
        .Reset(Reset),
        .Data_input(Data_input),
        .Halt(Halt),
        .Data_output(Data_output_EC_2)
    );
    
    One_shot U2 (
        .Clk(Clk),
        .Btn_input(Enter),
        .Pulse_out(One_shot_enter)
    );
    
    Clk_devider U3 (
        .Clk_in(Clk),
        .Clk_out(Clk_out_devider) 
    );
    
    Mux_Seg U4 (
        .Clk(Clk),
        .Data_input(Data_output_EC_2),
        .Seg_out(Segs),
        .Digit_select(Digit_select)
    );
    
    
endmodule
