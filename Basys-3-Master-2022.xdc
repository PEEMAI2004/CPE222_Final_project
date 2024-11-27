## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Emergency Stop
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports emergency_stop]
## Door Sensor
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {door_sensor[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {door_sensor[1]}]
## Debug switch
set_property -dict { PACKAGE_PIN R2   IOSTANDARD LVCMOS33 } [get_ports debug]

## Switches
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}] // now used for door sensor
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}] // now used for door sensor
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}] // now used for emergency stop
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {sw[4]}]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {sw[5]}]
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {sw[6]}]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {sw[7]}]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports {sw[8]}]
#set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports {sw[9]}]
#set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports {sw[10]}]
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports {sw[11]}]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports {sw[12]}]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports {sw[13]}]
#set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports {sw[14]}]
#set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports {sw[15]}] 

## LEDs
#set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {led[0]}]  // now used for door
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {led[1]}]  // now used for door
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {led[2]}]  // now used for door
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {led[3]}]  // now used for door
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports {led[4]}]
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports {led[5]}]  // now used for show 1 floor request
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {led[6]}]  // now used for show 2 floor request
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {led[7]}]  // now used for show 3 floor request
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports {led[8]}]
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports {led[9]}]
#set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports {led[10]}]
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports {led[11]}]
#set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports {led[12]}]
#set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports {led[13]}]
#set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {led[14]}] // now use for direction led
#set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {led[15]}] // now use for direction led

## floor request LEDs
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports {led_floor_request[1]}]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {led_floor_request[2]}]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {led_floor_request[3]}]

##7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {seg[0]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {seg[1]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {seg[2]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {seg[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {seg[4]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {seg[5]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {seg[6]}]

#set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports dp]

set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {anode[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {anode[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {anode[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {anode[3]}]

## Door
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {lift_door[0]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {lift_door[1]}]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {lift_door[2]}]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {lift_door[3]}]

set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports {direction_led[0]}]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {direction_led[1]}]

## External Panal

# door open/close buttons panel PMOD JXADC
set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {btn_door[0]}]
set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {btn_door[1]}]
set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports {led_btn_door[0]}]
set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports {led_btn_door[1]}]

# destination selection buttons panel PMOD JA
set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {btn_select_floor[3]}]
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {btn_select_floor[2]}]
set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {btn_select_floor[1]}]
set_property -dict { PACKAGE_PIN G3   IOSTANDARD LVCMOS33 } [get_ports {led_btn_select_floor[3]}]
set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports {led_btn_select_floor[2]}]
set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports {led_btn_select_floor[1]}]

# call buttons panel PMOD JB
# up at 1st and 2nd floor, down at 2th and 3st floor
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports {btn_call_up_floor[0]}]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports {btn_call_down_floor[0]}] 
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports {btn_call_up_floor[1]}]
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports {btn_call_down_floor[1]}]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports {led_btn_call_up_floor[0]}]
set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports {led_btn_call_down_floor[0]}]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports {led_btn_call_up_floor[1]}]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports {led_btn_call_down_floor[1]}]

# 4 * 4 keypad panel PMOD JC
# set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports {keypad_row[0]}]
# set_property -dict { PACKAGE_PIN A19   IOSTANDARD LVCMOS33 } [get_ports {keypad_row[1]}]
# set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports {keypad_row[2]}]
# set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports {keypad_row[3]}]
# set_property -dict { PACKAGE_PIN C18   IOSTANDARD LVCMOS33 } [get_ports {keypad_col[0]}]
# set_property -dict { PACKAGE_PIN C19   IOSTANDARD LVCMOS33 } [get_ports {keypad_col[1]}]
# set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports {keypad_col[2]}]
# set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {keypad_col[3]}]

##Buttons
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports reset]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports btnC]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports btnU]
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports btnL]
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports btnR]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports btnD]


##VGA Connector
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[0]}]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[1]}]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[2]}]
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports {vgaRed[3]}]
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[0]}]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[1]}]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[2]}]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {vgaBlue[3]}]
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[0]}]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[1]}]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[2]}]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports {vgaGreen[3]}]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports Hsync]
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports Vsync]


##USB-RS232 Interface
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports RsRx]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports RsTx]


##USB HID (PS/2)
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Clk]
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33   PULLUP true } [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[0]}]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[1]}]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[2]}]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports {QspiDB[3]}]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports QspiCSn]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
