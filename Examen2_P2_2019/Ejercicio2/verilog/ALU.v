`include "ALU_Opcodes.vh"

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] func,
    output reg [31:0] res,
    output isZero
);

    assign isZero = ~|res;

    always @ (*) begin
    case (func)
        `ADD: res = a + b;
        `SUB: res = a - b;
        `MUL: res = a * b;
        `DIV: res = a / b;
        `MOD: res = a % b;
        `AND: res = a & b;
        `OR: res = a | b;
        `XOR: res = a ^ b;
        `NOT: res = ~a;
        `SHL: res = a << b;
        `SHR: res = a >> b;
        `SLT: res = {31'h0, $signed(a) < $signed(b)};
        `SLTU: res = {31'h0, a < b};
        default:
            res = 32'hx;
    endcase
end

endmodule
