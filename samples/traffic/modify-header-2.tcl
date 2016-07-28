lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet

Login
IxDebugOn
#Port @tester_to_dta1 172.16.174.134/1/1
#Port @tester_to_dta2 172.16.174.134/2/1
Port @tester_to_dta1 10.210.100.12/5/1
Port @tester_to_dta2 10.210.100.12/5/2

#Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
#Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2
#Port @tester_to_dta3 NULL NULL ::ixNet::OBJ-/vport:3
#Port @tester_to_dta4 NULL NULL ::ixNet::OBJ-/vport:4

#@tester_to_dta1 config -dut_ip "30.30.30.1" -intf_ip "30.30.30.2"
#@tester_to_dta2 config -dut_ip "30.30.30.2" -intf_ip "30.30.30.1"
                         
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
Ipv4Hdr @tester.pdu.ipv4(1)
@tester.pdu.ipv4(1) config @tester.pdu.ipv4(1) config -src "25.1.1.1" -dst "26.1.1.1"
  
VlanHdr @tester.pdu.vlan(1)
@tester.pdu.vlan(1) config -pri1 "1" -id1 "200"

EtherHdr @tester.pdu.eth(1)
@tester.pdu.eth(1) config -src "00:00:00:03:02:01" -dst "00:00:01:00:00:01"

#-pdu "@tester.pdu.eth(1) @tester.pdu.vlan(1) @tester.pdu.ipv4(1)"
@tester_to_dta1.traffic(1) config \
   -src "@tester_to_dta1" \
   -pdu "@tester.pdu.eth(1) @tester.pdu.vlan(1) @tester.pdu.ipv4(1)" \
   -dst "@tester_to_dta2" \
   -tx_mode "continuous" \
   -frame_len "164" \
   -stream_load "13" \
   -load_unit "percent" \
   -traffic_type "raw"

Tester::start_traffic

@tester_to_dta1.traffic(1) get_stats -tracking "precedence"

@tester_to_dta1.traffic(1) get_stats \
   -tracking "precedence" -rx_port "@tester_to_dta2"

@tester_to_dta1.traffic(1) get_stats
