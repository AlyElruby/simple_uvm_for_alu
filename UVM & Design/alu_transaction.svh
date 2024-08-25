class alu_transaction extends uvm_sequence_item;
    rand bit [3:0] a,b;
    rand bit [2:0] op;
    bit [3:0] result;
    bit zero;
    //for customizing transaction methods
    `uvm_object_utils_begin(alu_transaction)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(op, UVM_ALL_ON)
        `uvm_field_int(result, UVM_ALL_ON)
        `uvm_field_int(zero, UVM_ALL_ON)
    `uvm_object_utils_end
    //basic constructor
    function new (string name = "");
        super.new(name);
    endfunction
endclass: alu_transaction