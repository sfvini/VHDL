vsim work.display7seg
vsim work.display7seg(code)
vsim work.c_display7seg

vsim work.display7seg
add wave -position insertpoint  \
sim:/display7seg/sw
add wave -position insertpoint  \
sim:/display7seg/hex0
force -freeze sim:/display7seg/sw 0000 0
run
force -freeze sim:/display7seg/sw 0001 0
run
force -freeze sim:/display7seg/sw 0010 0
run
force -freeze sim:/display7seg/sw 0011 0
run
force -freeze sim:/display7seg/sw 0100 0
run
force -freeze sim:/display7seg/sw 0101 0
run
force -freeze sim:/display7seg/sw 0110 0
run
force -freeze sim:/display7seg/sw 0111 0
run
force -freeze sim:/display7seg/sw 1000 0
run
force -freeze sim:/display7seg/sw 1001 0
run
force -freeze sim:/display7seg/sw 1111 0
run
