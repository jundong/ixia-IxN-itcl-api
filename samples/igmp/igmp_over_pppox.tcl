lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}

# package name
package req IxiaNet
Login

IxDebugOn
#Port @tester_to_dta1 172.16.174.134/1/1
#Port @tester_to_dta2 172.16.174.134/2/1
Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

PppoeHost pppoe @tester_to_dta1

MulticastGroup @tester.multicast_group(1)
@tester.multicast_group(1) config -group_ip "225.0.1.1" -group_num "1" -group_step "1"

IgmpOverPppoeHost @tester_to_dta1.igmp_host pppoe 
@tester_to_dta1.igmp_host config -group @tester.multicast_group(1)

#pppoe igmp_over_pppoe