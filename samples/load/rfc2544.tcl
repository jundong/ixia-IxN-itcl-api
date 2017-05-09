lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req IxiaNet
#以下代码是用来load现有配置文件的
set configfile "C:/Ixia/Workspace/ixia-IxN-itcl-api/samples/load/B2B_2Ports.ixncfg"
Login "localhost/8009" 1 $configfile
#Login "localhost/8009" 1
IxDebugOn
Rfc2544 @rfc2544("QuickTest1")
#可选的options： -result_dir -serial_number -version -comments -use_default_root_path
@rfc2544("QuickTest1") configReports -title "B2B Quick Test" -result_dir C:/Ixia/Results/RFC2544/B2BTests
@rfc2544("QuickTest1") start