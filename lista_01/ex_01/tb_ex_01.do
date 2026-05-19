vlib rtl_work
vmap work rtl_work 
vcom -93 -work work {../../ex_01.vhd}
vsim work.ex_01

add wave -position insertpoint  \
sim:/ex_01/clk \
sim:/ex_01/reset \
sim:/ex_01/d \
sim:/ex_01/control \
sim:/ex_01/d_to_right \
sim:/ex_01/d_to_left \
sim:/ex_01/entrada \
sim:/ex_01/q \
sim:/ex_01/r_reg \
sim:/ex_01/r_next

# RESET
force -freeze sim:/ex_01/reset 1 0
force -freeze sim:/ex_01/control 00 0
force -freeze sim:/ex_01/entrada 0000 0
force -freeze sim:/ex_01/d_to_right 0 0
force -freeze sim:/ex_01/d_to_left 0 0
force -freeze sim:/ex_01/clk 0 0
run
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# ENTRADA
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 11 0
force -freeze sim:/ex_01/entrada 1010 0
force -freeze sim:/ex_01/d_to_right 0 0
force -freeze sim:/ex_01/d_to_left 0 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# DESLOCAR PARA DIREITA BIT 1
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 01 0
force -freeze sim:/ex_01/entrada 1010 0
force -freeze sim:/ex_01/d_to_right 1 0
force -freeze sim:/ex_01/d_to_left 0 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# DESLOCAR PARA DIREITA 0
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 01 0
force -freeze sim:/ex_01/entrada 1010 0
force -freeze sim:/ex_01/d_to_right 0 0
force -freeze sim:/ex_01/d_to_left 0 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# DESLOCAR PARA ESQUERDA BIT 1
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 10 0
force -freeze sim:/ex_01/entrada 1010 0
force -freeze sim:/ex_01/d_to_right 0 0
force -freeze sim:/ex_01/d_to_left 1 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# DESLOCAR PARA ESQUERDA BIT 0
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 10 0
force -freeze sim:/ex_01/entrada 1010 0
force -freeze sim:/ex_01/d_to_right 0 0
force -freeze sim:/ex_01/d_to_left 0 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run

# PAUSAR 
force -freeze sim:/ex_01/reset 0 0
force -freeze sim:/ex_01/control 00 0
# CORRIGIDO: Mudado de 'palavra' para 'entrada'
force -freeze sim:/ex_01/entrada 1111 0 
force -freeze sim:/ex_01/d_to_right 1 0
force -freeze sim:/ex_01/d_to_left 1 0
force -freeze sim:/ex_01/clk 1 0
run
force -freeze sim:/ex_01/clk 0 0
run
