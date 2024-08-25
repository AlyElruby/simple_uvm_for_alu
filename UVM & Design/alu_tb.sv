`include "alu_pkg.sv"
`include "alu_if.sv"
`include "alu.v"

module tb();
    import uvm_pkg::*;
    import alu_pkg::*;

    alu_if vif();

    alu dut(vif.a, vif.b, vif.op, vif.rst, vif.result, vif.zero);

    initial begin
        uvm_config_db#(virtual alu_if)::set(null, "*" , "vif",vif);
        run_test();
    end
endmodule