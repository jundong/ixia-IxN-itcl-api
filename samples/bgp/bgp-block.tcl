lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn
#Port @tester_to_dta1 190.2.152.82/5/1
#Port @tester_to_dta2 190.2.152.82/5/2
Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL
BgpSession @tester_to_dta1.bgp(1) @tester_to_dta1
@tester_to_dta1.bgp(1) config -type "external" -dut_as "100" -ipv4_addr "15.13.14.2" -ip_version "ipv4" -dut_ip "15.13.14.1" -as "200"
RouteBlock @tester.route_block(1)
@tester.route_block(1) config -start "150.0.0.1" -step "1" -prefix_len "255.255.255.0" -num "3"
@tester_to_dta1.bgp(1) set_route -route_block "@tester.route_block(1)"
BgpSession @tester_to_dta2.bgp(2) @tester_to_dta2
@tester_to_dta2.bgp(2) config -type "external" -dut_as "100" -ipv4_addr "16.13.14.2" -ip_version "ipv4" -dut_ip "16.13.14.1" -as "200"
RouteBlock @tester.route_block(2)
@tester.route_block(2) config -start "151.0.0.1" -step "1" -prefix_len "255.255.255.0" -num "3"
@tester_to_dta2.bgp(2) set_route -route_block "@tester.route_block(2)"

PppoeHost @tester_to_dta2.pppoe(1) @tester_to_dta2
@tester_to_dta2.pppoe(1) config \
	-mru_size 1234 \
	-vlan_id1 1111 \
	-vlan_id2 1112 \
	-vlan_id1_step 2221 \
	-vlan_id2_step 2222\
	-vlan1_per_port 3333 \
	-vlan2_per_port 3334

Traffic @tester_to_dta2.traffic(1) @tester_to_dta2
@tester_to_dta2.traffic(1) config -src "@tester_to_dta2.pppoe(1)" \
    -dst "@tester.route_block(1)"\
    -stream_load "20" -load_unit "percent"

IxDebugOn
Traffic @tester_to_dta1.traffic(1) @tester_to_dta1
@tester_to_dta1.traffic(1) config -src "@tester.route_block(1) @tester.route_block(2)" \
    -dst "@tester.route_block(1) @tester.route_block(2)" -traffic_pattern "mesh" \
    -stream_load "20" -load_unit "percent"
