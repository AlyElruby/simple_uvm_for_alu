class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor);
    uvm_analysis_port#(alu_transaction) mon;
    virtual alu_if vif;
    alu_transaction cov;
    covergroup alu_cg;
        in_a: coverpoint cov.a;
        in_b: coverpoint cov.b;
        in_op: coverpoint cov.op;
    endgroup
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
        alu_cg =  new;
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(virtual alu_if)::get(this,"*","vif",vif)) begin
            `uvm_info("monitor","if connected successfully",UVM_LOW);
        end
        else begin
            `uvm_fatal("monitor","if isnot connected");
        end
        mon = new(.name("mon"), .parent(this));
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        alu_transaction trans;
        trans = alu_transaction::type_id::create(.name("trans"),.contxt(get_full_name()));
        #7;
        forever begin
            #5;
            trans.a= vif.a;
            trans.b = vif.b;
            trans.op= vif.op;
            trans.zero= vif.zero;
            trans.result= vif.result;
            cov = trans;
            alu_cg.sample();
            mon.write(trans);
        end
    endtask: run_phase
endclass: alu_monitor