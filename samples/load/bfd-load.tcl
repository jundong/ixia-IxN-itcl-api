lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#set configfile "C:/Ixia/Configs/B2BTraffic.ixncfg"
set configfile "C:/Ixia/Workspace/ixia-IxN-itcl-api/samples/load/SR_X2_8G.ixncfg"
Login 
IxDebugOn

puts [ find objects ]
set root [ixNet getRoot]
set vports [ixNet getL $root vport]
set x2080 [lindex $vports 8]
set port "X2-0/8/0"
set protocolsx2080 [ixNet getL $x2080 protocols]
set bgpx2080 [ixNet getL $protocolsx2080 bgp]
set traffic [$port traffic "arp_x2-EndpointSet-2 - Flow Group 0001"]
set protocol [$port protocol "bfd"]
set proStack [ixNet getL $x2080 protocolStack]
#set eth [ixNet getL $proStack ethernet]
#set dhcp [ixNet getL $eth dhcpEndpoint]

