# do mux4x1_run_msim_rtl_vhdl.do
# if {[file exists rtl_work]} {
#     vdel -lib rtl_work -all
# }
# vlib rtl_work
# vmap work rtl_work
# Model Technology ModelSim - Intel FPGA Edition vmap 2020.1 Lib Mapping Utility 2020.02 Feb 28 2020
# vmap work rtl_work 
# Modifying /opt/altera/intelFPGA/20.1/modelsim_ae/linuxaloem/../modelsim.ini
# 
# vcom -93 -work work {/home/aluno/ELDII/aula 16-04-26/mux4x1.vhd}
# Model Technology ModelSim - Intel FPGA Edition vcom 2020.1 Compiler 2020.02 Feb 28 2020
# Start time: 08:35:15 on Apr 16,2026
# vcom -reportprogress 300 -93 -work work ../mux4x1.vhd 
# -- Loading package STANDARD
# -- Loading package TEXTIO
# -- Loading package std_logic_1164
# -- Compiling entity mux4x1
# -- Compiling architecture v_logica_pura of mux4x1
# -- Compiling architecture v_when_else of mux4x1
# -- Loading entity mux4x1
# -- Compiling architecture v_with_select of mux4x1
# -- Loading entity mux4x1
# -- Compiling configuration revisao
# -- Loading entity mux4x1
# -- Loading architecture v_logica_pura of mux4x1
# End time: 08:35:15 on Apr 16,2026, Elapsed time: 0:00:00
# Errors: 0, Warnings: 0
# 
# 
# stdin: <EOF>
vsim work.mux4x1
# vsim work.mux4x1 

vsim work.v1_mux4x1
# vsim work.'configuration_name' 

add wave -position insertpoint  \
sim:/mux4x1/X \
sim:/mux4x1/Sel \
sim:/mux4x1/Y
force -freeze sim:/mux4x1/X 0001 0
run
force -freeze sim:/mux4x1/X 0010 0
force -freeze sim:/mux4x1/Sel 01 0
run
force -freeze sim:/mux4x1/X 0100 0
force -freeze sim:/mux4x1/Sel 10 0
run
force -freeze sim:/mux4x1/X 1000 0
force -freeze sim:/mux4x1/Sel 11 0
run