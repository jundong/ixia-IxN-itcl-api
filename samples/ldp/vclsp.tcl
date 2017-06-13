lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn

Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

@tester_to_dta1 config -location "190.2.152.82/5/4" -dut_ip "200.13.14.1" -intf_ip "200.13.14.2"
Ospfv2Session @tester_to_dta1.ospf(1) @tester_to_dta1
@tester_to_dta1.ospf(1) config -loopback_ipv4_gw "170.170.170.170" -ipv4_gw "200.13.14.1" -ipv4_prefix_len "24" -ospf_obj "@tester_to_dta1.ospf(1)" -ipv4_addr "200.13.14.2" -router_id "2.2.2.1" -loopback_ipv4_addr "2.2.2.1" -area_id "0.0.0.0"
LdpSession @tester_to_dta1.ldp(1) @tester_to_dta1
@tester_to_dta1.ldp(1) config -ipv4_gw "" -ipv4_addr "" -router_id "2.2.2.1" 
RouteBlock @tester.route_block(1)
@tester.route_block(1) config -prefix_len "32" -start "2.2.2.1" -step "1" -num "1"
Ipv4PrefixLsp @tester_to_dta1.ldp(1).prefix_lsp(1) @tester_to_dta1.ldp(1)
@tester_to_dta1.ldp(1).prefix_lsp(1) config -route_block "@tester.route_block(1)"
VcLsp @tester_to_dta1.ldp(1).vc_lsp @tester_to_dta1.ldp(1)
@tester_to_dta1.ldp(1).vc_lsp config \
        -requested_vlan_id_start "1" \
        -if_mtu "9600" \
        -requested_vlan_id_step "1" \
        -mac_start "00:00:00:01:00:00" \
        -requested_vlan_id_count "1" \
        -encap "LDP_LSP_ENCAP_ETHERNET_VPLS" \
        -mac_num "1" \
        -vc_id_start "1" \
        -peer_address "170.170.170.170" 

@tester_to_dta2 config -location "190.2.152.82/5/6" -dut_ip "201.13.14.1" -intf_ip "201.13.14.2"
Ospfv2Session @tester_to_dta2.ospf(2) @tester_to_dta2
@tester_to_dta2.ospf(2) config -loopback_ipv4_gw "170.170.170.170" -ipv4_gw "201.13.14.1" -ipv4_prefix_len "24" -ospf_obj "@tester_to_dta2.ospf(2)" -ipv4_addr "201.13.14.2" -router_id "2.2.2.2" -loopback_ipv4_addr "2.2.2.2" -area_id "0.0.0.0"
LdpSession @tester_to_dta2.ldp(2) @tester_to_dta2
@tester_to_dta2.ldp(2) config -ipv4_gw "" -ipv4_addr "" -router_id "2.2.2.2" 
RouteBlock @tester.route_block(2)
@tester.route_block(2) config -prefix_len "32" -start "2.2.2.2" -step "1" -num "1"
Ipv4PrefixLsp @tester_to_dta2.ldp(2).prefix_lsp(2) @tester_to_dta2.ldp(2)
@tester_to_dta2.ldp(2).prefix_lsp(2) config -route_block "@tester.route_block(2)"
VcLsp @tester_to_dta2.ldp(2).vc_lsp @tester_to_dta2.ldp(2)
@tester_to_dta2.ldp(2).vc_lsp config -encap "LDP_LSP_ENCAP_ETHERNET_VPLS" \
-mac_num "1" -vc_id_start "1" -requested_vlan_id_start "1" -vc_id_step "1" \
-requested_vlan_id_step "1" -vc_id_count "1" -requested_vlan_id_count "1" \
-mac_start "00:00:00:01:00:00" -mac_step "1" \
-peer_address "170.170.170.170" -if_mtu "9600"