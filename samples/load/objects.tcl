lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
set configfile "C:/Ixia/Workspace/ixia-IxN-itcl-api/samples/load/SR+_2G_L3_ipoe_v4.ixncfg"
Login "localhost/8009" 1 $configfile
IxDebugOn
Port @portwithname11 "172.16.174.137/1/1"
Traffic @trafficwithname(1) @portwithname11
Traffic @trafficwithname("pppoeV4") @portwithname11

BgpSession @portwithname11.bgp(1) @portwithname11
Dhcpv4Host @portwithname11.dhcp(1) @portwithname11
Dhcpv4Host @portwithname11.dhcp("DHCP-R4") @portwithname11
Dhcpv6Host @portwithname11.dhcpv6(1) @portwithname11
Dhcpv6Host @portwithname11.dhcpv6("DHCP-R6") @portwithname11
IgmpHost @portwithname11.igmp_host(1) @portwithname11
PppoeHost @portwithname11.pppoe_host(1) @portwithname11
PppoeHost @portwithname11.pppoe_host("PPPOE_dual-1") @portwithname11

Ospfv2Session @portwithname11.ospfv2(1) @portwithname11

Port @portwithname12 "172.16.174.137/1/2"
BgpSession @portwithname12.bgp(1) @portwithname12
BfdSession @portwithname12.bfd(1) @portwithname12
IsisSession @portwithname12.isis(1) @portwithname12
LdpSession @portwithname12.ldp(1) @portwithname12
Ospfv2Session @portwithname12.ospfv2(1) @portwithname12

Port @portwithname13 "172.16.174.137/1/3"
BgpSession @portwithname13.bgp(1) @portwithname13
Dhcpv4Host @portwithname13.dhcp(1) @portwithname13
Dhcpv6Host @portwithname13.dhcpv6(1) @portwithname13
IgmpHost @portwithname13.igmp_host(1) @portwithname13
PppoeHost @portwithname13.pppoe_host(1) @portwithname13

Port @portwithname15 "172.16.174.137/1/5"
BgpSession @portwithname15.bgp(1) @portwithname15
Dhcpv4Host @portwithname15.dhcp(1) @portwithname15
Dhcpv6Host @portwithname13.dhcpv6(1) @portwithname13
IgmpHost @portwithname15.igmp_host(1) @portwithname15
PppoeHost @portwithname15.pppoe_host(1) @portwithname15

Port @portwithname16 "172.16.174.137/1/6"
BgpSession @portwithname16.bgp(1) @portwithname16
Dhcpv4Host @portwithname16.dhcp(1) @portwithname16
Dhcpv6Host @portwithname16.dhcpv6(1) @portwithname16
IgmpHost @portwithname16.igmp_host(1) @portwithname16
PppoeHost @portwithname16.pppoe_host(1) @portwithname16

Port @portwithname24 "172.16.174.137/2/4"
LdpSession @portwithname24.ldp(1) @portwithname24
Ospfv2Session @portwithname24.ospfv2(1) @portwithname24

#$traffic disable
#$traffic traffic_enable
#$traffic enable
#$traffic traffic_disable
#Tester::start_traffic
#$traffic get_stats
