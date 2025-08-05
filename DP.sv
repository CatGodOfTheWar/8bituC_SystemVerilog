module DP(
    input logic        Clk,
    input logic        IRload,
    input logic        JMPmux,
    input logic        PCload,
    input logic        Meminst,
    input logic        MemWr,
    input logic        Aload,
    input logic        Reset,
    input logic        Sub,
    input logic [1:0]  Asel,
    input logic [7:0]  Data_input,
    output logic       Aeq0,
    output logic       Apos,
    output logic [2:0] IR,
    output logic [7:0] Data_output
    );
    
    logic [7:0] Mux4to1_out;
    logic [7:0] Adder8bit_out;
    logic [7:0] RAM_out;
    logic [4:0] Mux2to1_addr_out;
    logic [4:0] Mux2to1_jmp_out;
    logic [4:0] Register5bit_out;
    logic [4:0] Incr5bit_out;
    logic [7:0] Register8bit_out;
    logic [4:0] IR_intern;
    
    Mux4to1 U1 (
        .sel(Asel),
        .A(Adder8bit_out),
        .B(Data_input),
        .C(RAM_out),
        .D(8'h00),
        .E(Mux4to1_out)
    );
    
    Register8bit U2 (
        .clk(Clk),
        .clear(Reset),
        .load(Aload),
        .D(Mux4to1_out),
        .Q(Data_output)
    );
    
    Adder8bit U3 (
        .sub(Sub),
        .A(Data_output),
        .B(RAM_out),
        .C(Adder8bit_out)
    ); 
    
    RAM32LocX8bit U4 (
        .clk(Clk),
        .WE(MemWr),
        .addr(Mux2to1_addr_out),
        .D(Data_output),
        .Q(RAM_out)
    );
    
    Mux2to1 U5 (
        .sel(Meminst),
        .A(Register5bit_out),
        .B(IR_intern),
        .C(Mux2to1_addr_out)
    );
    
    Register5bit U6 (
        .clk(Clk),
        .clear(Reset),
        .load(PCload),
        .D(Mux2to1_jmp_out),
        .Q(Register5bit_out)
    );
    
    Mux2to1 U7 (
        .sel(JMPmux),
        .A(Incr5bit_out),
        .B(IR_intern),
        .C(Mux2to1_jmp_out)
    );
    
    Incr5bit U8 (
        .D(Register5bit_out),
        .Q(Incr5bit_out)
    );
    
    Register8bit U9 (
        .clk(Clk),
        .clear(Reset),
        .load(IRload),
        .D(RAM_out),
        .Q(Register8bit_out)
    );
    
    assign IR = Register8bit_out[7:5];
    assign IR_intern = Register8bit_out[4:0];
    assign Aeq0 = ~|Data_output;
    assign Apos = ~Data_output[7];
    
        
endmodule
