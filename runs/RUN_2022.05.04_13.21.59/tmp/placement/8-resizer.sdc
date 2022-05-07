###############################################################################
# Created by write_sdc
# Wed May  4 13:22:22 2022
###############################################################################
current_design PrimitiveCalculator
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {restart}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rotary_a}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rotary_b}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {select}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {led_flag}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_digit}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -add_delay [get_ports {seven_segment_out[6]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {led_flag}]
set_load -pin_load 0.0334 [get_ports {seven_segment_digit}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[6]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[5]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[4]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[3]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[2]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[1]}]
set_load -pin_load 0.0334 [get_ports {seven_segment_out[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {restart}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rotary_a}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rotary_b}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {select}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 5.0000 [current_design]
