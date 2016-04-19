lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
set configfile "B2BTraffic.ixncfg"
Login "localhost/8009" 1 $configfile
IxDebugOn

# Create Port objects
Port @tester_to_dta1 NULL NULL ::ixNet::OBJ-/vport:1
Port @tester_to_dta2 NULL NULL ::ixNet::OBJ-/vport:2

# Wait 60s for Port Reseting
after 60000

# Create Traffic objects based on traffic name (Don't use space in name)
Traffic @tester_to_dta1.traffic("TrafficItem1") @tester_to_dta1

# Start traffic
Tester::start_traffic
# Wait 30s to gather statistics
after 30000
# Print statistics based on stream
@tester_to_dta1.traffic("TrafficItem1") get_stats
# Stop traffic
Tester::stop_traffic

# Start traffic based on port
@tester_to_dta1 start_traffic
# Wait 30s to gather statistics
after 30000
# Print statistics based on stream
@tester_to_dta1.traffic("TrafficItem1") get_stats
# Stop traffic based on port
@tester_to_dta1 stop_traffic
