add wave -position insertpoint  \
sim:/flipflop/clk \
sim:/flipflop/d \
sim:/flipflop/reset \
sim:/flipflop/enable \
sim:/flipflop/q

force -freeze sim:/flipflop/reset 1 0
force -freeze sim:/flipflop/clk 0 0
force -freeze sim:/flipflop/enable 0 0
force -freeze sim:/flipflop/d 0 0
run 20ns

force -freeze sim:/flipflop/reset 0 0
force -freeze sim:/flipflop/enable 1 0
force -freeze sim:/flipflop/d 1 0
run 10ns
force -freeze sim:/flipflop/clk 1 0
run 20ns 

force -freeze sim:/flipflop/clk 0 0
force -freeze sim:/flipflop/enable 0 0
force -freeze sim:/flipflop/d 0 0
run 20ns
force -freeze sim:/flipflop/clk 1 0
run 20ns

force -freeze sim:/flipflop/clk 0 0
force -freeze sim:/flipflop/enable 1 0
run 20ns
force -freeze sim:/flipflop/clk 1 0
run 20ns

wave zoom full
