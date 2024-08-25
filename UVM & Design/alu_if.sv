interface alu_if;
    logic [3:0] a,b;
    logic [2:0] op ;
    logic       rst;

    logic [3:0] result;
    logic       zero;
endinterface //alu_if