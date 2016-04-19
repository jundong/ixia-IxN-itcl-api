lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login localhost/8009
IxDebugOff
Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2

#@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2"
#@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1"
#Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
#@tester_to_dta1.traffic(1) config -tx_mode "burst" -src "@tester_to_dta1 @tester_to_dta2 @tester_to_dta3" -tx_num "100000" -frame_len_type "fixed" -dst "@tester_to_dta1 @tester_to_dta2 @tester_to_dta3" -frame_len "256" -stream_load "100" -traffic_pattern "mesh" -load_unit "percent"
Tester::start_traffic
puts "==============="
#@tester_to_dta1.traffic(1) get_stats
Tester::stop_traffic
Tester::start_traffic
puts "==============="
#@tester_to_dta1.traffic(1) get_stats
Tester::stop_traffic
@tester_to_dta1 start_traffic
puts "==============="
#@tester_to_dta1.traffic(1) get_stats
@tester_to_dta1 stop_traffic
@tester_to_dta1 start_traffic
puts "==============="
#@tester_to_dta1.traffic(1) get_stats
@tester_to_dta1 stop_traffic