########################################################
# ZedBoard Pin Assignments
########################################################
# CLK - Zedboard 100MHz oscillator
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports clk]

########################################################
##ZedBoard Timing Constraints
########################################################
# define clock and period
create_clock -period 11.739 -name CLK -waveform {0.000 5.870} [get_ports CLK]

# Set output registers to IOB
set_property IOB TRUE [all_outputs]

