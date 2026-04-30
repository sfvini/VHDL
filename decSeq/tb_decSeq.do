vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/vinicius.sf2007/decSeq/decSeq.vhd}

vsim work.decSeq(cfg_process)

add wave *

force -freeze sim:/decSeq/a 10000000 0 ns
force -freeze sim:/decSeq/b 10000000 0 ns
run 10 ns

force -freeze sim:/decSeq/b 00000001 0 ns
run 10 ns

force -freeze sim:/decSeq/a 11111111 0 ns
force -freeze sim:/decSeq/b 10000000 0 ns
run 10 ns

force -freeze sim:/decSeq/a 11111011 0 ns
force -freeze sim:/decSeq/b 11111011 0 ns
run 10 ns

force -freeze sim:/decSeq/a 11111111 0 ns
force -freeze sim:/decSeq/b 00000000 0 ns
run 10 ns

force -freeze sim:/decSeq/a 00000000 0 ns
force -freeze sim:/decSeq/b 11111111 0 ns
run 10 ns
