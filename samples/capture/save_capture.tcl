lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
Login
IxDebugOff
Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2

Capture @capture_port1 @tester_to_dta2

@capture_port1 start

Tester::start_traffic
after 30000
Tester::stop_traffic

@capture_port1 stop
@capture_port1 save -result_dir {C:\Tmp} -filters "-Y ip.version==4 -e ip.version"