#######################################
# Title: Intermediate Problem 07 - Extract employee information from file
# Author: Arnob Karmokar
# Version: 1.0
# Date: 7 Nov 2022
#######################################

puts "Input File Name"
gets stdin fileName
puts "Input Info"
gets stdin info
set startTime [clock clicks -microseconds]
set f [open $fileName r]
set employeeNumber 0
set op {}
while {[gets $f line]>=0} {
	if {[lindex $line 0]=="Name:"} {
		lappend op "------Info of [lrange $line 1 end]------\n"
		incr employeeNumber
	}
	foreach attr $info {
		set attrFile [join [lrange [split [string tolower [lindex $line 0]] ""] 0 [expr [string length $attr] -1]] ""]
		
		if {$attrFile == $attr} {
			lappend op "$attr => [lrange $line 1 end]\n"
		}
	}
}
puts "number of employee: $employeeNumber"
puts [join $op ""]
set endTime [clock clicks -microseconds]

puts "Runtime: [expr $endTime-$startTime] microseconds"
