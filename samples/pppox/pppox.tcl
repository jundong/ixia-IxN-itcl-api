lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}

# package name
package req IxiaNet
Login

# generate Port object by reservint chassis 192.168.8.1 card 1 port 1
Port port1 NULL NULL NULL
PppoeHost pppoe port1

pppoe config \
	-mru_size 1234 \
	-vlan_id1 1111 \
	-vlan_id2 1112 \
	-vlan_id1_step 2221 \
	-vlan_id2_step 2222\
	-vlan1_per_port 3333 \
	-vlan2_per_port 3334 
