vlib work
vmap work work

vcom -93 mux4x1.vhd

vsim work.v2_mux4x1

add wave -position insertpoint sim:/mux4x1/X sim:/mux4x1/Sel sim:/mux4x1/Y
force -freeze sim:/mux4x1/X 0001 0; force -freeze sim:/mux4x1/Sel 00 0; run 100ns
force -freeze sim:/mux4x1/X 0010 0; force -freeze sim:/mux4x1/Sel 01 0; run 100ns
