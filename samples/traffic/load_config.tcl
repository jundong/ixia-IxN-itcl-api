lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
Login 
IxDebugOn
Port @tester_to_dta1 190.2.152.82/5/1
Port @tester_to_dta2 190.2.152.82/5/2
Port @tester_to_dta3 190.2.152.82/5/3

Tester::start_traffic
@tester_to_dta1.traffic(1) get_stats
