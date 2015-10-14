lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
set configfile "C:/Ixia/Workspace/ixia-IxN-itcl-api/samples/load/SR+_2G_L3_ipoe_v4.ixncfg"
Login "localhost/8009" 0 $configfile
IxDebugOn
Port @portwithname NULL NULL "192.168.3.200:01:06-10GE LAN"
Port @portwithhandle NULL NULL  ::ixNet::OBJ-/vport:2
Traffic @trafficwithname @portwithname "BGPfibv4-EndpointSet-1 - Flow Group 0001"
Traffic @trafficwithhandle @portwithhandle ::ixNet::OBJ-/traffic/trafficItem:23

BgpSession @bgpwithindex @portwithname 1

Dhcpv4Host @dhcpv4withindex @portwithname null 1
Dhcpv4Host @dhcpv4withname @portwithname null "DHCP-R1"
Dhcpv6Host @dhcpv6withindex @portwithname null 1
Dhcpv6Host @dhcpv6withname @portwithname null "DHCP-R3"

IgmpHost @igmphostwithindex @portwithname 1
#MldHost @mldhostwithindex @portwithname 1

#IsisSession @isiswithindex @portwithname 1

PppoeHost @ppoxwithindex @portwithname null 1
PppoeHost @ppoxwithname @portwithname null "PPPOE_dual-4"

#$traffic disable
#$traffic traffic_enable
#$traffic enable
#$traffic traffic_disable
#Tester::start_traffic
#$traffic get_stats
