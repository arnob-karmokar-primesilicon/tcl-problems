#######################################
# Title: Intermediate Problem 05 - Transition timing of Pins
# Author: Arnob Karmokar
# Version: 1.1
# Date: 8 Nov 2022
#######################################
set inputFiles [glob -path "data" *]
set o [open "output.csv" w]
puts $o "Filename,Pin,Direction,Max rise time,Max fall time,Worst Transition,Limit,Slack"
foreach inputFile $inputFiles {
	set f [open $inputFile r]
	while {[gets $f line]>=0} {
		if {[regexp {\*\* Pin :} $line] && ![regexp {inout} $line]} {
			set pinName [lindex $line 3]
			set timingData [split [string map {" " "" "(" "" ")" "" "R=" "" "F=" "" "Threshold=" "" "LibThreshold=" ""} [lrange $line 4 end]] ","]
			#puts $timingData
			set pinDirection [lindex $timingData 0]
			set riseTime [lindex $timingData 1]
			set fallTime [lindex $timingData 2]
			set worstTrans [expr $riseTime>$fallTime?$riseTime:$fallTime]
			set threshold [lindex $timingData 3]
			set slack [expr $worstTrans - $threshold]
			puts $o "$inputFile,$pinName,$pinDirection,$riseTime,$fallTime,$worstTrans,$threshold,$slack"
		}
	}
	close $f
}
close $o
