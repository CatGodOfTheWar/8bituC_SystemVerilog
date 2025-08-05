module RAM32LocX8bit(
    input logic        clk,
    input logic        WE,
    input logic [4:0]  addr,
    input logic [7:0]  D,
    output logic [7:0] Q
);
    
    logic [7:0] mem [0:31];
    
    initial begin
        $readmemh("ram_init.mem", mem); 
    end
    
    always_ff @(posedge clk) begin 
        if(WE) 
            mem[addr] <= D;
        Q <= mem[addr];
    end
    
endmodule 