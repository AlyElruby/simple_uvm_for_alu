if [file exists "work"] {vdel -all}
vlib work
# SystemVerilog DUT
vlog alu.v  +cover -covercells
vlog -f tb.f
vsim  -coverage -cover -t  10ns -novopt work.tb +UVM_TESTNAME=alu_test

set NoQuitOnFinish 1
onbreak {resume}
coverage report -codeAll -cvg -verbose -o cover.txt
log /* -r

run -a
