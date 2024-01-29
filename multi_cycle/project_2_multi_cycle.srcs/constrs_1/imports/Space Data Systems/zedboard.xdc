########################################################
# ZedBoard Pin Assignments
########################################################
# CLK - Zedboard 100MHz oscillator
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports CLK]

########################################################
##ZedBoard Timing Constraints
########################################################
# define clock and period
create_clock -period 7.257 -name CLK -waveform {0.000 3.628} [get_ports CLK]