proc regenerate { args } {
    set port_list [ list ]
    set streamblock [ list ]
    foreach { key value } $args {
        set key [string tolower $key]
        switch -exact -- $key {
            -port {
                set port_list $value
            }
            -streamblock {
                set streamblock $value
            }
            default {
            }
        }
    }
    set root [ixNet getRoot]
    set flowlist [ list ]
    set trafficlist [ixNet getL [ixNet getL $root traffic] trafficItem]
    foreach trafficItemobj $trafficlist {
        set itemlist [ixNet getL $trafficItemobj highLevelStream]
        foreach trafficobj $itemlist {
            lappend flowlist $trafficobj
        }
    }
    
    # set txlist
    set txList [ list ]
    set txItemList [ list ]		                
    foreach phandle $port_list {         
        foreach flow $flowlist {                                    
            set txPort [ ixNet getA $flow -txPortId ] 
            if { $txPort == $phandle } {
                puts $txPort 
                lappend txList $flow
                puts $txList
                regexp {^(.+)\/highLevelStream.+$} $flow a txItem 
                if { [ lsearch -exact $txItemList $txItem ] == -1 } {
                    lappend txItemList $txItem
                    puts $txItemList
                }
            }      
        }                                               
    }
        
    foreach phandle $streamblock {
        foreach flow $flowlist {                                    
            foreach hstream [ixNet getL $phandle highLevelStream] {          
                if { $flow == $hstream } {
                    if { [ lsearch $txList $flow ] != -1 } {
                        continue
                    }
                    lappend txList $flow
                    puts $txList
                    regexp {^(.+)\/highLevelStream.+$} $flow a txItem 
                    if { [ lsearch -exact $txItemList $txItem ] == -1 } {
                        lappend txItemList $txItem
                        puts $txItemList
                    }
                }
            }
        }                 
    }
	
    if { [ llength $txList ] == 0 } {
        set txList $flowlist
        foreach flow $flowlist { 
            regexp {^(.+)\/highLevelStream.+$} $flow a txItem 
            if { [ lsearch -exact $txItemList $txItem ] == -1 } {
                lappend txItemList $txItem
                puts $txItemList
            }
        }
    }
    
    set suspendList [list]
    puts $txItemList

    set rg_namelist ""
    set rg_ratelist ""
    set rg_ratemode ""
    set rg_sizetype ""
    set rg_fixedsize ""
    set rg_incrfrom ""
    set rg_incrstep ""
    set rg_incrto ""
    foreach flow $txList {
        lappend rg_namelist [ ixNet getA $flow -name ]
        set frame_rate [ ixNet getL $flow frameRate ]
        lappend rg_ratelist [ ixNet getA $frame_rate -rate ]
        lappend rg_ratemode [ ixNet getA $frame_rate -type ]
        set frame_size [ ixNet getL $flow frameSize ]
        lappend rg_sizetype [ ixNet getA $frame_size -type ]
        lappend rg_fixedsize [ ixNet getA $frame_size -fixedSize ]
        lappend rg_incrfrom [ ixNet getA $frame_size -incrementFrom ]
        lappend rg_incrstep [ ixNet getA $frame_size -incrementStep ]
        lappend rg_incrto [ ixNet getA $frame_size -incrementTo ]
    }
        
    foreach item $txItemList { 
        puts $item			
        ixNet exec generate $item
    }
    
    foreach flow $txList rgname $rg_namelist rgrate $rg_ratelist \
        rgmode $rg_ratemode rgsizetype $rg_sizetype rgfixed $rg_fixedsize \
        rgincrfrom $rg_incrfrom rgincrstep $rg_incrstep rgincrto $rg_incrto {
        ixNet setA $flow -name  $rgname
        set frame_rate [ ixNet getL $flow frameRate ]
        ixNet setM $frame_rate -type $rgmode  \
                               -rate $rgrate 
                               
        set frame_size [ ixNet getL $flow frameSize ]
        ixNet setM $frame_size -type $rgsizetype  \
                               -fixedSize $rgfixed \
                               -incrementFrom $rgincrfrom \
                               -incrementStep  $rgincrstep \
                               -incrementTo    $rgincrto
    }
    ixNet commit
    
    after 5000

    ixNet exec apply $root/traffic
    after 3000
}

proc GetEnvTcl { product } {
   
   set productKey     "HKEY_LOCAL_MACHINE\\SOFTWARE\\Ixia Communications\\$product"
   set versionKey     [ registry keys $productKey ]
   set latestKey      [ lindex $versionKey end ]

   if { $latestKey == "Multiversion" } {
      set latestKey   [ lindex $versionKey [ expr [ llength $versionKey ] - 2 ] ]
   }
   set installInfo    [ append productKey \\ $latestKey \\ InstallInfo ]            
   return             [ registry get $installInfo  HOMEDIR ]

}

set ixN_tcl_v "6.0"
puts "connect to ixNetwork Tcl Server version $ixN_tcl_v"
if { $::tcl_platform(platform) == "windows" } {
	puts "windows platform..."
	package require registry

    catch {
	    lappend auto_path  "[ GetEnvTcl IxNetwork ]/TclScripts/lib/IxTclNetwork"
    } 

    puts "load package IxTclNetwork..."
	package require IxTclNetwork
	puts "load package IxTclHal..."	
	catch {	
		source [ GetEnvTcl IxOS ]/TclScripts/bin/ixiawish.tcl
	}
	catch {package require IxTclHal}
}

ixNet connect localhost -version $ixN_tcl_v -port 8009

regenerate