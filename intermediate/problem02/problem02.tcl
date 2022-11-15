#######################################
# Title: Intermediate Problem 02 - Extracting Delay Cell Info
# Author: Arnob Karmokar
# Version: 1.0
# Date: 7 Nov 2022
#######################################
set f [open "LIF02_Setup_timing.rpt" r]
while {[gets $f line]>=0} {
	if {[regexp "delay250" $line] || [regexp "delay100" $line] || [regexp "DLY" $line]} {
		set name [string map {"(" "" ")" ""} [lindex $line 1]]		
		if {[info exists flop($name)]} {
			set flop($name) [lappend flop($name) [lindex $line 2]] 
		} else {
			set flop($name) [lindex $line 2]
		}
	}
}
close $f

set o [open "output.txt" w]
foreach item [array names flop] {	
	puts $o "$item [lindex [lsort $flop($item)] end] #Occurs [llength $flop($item)] times"
}
close $o
exec sort output.txt > output_s.txt
