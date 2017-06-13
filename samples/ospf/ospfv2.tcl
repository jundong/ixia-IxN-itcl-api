lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn

Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

#@tester_to_dta1 config -intf_ip "200.13.14.2" -dut_ip "200.13.14.1"
#@tester_to_dta2 config -intf_ip "201.13.14.2" -dut_ip "201.13.14.1"
Ospfv2Session @tester_to_dta1.ospf(1) @tester_to_dta1
@tester_to_dta1.ospf(1) config \
    -ipv4_gw "200.13.14.1" \
    -loopback_ipv4_addr "2.2.2.1" \
    -ospf_obj "@tester_port1.ospf(1)" \
    -area_id "0.0.0.0" \
    -loopback_ipv4_gw "170.170.170.170" \
    -ipv4_addr "200.13.14.2" \
    -router_id "2.2.2.1" \
    -ipv4_prefix_len "24"



