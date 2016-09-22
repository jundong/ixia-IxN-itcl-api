lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login
IxDebugOff
#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
Port @tester_to_dta1 172.16.174.134/1/1
Port @tester_to_dta2 172.16.174.134/2/1

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2"
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1"

Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "custom" -src "@tester_to_dta1 @tester_to_dta2" -dst "@tester_to_dta1 @tester_to_dta2" -traffic_pattern "mesh" -burst_packet_count "1" -min_gap_bytes "128" -enable_burst_gap "true" -burst_gap "11" -burst_gap_units "bytes"
Capture @capture_port1 @tester_to_dta1
@capture_port1 update_info

Tester::start_traffic

@capture_port1 start_capture

after 2000
Tester::stop_traffic
@capture_port1 stop_capture
@capture_port1 save_capture -result_dir {C:\Tmp} -user ixia -password ixia123 -filters -Y ip.version==4 -e ip.version
@tester_to_dta1.traffic(1) get_stats
