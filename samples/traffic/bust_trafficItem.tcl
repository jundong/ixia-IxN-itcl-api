lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login
IxDebugOn
#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
Port @tester_to_dta1 172.16.174.128/1/1
Port @tester_to_dta2 172.16.174.128/2/1

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2" -outer_vlan_enable true -outer_vlan_id 100
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1" -outer_vlan_enable true -outer_vlan_id 200

Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "custom" -src "@tester_to_dta1 @tester_to_dta2" -dst "@tester_to_dta1 @tester_to_dta2" -traffic_pattern "mesh" -burst_packet_count "100" -min_gap_bytes "128" -enable_burst_gap "true" -burst_gap "11" -burst_gap_units "bytes"
 
Tester::start_traffic
puts [@tester_to_dta1.traffic(1) get_stats -rx_port @tester_to_dta2]
