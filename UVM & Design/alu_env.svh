class alu_env extends uvm_env;
    `uvm_component_utils(alu_env)

    alu_agent agent;
    alu_scoreboard score;

    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = alu_agent::type_id::create(.name("agent"), .parent(this));
        score = alu_scoreboard::type_id::create(.name("score"), .parent(this));
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.agent_mon.connect(score.sc_export);
    endfunction: connect_phase
endclass :alu_env