`include "ALU_Opcodes.vh"
module LCMFSM(
    input clk,
    input rst,
    input [31:0]n1,
    input [31:0]n2,
    input [31:0] outrdata1,
    input isZero,
    output reg [3:0] raddr1,
    output reg [3:0] raddr2,
    output reg wen,
    output reg [3:0] waddr,
    output reg wdsrc,
    output reg [3:0] func,
    output reg [31:0] constant,
    output reg alusrc,
    output reg [31:0] aluconst
);
reg [2:0] cs/*verilator public*/;
reg [2:0] ns;


always @(posedge clk) begin
    if(rst)
        cs<=3'd0;
    else
        cs<=ns;
end

always @(*) begin
    case (cs)
        3'd0:ns=3'd1;
        3'd1:ns=3'd2;
        3'd2:ns=3'd3;
        3'd3:ns=3'd4;
        3'd5:ns=3'd5;
        default: ns=3'bxxx;
    endcase
end

always @(*) begin
    case (cs)
        3'd0:begin
        wen=1'b1;
        wdsrc=1'b0;
        constant=n1;
        waddr=4'd0;
        end
        3'd1:begin 
        wen=1'b1;
        wdsrc=1'b0;
        constant=n2;
        waddr=4'd1;
        end

        3'd2:begin 
        wen=1'b1;
        wdsrc=1'b0;
        if(n1>n2)
            constant=n1;
        else
            constant=n2;    
        waddr=4'd2;
        
        end

        3'd3:begin 
        wen=1'b1;
        wdsrc=1'b1;
        func=`MOD;
        raddr1=4'd2;
        raddr2=4'd0;
        alusrc=1'b0;
        waddr=4'd3;
        
        end

         3'd4:begin 
         if(isZero)begin
                wen=1'b1;
                wdsrc=1'b1;
                func=`MOD;
                raddr1=4'd2;
                raddr2=4'd1;
                alusrc=1'b0;
                waddr=4'd4;
         end       
         else begin
                wen=1'b1;
                wdsrc=1'b1;
                func=`ADD;
                raddr1=4'd2;
                aluconst=32'd1;
                alusrc=1'b1;
                waddr=4'd2;
            end
        end
        3'd5:begin
            if(isZero) begin
            raddr1=4'd2; 
            end
            else begin
             wen=1'b1;
                wdsrc=1'b1;
                func=`ADD;
                raddr1=4'd2;
                aluconst=32'd1;
                alusrc=1'b1;
                waddr=4'd2;
                
            end
        end

        default: begin
      raddr1=4'dx;
      raddr2=4'dx;
      wen=1'bx;
      waddr=4'dx;
      wdsrc=1'bx;
      func=4'dx;
      constant=32'dx;
      alusrc=1'bx;
      aluconst=32'dx;
      end
    endcase
end

endmodule // LCMFSM