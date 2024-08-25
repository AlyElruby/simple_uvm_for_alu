class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)
    uvm_analysis_port#(alu_transaction) agent_mon;

    alu_sequencer seqr;
    alu_driver drv;
    alu_monitor mtr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr = alu_sequencer::type_id::create(.name("seqr"), .parent(this));
        drv = alu_driver::type_id::create(.name("drv"), .parent(this));
        mtr = alu_monitor::type_id::create(.name("mtr"), .parent(this));

        agent_mon = new(.name("agent_mon"), .parent(this));
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        drv.seq_item_port.connect(seqr.seq_item_export);
        mtr.mon.connect(agent_mon);
    endfunction : connect_phase
endclass: alu_agent