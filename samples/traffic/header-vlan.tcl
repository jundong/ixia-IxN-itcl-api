lappend auto_path [file dirname [file dirname [file dirname [info script]]]]
puts "[file dirname [file dirname [file dirname [info script]]]]"
package req IxiaNet 

IxDebugOn
#-- This is a sample of port initialization
Login
Port port1 NULL NULL ::ixNet::OBJ-/vport:1

VlanHdr hdr
hdr config \
	-id1 100 \
    -id1_num 50 \
    -id1_step 1 \
    -id2_step 1 \
    -id2_num 100 \
	-id2 300 \
    -linked_to "ito" 
	
Traffic tra port1
#IxDebugOn
tra config -pdu hdr
