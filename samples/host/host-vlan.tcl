lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn

Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2

@tester_to_dta1 config -intf_ip "200.13.14.2" -dut_ip "200.13.14.1"
@tester_to_dta2 config -intf_ip "201.13.14.2" -dut_ip "201.13.14.1"
Host @tester_to_dta1.host @tester_to_dta1
@tester_to_dta1.host config -count "5" -src_mac "00:0a:94:00:00:01" -inner_vlan_id "200" -outer_vlan_id "100" -ipv4_addr "1.1.1.2"
Host @tester_to_dta2.host @tester_to_dta2
#@tester_to_dta2.host config -count "5" -src_mac "00:0b:94:00:00:01" -outer_vlan_enable "true" -static "1" -outer_vlan_id "1"
@tester_to_dta2.host config -count "5" -src_mac "00:0b:94:00:00:01" -inner_vlan_id "200" -static "1" -outer_vlan_id "100"

Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -src "@tester_to_dta1.host" -traffic_pattern "pair" -stream_load "10" -dst "@tester_to_dta2.host" -load_unit "percent" -no_mesh "1" 

