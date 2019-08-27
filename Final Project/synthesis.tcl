set src RSA_v3.v
set name RSA

#gui_start
read_file -format verilog $src
analyze -library WORK -format verilog $src
elaborate $name -architecture verilog -library DEFAULT
create_clock -name "CLK" -period 10 -waveform { 0 5  }
set_dont_touch_network  [ find clock CLK ]
set_fix_hold  [ find clock CLK]
compile -exact_map
uplevel #0 { report_area > area.txt }
uplevel #0 { report_power -analysis_effort low > power.txt }
write -format verilog -hierarchy -output RSA_v3_syn.v

quit
