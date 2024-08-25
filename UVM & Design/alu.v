module alu (
    input wire [3:0] a,b,
    input wire [2:0] op,
    input wire rst,
    output reg [3:0] result,
    output wire zero
);
    assign zero = (result == 'b0)? 1'b1 : 1'b0;
    
    always @(*) begin
        if(rst)
            result = 'b0;
        else begin 
            case(op)
                3'b000: result = a + b;
                3'b001: result = a - b;
                3'b010: result = a & b;
                3'b011: result = a | b;
                3'b100: result = a ^ b;
                3'b101: result = a << b;
                3'b110: result = a >> b;
                3'b111: result = (a > b)? 'b1 : 'b0; 
            endcase
        end
    end
endmodule