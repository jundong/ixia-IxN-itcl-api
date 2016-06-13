lappend auto_path {C:\Ixia\Workspace\ixia-IxN-itcl-api}

proc RFC2544_00 {deviceModel deviceID resultFilePath} {
    # Log file.
    set logFileName RunRFC2544Test.log
    append logFilePathName $resultFilePath$logFileName
    set logFile [open $logFilePathName w]
    puts $logFile "Test started."
    puts $logFile "device Model   = $deviceModel"
    puts $logFile "device ID      = $deviceID"
    puts $logFile "resultFilePath = $resultFilePath"
    puts $logFile "\n"

    set title "$deviceModel $deviceID (8 Ports)"

    set b2bRes [catch {
        # Back to back.
        puts $logFile "B2B test started."
        package req IxiaNet
        # Load configuration file.
        set configfile ./configs/B2B_2Ports.ixncfg
        Login "localhost/8009" 1 $configfile
        IxDebugOn
        Rfc2544 @rfc2544("B2B_2Ports")
        #可选的options： -result_dir -serial_number -version -comments -use_default_root_path
        @rfc2544("B2B_2Ports") configReports -title $title -result_dir $resultFilePath
        # Added sleep time to wait for reseting ports
        after [expr 60 * 1000]
        @rfc2544("B2B_2Ports") start
        Tester::cleanup
    } b2bResInfo]
    
    if {$b2bRes} {
        Tester::cleanup
    }
    puts $logFile "b2bRes     = $b2bRes"
    puts $logFile "b2bResInfo = $b2bResInfo"
    puts $logFile "B2B test stopped.\n"
    
    set frameLossRes [catch {
        # Frame loss.
        puts $logFile "FrameLoss test started."
        package req IxiaNet
        # Load configuration file.
        set configfile ./configs/FL_2Ports.ixncfg
        Login "localhost/8009" 1 $configfile
        IxDebugOn
        Rfc2544 @rfc2544("FL_2Ports")
        #可选的options： -result_dir -serial_number -version -comments -use_default_root_path
        @rfc2544("FL_2Ports") configReports -title $title -result_dir $resultFilePath
        # Added sleep time to wait for reseting ports
        after [expr 60 * 1000]
        @rfc2544("FL_2Ports") start
        Tester::cleanup
    } frameLossResInfo]
    if {$frameLossRes} {
        Tester::cleanup
    }
    puts $logFile "frameLossRes     = $frameLossRes"
    puts $logFile "frameLossResInfo = $frameLossResInfo"
    puts $logFile "frameLoss test stopped.\n"

    set tputRes [catch {
        # Back to back.
        puts $logFile "Tput test started."
        package req IxiaNet
        # Load configuration file.
        set configfile ./configs/TL_2Ports.ixncfg
        Login "localhost/8009" 1 $configfile
        IxDebugOn
        Rfc2544 @rfc2544("TL_2Ports")
        #可选的options： -result_dir -serial_number -version -comments -use_default_root_path
        @rfc2544("TL_2Ports") configReports -title $title -result_dir $resultFilePath
        # Added sleep time to wait for reseting ports
        after [expr 60 * 1000]
        @rfc2544("TL_2Ports") start
        Tester::cleanup
    } tputResInfo]
    if {$tputRes} {
        Tester::cleanup
    }
    puts $logFile "tputRes     = $tputRes"
    puts $logFile "tputResInfo = $tputResInfo"
    puts $logFile "Tput test stopped.\n"

    puts $logFile "Test stopped."
    close $logFile
}

RFC2544_00 deviceModel deviceID C:/Tmp/tmp
