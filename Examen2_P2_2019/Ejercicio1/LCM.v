module LCM(
    input clk,
    input rst,
    input [31:0] n1,
    input [31:0] n2,
    output reg [31:0] result
);
reg [1:0] cs/*verilator public*/;
reg [1:0] ns;

reg [31:0] minmul;
reg [31:0] minmulp;

parameter inicio =2'd0;
parameter ciclo =2'd1;
parameter finalstate =2'd2;

always @(posedge clk) begin
    if(rst)
        cs<=inicio;
    else
        cs<=ns;
end

always @(posedge clk) begin
    minmul<=minmulp;
end


always @(*) begin
    case (cs)
        inicio: begin
                if(n1>n2)
                    minmulp=n1;
                else
                    minmulp=n2;
                ns=ciclo;    
                end
        ciclo: if((minmul%n1==0)&&(minmul%n2==0) )
                        ns=finalstate;
                else begin
                    minmulp=minmul+32'd1;
                    ns=ciclo;
                end
        finalstate: begin 
                          result=minmul;
                          ns=finalstate;
                    end

        default: 
                ns=2'bxx;
    endcase
end

endmodule // lcm