# Std Cell timing report parsing
# Author: Arnob Karmokar
# Email: contact@arnob.me
# Version: 1.0

set f [open "all_timing_report.rpt" r]
set o [open "output.csv" w]
while {[gets $f line]>=0} {
	if {[regexp {/Y } $line] || [regexp {/ECK } $line] || [regexp {/Q } $line]} {
		set stdCellName [string map {"(" "" ")" ""} [lindex $line 1]] 
		if {[info exists stdCell($stdCellName)]} {
			if {[llength $line]>2} {
				#puts $o "$lineNo: $stdCellName: [lindex $line 4]"
				lappend stdCell($stdCellName) [lindex $line 4]
			} else {
				gets $f line	
				lappend stdCell($stdCellName) [lindex $line 2]
				#puts $o "$lineNo: $stdCellName: [lindex $line 2]"
			}
		} else {
			if {[llength $line]>2} {
				set stdCell($stdCellName) [lindex $line 4]
			} else {
				gets $f line
				set stdCell($stdCellName) [lindex $line 2]
			}
		}
	}
}
#parray stdCell
puts $o "Libcell,Min_Delay,Avg_Delay,Max_Delay"
foreach cell [array names stdCell] {
	set cellDelays [lsort $stdCell($cell)]
	set totalDelay [expr [join $cellDelays +]]
	set avgDelay [expr $totalDelay/[llength $cellDelays]]
	puts $o "$cell,[lindex $cellDelays 0],$avgDelay,[lindex $cellDelays end]"
}

close $o
