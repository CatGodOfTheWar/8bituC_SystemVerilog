module EC_2(
    input logic        Enter,
    input logic        Clk,
    input logic        Reset, 
    input logic [7:0]  Data_input,
    output logic       Halt,
    output logic [7:0] Data_output
    );
    
    logic       Aeq0;
    logic       Apos;
    logic [2:0] IR;
    logic       IRload;
    logic       JMPmux;
    logic       PCload;
    logic       Meminst;
    logic       MemWr;
    logic [1:0] Asel;
    logic       Aload;
    logic       Sub;
    
    CU U1 (
        .Enter(Enter),
        .Clk(Clk),
        .Reset(Reset),
        .Aeq0(Aeq0),
        .Apos(Apos),
        .IR(IR),
        .IRload(IRload),
        .JMPmux(JMPmux),
        .PCload(PCload),
        .Meminst(Meminst),
        .MemWr(MemWr),
        .Asel(Asel),
        .Aload(Aload),
        .Sub(Sub),
        .Halt(Halt)  
    );
    
    DP U2 (
        .Clk(Clk),
        .IRload(IRload),
        .JMPmux(JMPmux),
        .PCload(PCload),
        .Meminst(Meminst),
        .MemWr(MemWr),
        .Aload(Aload),
        .Reset(Reset),
        .Sub(Sub),
        .Asel(Asel),
        .Data_input(Data_input),
        .Aeq0(Aeq0),
        .Apos(Apos),
        .IR(IR),
        .Data_output(Data_output)
    );
    
endmodule
