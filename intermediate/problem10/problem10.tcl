###################################################
# Title: Intermediate Problem 10 - Delay Buffer Remover
# Author: Arnob Karmokar
# Version: 1.0
# Date: 14 Nov 2022
###################################################
source "subset.tcl"
set tcl_precision 4
set f [open "Input.txt" r]
set o [open "output.txt" w]
set b [open "buffers.txt" w]
set flag 0
set flag2 0
while {[gets $f line]>=0} {
	if {[regexp {Startpoint:} $line]} {
		set flag 1
		set tempData ""
	}
	if {[regexp {slack \(VIOLATED\)} $line]} {
		lappend tempData $line
		puts $o [join $tempData "\n"]
		set violationTime [lindex $line 2]
		set ss [subset [llength $buffers]]
		set bestSlackTime 1000000
		set bestSlackSubset ""
		foreach set $ss {
			set totalTime 0
			set delays "Delay Values are: "
			foreach item $set {
				lappend delays [lindex [lindex $buffers $item] 2]
				set totalTime [expr [lindex [lindex $buffers $item] 2]+$totalTime]
			}
			set newSlack [expr abs($totalTime + $violationTime)]
			if {$newSlack<=.1} {
				puts $o "New slack = $newSlack; [join $delays " "]"
				if {$newSlack < $bestSlackTime} {
					set bestSlackTime $newSlack
					set bestSlackSubset $set
				}
			}
		}
		puts $o "\nBuffers to remove:"
		foreach item $bestSlackSubset {
			puts $o [lindex $buffers $item]
		}
		puts $o "Resulting Slack is:\t\t$bestSlackTime\n\n"
		set flag 0
		set flag2 0
		set buffers ""
		set tempData ""

	}
	if {[regexp {Path Type: max} $line]} {
		set flag2 1
		lappend tempData $line
		set buffers ""
		gets $f line
	}
	if {$flag2} {
		lappend buffers [regsub -all {\s+} $line " "]
	}
	if {$flag} {
		lappend tempData $line
	}
}

