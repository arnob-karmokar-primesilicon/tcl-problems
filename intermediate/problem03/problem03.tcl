############################################################
# Title: Intermediate Problem 03 - Path Group Splitter
# Author: Arnob Karmokar
# Version: 1.1
# Date: 8 Nov 2022
############################################################

set START_TIME [clock clicks -milliseconds]
set f [open "timing.lifcc.rpt" r]
set folderName "path_group"
if {![file exists $folderName]} {
	file mkdir $folderName
}
set startFlag 0
set pathGroups {}
while {[gets $f line]>=0} {
	if {[regexp "Startpoint" $line]} {	
		set startFlag 1

		# Set Variables to store Path Data
		set pathData {}
		set pathGroupName ""
	}
	if {[regexp "Path Group" $line]} {
		set extracted [split $line ":"]
		set pathGroupName [string map {" " "" "*" ""} [lindex $extracted end]]
		lappend pathGroups $pathGroupName
	}
	if {[regexp {slack \(with no derating\) \(VIOLATED\)} $line]} {
		puts "Processing: $pathGroupName"
		lappend pathData "$line\n"
		set o [open "$folderName/$pathGroupName.rpt" a+]
		puts $o [join $pathData ""]
		close $o
		
		# Reset variables to default values for next path
		set startFlag 0
		set pathData {}
		set pathGroupName ""
	}
	if {$startFlag} {
		lappend pathData "$line\n"
	}
}
set END_TIME [clock clicks -milliseconds]
puts "\nTotal Unique Path Groups: [llength [lsort -u $pathGroups]]"
puts "Runtime: [expr $END_TIME-$START_TIME]ms"
