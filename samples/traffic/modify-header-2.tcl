lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet

Login
IxDebugOn
Port @tester_to_dta1 172.16.174.134/1/1
Port @tester_to_dta2 172.16.174.134/2/1

#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
#Port @tester_to_dta3 NULL NULL ::ixNet::OBJ-/vport:3
#Port @tester_to_dta4 NULL NULL ::ixNet::OBJ-/vport:4

@tester_to_dta1 config -dut_ip "30.30.30.1" -intf_ip "30.30.30.2"
@tester_to_dta2 config -dut_ip "30.30.30.2" -intf_ip "30.30.30.1"

Ipv4Hdr @tester.pdu.ipv4(1)
@tester.pdu.ipv4(1) config -modify 1 \
                           -precedence 0 \
                           -precedence_mode incr \
                           -precedence_num 8 \
                           -precedence_step 1
                           
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1

@tester_to_dta1.traffic(1) config \
   -src "@tester_to_dta1" \
   -pdu "@tester.pdu.ipv4(1)" \
   -dst "@tester_to_dta2" \
   -precedence_tracking 1 \
   -tx_mode "continuous" \
   -frame_len "164" \
   -stream_load "13" \
   -load_unit "percent"

Tester::start_traffic

@tester_to_dta1.traffic(1) get_stats -tracking "precedence"

@tester_to_dta1.traffic(1) get_stats \
   -tracking "precedence" -rx_port "@tester_to_dta2"

@tester_to_dta1.traffic(1) get_stats
