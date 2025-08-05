module CU(
    input logic        Enter,
    input logic        Clk,
    input logic        Reset,
    input logic        Aeq0,
    input logic        Apos,
    input logic [2:0]  IR,
    output logic       IRload,
    output logic       JMPmux,
    output logic       PCload,
    output logic       Meminst,
    output logic       MemWr,
    output logic [1:0] Asel,
    output logic       Aload,
    output logic       Sub,
    output logic       Halt
    );
    
    logic [3:0] Q;
    logic [3:0] Q_bar;
    wire [4:0] and_gate_g;
    wire [3:0] or_gate_ff;
    wire [2:0] and_gate_ff;
    wire [1:0] and_gate_jmp_pc;
    wire [1:0] and_gate_pc;
    wire and_gate_Meminst;
    wire [1:0] and_gate_Aload;
    
    Flip_Flop U0 (
        .clk(Clk),
        .clear(Reset),
        .D(or_gate_ff[0]),
        .Q(Q[0]),
        .Q_bar(Q_bar[0])
    );
    
    Flip_Flop U1 (
        .clk(Clk),
        .clear(Reset),
        .D(or_gate_ff[1]),
        .Q(Q[1]),
        .Q_bar(Q_bar[1])
    );
    
    Flip_Flop U2 (
        .clk(Clk),
        .clear(Reset),
        .D(or_gate_ff[2]),
        .Q(Q[2]),
        .Q_bar(Q_bar[2])
    );
    
    Flip_Flop U3 (
        .clk(Clk),
        .clear(Reset),
        .D(or_gate_ff[3]),
        .Q(Q[3]),
        .Q_bar(Q_bar[3])
    );
    
    assign or_gate_ff[3] = and_gate_g[4] | and_gate_g[3] | and_gate_g[2];
    assign or_gate_ff[2] = and_gate_g[2] | and_gate_ff[2] | and_gate_g[4];
    assign or_gate_ff[1] = and_gate_g[1] | and_gate_ff[1] | and_gate_g[4];
    assign or_gate_ff[0] = and_gate_g[0] | and_gate_ff[0] | and_gate_g[4];
    assign and_gate_ff[2] = and_gate_g[3] & IR[2];
    assign and_gate_ff[1] = and_gate_g[3] & IR[1];
    assign and_gate_ff[0] = and_gate_g[3] & IR[0];
    assign and_gate_g[4] = Q[0] & Q[1] & Q[2] & Q[3];
    assign and_gate_g[3] = Q_bar[0] & Q[1] & Q_bar[2] & Q_bar[3];
    assign and_gate_g[2] = Q_bar[0] & Q_bar[1] & Q[2] & Q[3] & ~Enter;
    assign and_gate_g[1] = Q[0] & Q_bar[1] & Q_bar[2] & Q_bar[3];
    assign and_gate_g[0] = Q_bar[0] & Q_bar[1] & Q_bar[2] & Q_bar[3];
    assign IRload = Q_bar[3] & Q_bar[2] & Q_bar[1] & Q[0];
    assign and_gate_jmp_pc[1] = Q[3] & Q[2] & Q_bar[1] & Q[0];
    assign and_gate_jmp_pc[0] = Q[3] & Q[2] & Q[1] & Q_bar[0];
    assign JMPmux = and_gate_jmp_pc[1] | and_gate_jmp_pc[0];
    assign and_gate_pc[1] = and_gate_jmp_pc[1] & Aeq0;
    assign and_gate_pc[0] = and_gate_jmp_pc[0] & Apos;
    assign PCload = IRload | and_gate_pc[1] | and_gate_pc[0];
    assign and_gate_Meminst = Q_bar[3] & Q_bar[2] & Q[1] & Q_bar[0];
    assign MemWr = Q[3] & Q_bar[2] & Q_bar[1] & Q[0];
    assign Meminst = and_gate_Meminst | MemWr;
    assign Asel[1] = Q[3] & Q_bar[2] & Q_bar[1] & Q_bar[0];
    assign Asel[0] = Q[3] & Q[2] & Q_bar[1] & Q_bar[0];
    assign and_gate_Aload[1] = Q[3] & Q_bar[1] & Q_bar[0];
    assign and_gate_Aload[0] = Q[3] & Q_bar[2] & Q[1];
    assign Aload = and_gate_Aload[1] | and_gate_Aload[0];
    assign Sub = Q[3] & Q_bar[2] & Q[1] & Q[0];
    assign Halt = Q[3] & Q[2] & Q[1] & Q[0];
    
endmodule
