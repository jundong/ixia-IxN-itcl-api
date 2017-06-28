lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOn

Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:1

DhcpPDoPppHost @p1_dhcp_ppp @tester_to_dta1
@p1_dhcp_ppp config \
    -ncp_type ipv6

@p1_dhcp_ppp CreateDhcpPerRangeView
@p1_dhcp_ppp request
@p1_dhcp_ppp get_summary_stats
@p1_dhcp_ppp get_detailed_stats
#@p1_dhcp_ppp get_port_summary_stats
@p1_dhcp_ppp get_ppp_summary_stats