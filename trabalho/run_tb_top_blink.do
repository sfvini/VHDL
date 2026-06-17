# Iniciando a simulacao
vsim work.top_timer_de2_115

# Adicionando os sinais que realmente existem no seu top-level
add wave -position insertpoint -radix binary \
sim:/top_timer_de2_115/CLOCK_50 \
sim:/top_timer_de2_115/KEY \
sim:/top_timer_de2_115/b_ajuste \
sim:/top_timer_de2_115/b_incrementa \
sim:/top_timer_de2_115/b_decrementa \
sim:/top_timer_de2_115/blink_oscillator \
sim:/top_timer_de2_115/HEX0 \
sim:/top_timer_de2_115/HEX1 \
sim:/top_timer_de2_115/HEX2 \
sim:/top_timer_de2_115/HEX3 \
sim:/top_timer_de2_115/HEX4 \
sim:/top_timer_de2_115/HEX5

# Adicionando o registrador interno do blink
add wave -position insertpoint -radix unsigned \
sim:/top_timer_de2_115/blink1/r_reg 

# Configuração de clock e reset
force -freeze sim:/top_timer_de2_115/CLOCK_50 1 0, 0 {10ns} -r 20ns
force -freeze sim:/top_timer_de2_115/KEY 4'b1110 0 
run 40ns

# Soltando o reset
force -freeze sim:/top_timer_de2_115/KEY 4'b1111 0 
run 40ns

# Zoom para ver os sinais
wave zoom full