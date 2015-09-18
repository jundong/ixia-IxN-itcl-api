lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
Login 
IxDebugOn

puts "********************************"
puts [ find objects ]
puts "********************************"

set traffic [VMPort1 traffic('TrafficItem1')]
$traffic disable

#Tester::start_traffic
#@tester_to_dta1.traffic(1) get_stats
