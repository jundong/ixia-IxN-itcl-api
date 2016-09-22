lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet

Login
IxDebugOn
Port @tester_to_dta1 172.16.174.134/1/1
Port @tester_to_dta2 172.16.174.134/2/1
#Port @tester_to_dta1 10.210.100.12/5/3
#Port @tester_to_dta2 10.210.100.12/5/4

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.10"
@tester_to_dta2 config -dut_ip "20.13.14.10" -intf_ip "20.13.14.1"

Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -tx_mode "continuous" \
            -src "@tester_to_dta1" \
            -frame_len_type "fixed" \
            -dst "@tester_to_dta2" \
            -frame_len "128" \
            -traffic_pattern "pair" \
            -frame_ordering_mode "RFC2889" 

Traffic @tester_to_dta2.traffic(1) @tester_to_dta2
@tester_to_dta2.traffic(1) config -tx_mode "continuous" \
            -src "@tester_to_dta2" \
            -frame_len_type "fixed" \
            -dst "@tester_to_dta1" \
            -frame_len "128" \
            -traffic_pattern "pair" \
            -frame_ordering_mode "RFC2889"

#Tester::start_traffic
set retVal [SearchMinFrameSizeByLoad -frame_len [list 64 65 660 800 900 1000 1280 5400 9600] \
            -streams [ list @tester_to_dta1.traffic(1) @tester_to_dta2.traffic(1) ] \
            -inflation 10000 \
            -duration 20 \
            -resultfile {C:/Ixia/Docs/IxLoad/resultfile.csv}]
puts "Min Frame Size: [ GetStatsFromReturn $retVal frame_size ]"
