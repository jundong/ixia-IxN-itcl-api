#lappend auto_path [file dirname [file dirname [file dirname [info script]]]]
lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
IxDebugOn
set configfile {C:\Ixia\Workspace\ixia-IxN-itcl-api\samples\load\B2B_2port.ixncfg}
Login "localhost/8009" 1 $configfile
#Login "localhost/8009" 1

Port @portwithname11 "172.16.174.128/1/1"
IPoEHost @ipoe_host("IP-R2") @portwithname11
Traffic @trafficwithname("t1") @portwithname11
Traffic @trafficwithname("t2") @portwithname11
Traffic @trafficwithname("t3") @portwithname11
Traffic @trafficwithname("t4") @portwithname11
Traffic @trafficwithname("t6") @portwithname11
Traffic @trafficwithname("t7") @portwithname11
#Traffic @trafficwithname("t8") @portwithname11za
Traffic @trafficwithname("t9") @portwithname11
Traffic @trafficwithname("t10") @portwithname11

Port @portwithname21 "172.16.174.137/2/1"

#Tester::start_traffic
#after 10
#Tester::stop_traffic

@trafficwithname("t1") start
@trafficwithname("t3") start
after 10
Tester::stop_traffic

@trafficwithname("t1") start
@trafficwithname("t2") start
@trafficwithname("t4") start
@trafficwithname("t7") start
after 10
Tester::stop_traffic

Tester::start_traffic
after 10
Tester::stop_traffic

@trafficwithname("t10") disable
@trafficwithname("t10") enable
#$traffic get_stats
