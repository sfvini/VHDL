vlib rtl_work
vmap work rtl_work 

vcom -93 -work work {../../ex_03.vhd}

vsim work.ex_03

add wave -position insertpoint  \
sim:/ex_03/clk \
sim:/ex_03/reset \
sim:/ex_03/up \
sim:/ex_03/load \
sim:/ex_03/entrada \
sim:/ex_03/q \
sim:/ex_03/r_reg \
sim:/ex_03/r_next

force -freeze sim:/ex_03/reset 1 0
force -freeze sim:/ex_03/up 1 0
force -freeze sim:/ex_03/load 0 0
force -freeze sim:/ex_03/entrada 00000000 0
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/reset 0 0


force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/entrada 10010110 0
force -freeze sim:/ex_03/load 1 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/load 0 0
run 10 ns

force -freeze sim:/ex_03/up 0 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/clk 1 0
run 10 ns
force -freeze sim:/ex_03/clk 0 0
run 10 ns

force -freeze sim:/ex_03/reset 1 0
run 10 ns