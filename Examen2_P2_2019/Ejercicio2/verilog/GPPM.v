module GPPM(
    input clk,
    input [3:0] raddr1,
    input [3:0] raddr2,
    input wen,
    input [3:0] waddr,
    input wdsrc,
    input [3:0] func,
    input [31:0] constant,
    input alusrc,
    input [31:0] aluconst,
    output [31:0] outrdata1,
    output isZero
);

    wire [31:0] rdata1;
    wire [31:0] rdata2;
    wire [31:0] wdata;
    wire [31:0] ares;
    wire [31:0] alu_op2;

    assign wdata = (wdsrc)? ares : constant;
    assign outrdata1 = rdata1;
    assign alu_op2 = alusrc? aluconst : rdata2;

    RegFile rf (
        .clk (clk),
        .raddr1 (raddr1),
        .raddr2 (raddr2),
        .wen (wen),
        .waddr (waddr),
        .wdata (wdata),
        .rdata1 (rdata1),
        .rdata2 (rdata2)
    );

    ALU alu (
        .a (rdata1),
        .b (alu_op2),
        .func (func),
        .res (ares),
        .isZero (isZero)
    );
endmodule