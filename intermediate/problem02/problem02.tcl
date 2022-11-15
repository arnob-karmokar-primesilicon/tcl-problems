#######################################
# Title: Intermediate Problem 02 - Extracting Delay Cell Info
# Author: Arnob Karmokar
# Version: 1.1
# Date: 15 Nov 2022
#######################################

proc mode {list} {
    foreach val $list {dict incr h $val}
    set h [lsort -stride 2 -index 1 -decreasing -integer $h]
    return [lrange $h 0 1]
}

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
	set max_delay [mode $flop($item)]
	puts $o "$item [lindex $max_delay 0] #Occurs [lindex $max_delay 1] times"
}
close $o
