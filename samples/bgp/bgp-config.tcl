#lappend auto_path [file dirname [info script]]/lib
lappend auto_path [file dirname [file dirname [file dirname [info script]]]]
# package name
package req IxiaNet

# 192.168.8.128 locates the IxNetwork Tcl Server address, 1 means connect in a force way
#Login 192.168.8.128 1
Login

# generate Port object by reservint chassis 192.168.8.1 card 1 port 1
Port port1 NULL NULL ::ixNet::OBJ-/vport:1
Port port2 NULL NULL ::ixNet::OBJ-/vport:2
#Port port1 172.16.174.128/1/1
#Port port2 172.16.174.128/2/1

# create bgp peer on certain port
BgpSession bgp1 port1
BgpSession bgp2 port2

# config your bgp peer with specific params
bgp1 config \
	-ipv4_addr 199.1.1.2 \
	-bgp_id 199.1.1.1 \
	-ipv4_gw 199.1.1.1 \
	-dut_ip 199.1.1.1 \
	-type internal \
	-as 102 \
	-dut_as 101 \
	-enable_flap true \
	-flap_down_time 100 \
	-flap_up_time 200 

bgp2 config \
	-ipv4_addr 199.1.1.1 \
	-bgp_id 199.1.1.2 \
	-ipv4_gw 199.1.1.2 \
	-dut_ip 199.1.1.2 \
	-type internal \
	-as 102 \
	-dut_as 101

bgp1 get_stats
bgp2 get_stats


