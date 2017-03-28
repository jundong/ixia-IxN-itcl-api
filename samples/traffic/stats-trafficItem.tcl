lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login
IxDebugOn
Port @tester_to_dta1 172.16.174.129/1/1
Port @tester_to_dta2 172.16.174.129/2/1
#Port @tester_to_dta3 190.2.152.82/5/3

#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2"
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1"
#@tester_to_dta3 config -dut_ip "22.13.14.1" -intf_ip "22.13.14.2"
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "burst" \
    -src "@tester_to_dta1 @tester_to_dta2" \
    -tx_num "1000" -frame_len_type "fixed" \
    -dst "@tester_to_dta1 @tester_to_dta2" \
    -frame_len "256" -stream_load "100" \
    -traffic_pattern "mesh" \
    -load_unit "percent"
Tester::start_traffic
@tester_to_dta1.traffic(1) get_stats
