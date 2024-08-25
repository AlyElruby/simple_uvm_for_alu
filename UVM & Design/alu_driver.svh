class alu_driver extends uvm_driver#(alu_transaction);
    `uvm_component_utils(alu_driver)

    virtual alu_if vif;
    
    function new(string name , uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(virtual alu_if)::get(this, "*","vif",vif)) begin
            `uvm_info("driver","driver get the if successufly",UVM_LOW);
        end
        else begin
            `uvm_fatal("driver", "couldn't get the if");
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        alu_transaction trans;
        vif.rst = 1;
        #5 vif.rst = 0;

        forever begin
            seq_item_port.get_next_item(trans);
            
            vif.a = trans.a;
            vif.b = trans.b;
            vif.op = trans.op;
            #5; 
            seq_item_port.item_done();
        end
    endtask: run_phase
endclass: alu_driver