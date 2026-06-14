# Iniciando a simulacao
vsim work.top_timer_de2_115

# Adicionando os sinais de clock e reset
add wave -position insertpoint  \
sim:/top_timer_de2_115/CLOCK_50 \
sim:/top_timer_de2_115/KEY 

# Adicionando os sinais 
add wave -position insertpoint -radix binary \
sim:/top_timer_de2_115/CLOCK_50 \
sim:/top_timer_de2_115/KEY \
sim:/top_timer_de2_115/adjust \
sim:/top_timer_de2_115/blink_o \
sim:/top_timer_de2_115/HEX0 \
sim:/top_timer_de2_115/HEX1 \
sim:/top_timer_de2_115/HEX2 \
sim:/top_timer_de2_115/HEX3 \
sim:/top_timer_de2_115/HEX4 \
sim:/top_timer_de2_115/HEX5

add wave -position insertpoint -radix unsigned \
sim:/top_timer_de2_115/blink1/r_reg 

# Criando clock e forçando reset (KEY0 em 0, restantes em 1)
force -freeze sim:/top_timer_de2_115/CLOCK_50 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/top_timer_de2_115/KEY 4'b1110 0 
run 40ns

# Soltando o reset (Todas as chaves em 1)
force -freeze sim:/top_timer_de2_115/KEY 4'b1111 0 
run 40ns

# Testando ADJ NAO pressionado e sem chegar no tempo 
run 200ns

# Testando ADJ NAO pressionado e chegando no tempo 
force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#24999995 0 -cancel 20ns
run 200ns


# Testando ADJ pressionado e sem chegar no tempo (KEY1 em 0)
force -freeze sim:/top_timer_de2_115/KEY 4'b1101 0 
force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#0 0 -cancel 20ns
run 200ns

# Soltando o botão novamente
force -freeze sim:/top_timer_de2_115/KEY 4'b1111 0

# Testando ADJ pressionado e chegando no tempo e piscando por alguns ciclos
force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#24999995 0 -cancel 20ns
run 200ns

force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#49999999 0 -cancel 20ns
run 200ns

force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#24999995 0 -cancel 20ns
run 200ns

force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#49999999 0 -cancel 20ns
run 200ns

force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#24999995 0 -cancel 20ns
run 200ns

force -freeze sim:/top_timer_de2_115/blink1/r_reg 10#49999999 0 -cancel 20ns
run 200ns

wave zoom full