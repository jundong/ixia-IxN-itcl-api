lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
set configfile "C:/Ixia/Configs/B2BTrafficBi.ixncfg"
Login 
IxDebugOn

puts [ find objects ]
set traffic [VMPort1 traffic "FlowGroup1"]
$traffic disable
$traffic traffic_enable
$traffic enable
$traffic traffic_disable
#Tester::start_traffic
#$traffic get_stats
