lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}

# package name
package req IxiaNet
Login

IxDebugOn
#Port @tester_to_dta1 172.16.174.134/1/1
#Port @tester_to_dta2 172.16.174.134/2/1
Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

@tester_to_dta1 config -dut_ip "20.13.14.1" -intf_ip "20.13.14.2" -outer_vlan_enable true -outer_vlan_id 100
@tester_to_dta2 config -dut_ip "20.13.14.2" -intf_ip "20.13.14.1" -outer_vlan_enable true -outer_vlan_id 200

Dhcpv4Host @p1_dhcp @tester_to_dta1
Dhcpv4Server @p2_dhcpServer @tester_to_dta2

@p1_dhcp wait_request_complete 30
