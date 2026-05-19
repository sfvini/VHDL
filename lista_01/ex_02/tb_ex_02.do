vlib rtl_work
vmap work rtl_work 
vcom -93 -work work {../../ex_02.vhd}
vsim work.ex_02

add wave -position insertpoint  \
sim:/ex_02/clk \
sim:/ex_02/reset \
sim:/ex_02/d \
sim:/ex_02/q \
sim:/ex_02/r_reg \
sim:/ex_02/r_next

force -freeze sim:/ex_02/reset 1 0
force -freeze sim:/ex_02/clk 0 0
run

force -freeze sim:/ex_02/reset 0 0
run

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run 

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run 

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run 

force -freeze sim:/ex_02/clk 1 0
run 
force -freeze sim:/ex_02/clk 0 0
run 

force -freeze sim:/ex_02/reset 1 0
run
