lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}

# package name
package req IxiaNet
Login

IxDebugOn
Port @tester_to_dta1 172.16.174.134/1/1
Port @tester_to_dta2 172.16.174.134/2/1

IPoEHost @ipoe_host("IP-R6") @portwithname11

Dhcpv4Host @p1_dhcp @tester_to_dta1
Dhcpv4Server @p2_dhcpServer @tester_to_dta2

@p1_dhcp wait_request_complete 30
