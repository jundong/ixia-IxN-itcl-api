lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}
package req IxiaNet
Login
IxDebugOff
#Port @tester_to_dta1 190.2.152.82/5/1
#Port @tester_to_dta2 190.2.152.82/5/2
Port @tester_to_dta1 NULL NULL NULL
Port @tester_to_dta2 NULL NULL NULL

Host @tester_to_dta1.host1 @tester_to_dta1
@tester_to_dta1.host1 config -ip_version ipv4
BgpSession @tester_to_dta1.bgp1 @tester_to_dta1
# config your bgp peer with specific params
@tester_to_dta1.bgp1 config \
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

Host @tester_to_dta1.host2 @tester_to_dta1
@tester_to_dta1.host2 config -ip_version ipv4
BgpSession @tester_to_dta1.bgp2 @tester_to_dta1
# config your bgp peer with specific params
@tester_to_dta1.bgp2 config \
	-ipv4_addr 199.1.2.2 \
	-bgp_id 199.1.2.1 \
	-ipv4_gw 199.1.2.1 \
	-dut_ip 199.1.2.1 \
	-type internal \
	-as 102 \
	-dut_as 101 \
	-enable_flap true \
	-flap_down_time 100 \
	-flap_up_time 200


BgpSession @tester_to_dta2.bgp1 @tester_to_dta2
# config your bgp peer with specific params
@tester_to_dta2.bgp1 config \
	-ipv4_addr 199.2.1.2 \
	-bgp_id 199.2.1.1 \
	-ipv4_gw 199.2.1.1 \
	-dut_ip 199.2.1.1 \
	-type internal \
	-as 102 \
	-dut_as 101 \
	-enable_flap true \
	-flap_down_time 100 \
	-flap_up_time 200

BgpSession @tester_to_dta2.bgp2 @tester_to_dta2
# config your bgp peer with specific params
@tester_to_dta2.bgp2 config \
	-ipv4_addr 199.2.2.2 \
	-bgp_id 199.2.2.1 \
	-ipv4_gw 199.2.2.1 \
	-dut_ip 199.2.2.1 \
	-type internal \
	-as 102 \
	-dut_as 101 \
	-enable_flap true \
	-flap_down_time 100 \
	-flap_up_time 200 