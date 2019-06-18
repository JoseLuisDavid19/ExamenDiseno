module LCMMain(
    input clk,
    input rst,
    input [31:0] n1,
    input [31:0] n2,
    output [31:0] result
);
    wire [3:0] raddr1;
    wire [3:0] raddr2;
    wire isZero;
    wire wen;
    wire [3:0] waddr;
    wire wdsrc;
    wire [3:0] func;
    wire [31:0] constant;
    wire alusrc;
    wire [31:0] aluconst;

    LCMFSM fsm (
        .clk (clk),
        .rst (rst),
        .isZero (isZero),
        .n1 (n1),
        .n2 (n2),
        .raddr1 (raddr1),
        .raddr2 (raddr2),
        .wen (wen),
        .waddr (waddr),
        .wdsrc (wdsrc),
        .func (func),
        .constant (constant),
        .alusrc(alusrc),
        .aluconst(aluconst)
    );

    GPPM gppm (
        .clk (clk),
        .raddr1 (raddr1),
        .raddr2 (raddr2),
        .wen (wen),
        .waddr (waddr),
        .wdsrc (wdsrc),
        .func (func),
        .constant (constant),
        .alusrc(alusrc),
        .aluconst(aluconst),
        .isZero (isZero),
        .outrdata1(result)
    );
endmodule
