class alu_sequence extends uvm_sequence#(alu_transaction);
    //factory registeration
    `uvm_object_utils(alu_sequence)
    //basic constructor
    function new(string name ="");
        super.new(name);
    endfunction
    
    task body();
        alu_transaction trans;

        repeat(100) begin
            trans = alu_transaction::type_id::create(.name("trans"), .contxt(get_full_name()));
            start_item(trans);
            assert(trans.randomize()) //`uvm_info("sequence", "randomize success",UVM_HIGH);
            //else  `uvm_warning("sequence","faild to randomize")
            finish_item(trans);
        end
    endtask: body
endclass: alu_sequence

typedef uvm_sequencer#(alu_transaction) alu_sequencer;