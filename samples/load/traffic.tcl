lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
set configfile "C:/Ixia/Workspace/ixia-IxN-itcl-api/samples/load/SR_X2_8G.ixncfg"
Login 
IxDebugOn

set traffic [X2-0/8/0 traffic "arp_x2-EndpointSet-2 - Flow Group 0001"]
$traffic disable
$traffic traffic_enable
$traffic enable
$traffic traffic_disable
#Tester::start_traffic
#$traffic get_stats
