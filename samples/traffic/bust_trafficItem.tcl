#lappend auto_path [file dirname [file dirname [file dirname [info script]]]]
lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn
#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
Port @tester_to_dta1 172.16.174.128/1/1
Port @tester_to_dta2 172.16.174.128/2/1

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2"
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1"
# -outer_vlan_enable true -outer_vlan_id 100
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "custom" \
            -src "@tester_to_dta1" \
            -dst "@tester_to_dta2" \
            -burst_packet_count "100" \
            -min_gap_bytes "128" \
            -enable_burst_gap "true" \
            -burst_gap "11" \
            -burst_gap_units "bytes"
            #-traffic_pattern "mesh"
            
Traffic @tester_to_dta1.traffic(2) @tester_to_dta1
@tester_to_dta1.traffic(2) config -tx_mode "custom" \
            -src "@tester_to_dta2" \
            -dst "@tester_to_dta1" \
            -burst_packet_count "100" \
            -min_gap_bytes "128" \
            -enable_burst_gap "true" \
            -burst_gap "11" \
            -burst_gap_units "bytes"
            #-traffic_pattern "mesh"
            
#Tester::start_traffic
#after [expr 10 * 60]
#Tester::stop_traffic
SearchMinFrameSizeByLoad -downstreams @tester_to_dta1.traffic(1) -inflation 0 -resultfile {C:\Ixia\Workspace\ixia-IxN-itcl-api\samples\traffic\traffic_results.csv} -duration 30 -frame_len {120 121} -upstreams @tester_to_dta1.traffic(2)
RunCustomizeSizeByLoad -downstreams @tester_to_dta1.traffic(1) -inflation 0 -resultfile {C:\Ixia\Workspace\ixia-IxN-itcl-api\samples\traffic\traffic_results.csv} -duration 30 -frame_len {120 121} -upstreams @tester_to_dta1.traffic(2)
set isLoss [Tester::isLossFrames "@tester_to_dta1.traffic(1) @tester_to_dta1.traffic(2)"]
Tester::saveResults -frame_size 128 -streams "@tester_to_dta1.traffic(1) @tester_to_dta1.traffic(2)" -resultfile {C:\Ixia\Workspace\ixia-IxN-itcl-api\samples\traffic\traffic_results.csv}
#puts [@tester_to_dta1.traffic(1) get_stats -rx_port @tester_to_dta2]
