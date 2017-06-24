lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet

Login
IxDebugOn
#Port @tester_to_dta1 172.16.174.128/1/1
#Port @tester_to_dta2 172.16.174.128/2/1
Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.10"
@tester_to_dta2 config -dut_ip "20.13.14.10" -intf_ip "20.13.14.1"
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "continuous" \
            -src "@tester_to_dta1 @tester_to_dta2" \
            -frame_len_type "fixed" \
            -dst "@tester_to_dta1 @tester_to_dta2" \
            -frame_len "128" \
            -stream_load "1000" \
            -traffic_pattern "mesh" \
            -min_frame_len "64" \
            -max_frame_len "1518" \
            -resolution "1" \
            -load_unit "MBPS" \
            -frame_ordering_mode "RFC2889" \
            -iteration_duration 10

Traffic @tester_to_dta1.traffic(2) @tester_to_dta1
@tester_to_dta1.traffic(2) config -tx_mode "continuous" \
            -src "@tester_to_dta1 @tester_to_dta2" \
            -frame_len_type "fixed" \
            -dst "@tester_to_dta1 @tester_to_dta2" \
            -frame_len "128" \
            -stream_load "1000" \
            -traffic_pattern "mesh" \
            -min_frame_len "64" \
            -max_frame_len "1518" \
            -resolution "1" \
            -load_unit "MBPS" \
            -frame_ordering_mode "RFC2889" \
            -iteration_duration 10

Tester::SearchMinFrameSizeByLoad -frame_len [list 64 65 66] \
            -inflation 0 \
            -upstreams @tester_to_dta1.traffic(1) \
            -downstreams @tester_to_dta1.traffic(2)
#set retVal [@tester_to_dta1.traffic(1) search_min_frame_size_by_load]
#puts "Min Frame Size: [ GetStatsFromReturn $retVal frame_size ]"
