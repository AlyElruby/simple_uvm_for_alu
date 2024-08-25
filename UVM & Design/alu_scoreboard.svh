class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)
    uvm_analysis_export#(alu_transaction) sc_export;
    uvm_tlm_analysis_fifo#(alu_transaction) sc_fifo;
    alu_transaction trans;

    function new(string name , uvm_component parent);
        super.new(name, parent);
        trans = new("trans");
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sc_export = new("sc_export", this);
        sc_fifo = new("sc_fifo", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sc_export.connect(sc_fifo.analysis_export);
    endfunction: connect_phase

    task run();
        forever begin
            sc_fifo.get(trans);
            compare();
        end
    endtask : run

    virtual function void compare();
        bit [3:0] exepected, a, b;
        bit zero;
        a = trans.a;
        b = trans.b;
        begin
        case(trans.op)
                3'b000: exepected = a + b;
                3'b001: exepected = a - b;
                3'b010: exepected = a & b;
                3'b011: exepected = a | b;
                3'b100: exepected = a ^ b;
                3'b101: exepected = a << b;
                3'b110: exepected = a >> b;
                3'b111: exepected = (a > b)? 'b1 : 'b0; 
        endcase
        if(exepected == 0) zero = 1'b1;
        else zero = 1'b0;
        if((trans.result ==  exepected) && (trans.zero == zero)) begin
            `uvm_info("compare", {"Test: OK!"}, UVM_LOW);
        end
        else begin
            `uvm_info("compare", {"Test: Fail!"}, UVM_LOW);
        end
        end
    endfunction: compare
endclass: alu_scoreboard