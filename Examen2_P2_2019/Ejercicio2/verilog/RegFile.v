module RegFile(
    input clk,
    input [3:0] raddr1,
    input [3:0] raddr2,
    input wen,
    input [3:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
);
    reg [31:0] memory [0:15];
    
    assign rdata1 = memory[raddr1];
    assign rdata2 = memory[raddr2];
    
    always @ (posedge clk) begin
        if (wen)
            memory[waddr] <= wdata;
    end
    
endmodule
