transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Temp/verilog_examples/floating_point_comparator {../../floating_point_comparator.v}
vlog -vlog01compat -work work +incdir+C:/Temp/verilog_examples/floating_point_comparator {../../sign_comparator.v}

vlog -vlog01compat -work work +incdir+C:/Temp/verilog_examples/floating_point_comparator/simulation/modelsim {floating_point_comparator.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  floating_point_comparator_tst

#add wave *
do wave.do
view structure
view signals
view variables
run 200 ns
