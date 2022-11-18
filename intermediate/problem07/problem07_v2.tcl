#######################################
# Title: Intermediate Problem 07 - Extract employee information from file
# Author: Arnob Karmokar
# Version: 2.0
# Date: 18 Nov 2022
#######################################

puts "Input File Name"
gets stdin fileName
puts "Input Info"
gets stdin info
set f [open $fileName r]
while {[gets $f line]>=0} {
	if {[lindex $line 0]=="Name:"} {
		set employeeName [lrange $line 1 end]
	}
	foreach attr $info {
		if {[regexp -nocase $attr [string map {":" ""} $line]]} {
			dict set employees($employeeName) $attr [lrange $line 1 end]
		}
	}
}

puts "\nNumber of employee: [array size employees]\n"

foreach employee [lsort [array names employees]] {
	puts "------Info of $employee------"
	foreach attr [lsort [dict keys $employees($employee)]] {
		puts "$attr => [dict get $employees($employee) $attr]"
	}
	puts ""
}
