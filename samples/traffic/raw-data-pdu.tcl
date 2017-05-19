lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login
IxDebugOn
#Port @tester_to_dta1 172.16.174.128/1/1
#Port @tester_to_dta2 172.16.174.128/2/1

Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
@tester_to_dta1 config -flow_control true
@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2"
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1"
#@tester_to_dta3 config -dut_ip "22.13.14.1" -intf_ip "22.13.14.2"
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "burst" \
    -src "@tester_to_dta1 @tester_to_dta2" \
    -tx_num "1000" \
    -frame_len_type "fixed" \
    -dst "@tester_to_dta1 @tester_to_dta2" \
    -pdu "01 80 c2 00 00 01 00 00 03 00 00 02 88 08 00 01 ff ff" \
    -selfdst true \
    -frame_len "256" \
    -stream_load "300" \
    -traffic_type "raw" \
    -load_unit "fps"  \
    -regenerate true
#-pdu "01 80 c2 00 00 01 00 00 03 00 00 02 88 08 00 01 ff ff"
Tester::start_traffic
@tester_to_dta1.traffic(1) get_stats -filter_value 5 -tracking precedence
