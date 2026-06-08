vsim work.forloop(code)
add wave -position insertpoint  \
sim:/forloop/a \
sim:/forloop/y \
sim:/forloop/p
force -freeze sim:/forloop/a 00000000 0
run
force -freeze sim:/forloop/a 00000001 0
run
force -freeze sim:/forloop/a 10000001 0
run
force -freeze sim:/forloop/a 11111111 0
run
