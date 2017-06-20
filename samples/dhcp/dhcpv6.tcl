lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn

Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

#@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2" -outer_vlan_enable true -outer_vlan_id 100
#@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1" -outer_vlan_enable true -outer_vlan_id 200

#Dhcpv6Host @p1_dhcp @tester_to_dta1
DhcpPDoPppHost @p1_dhcp_ppp @tester_to_dta1
@p1_dhcp_ppp config \
    -ncp_type ipv6 \
    -inner_vlan_id 200 \
    -outer_vlan_id 100 \
    -inner_vlan_step 123 \
    -inner_vlan_step 456 \
    -outer_vlan_num 123 \
    -inner_vlan_num 456