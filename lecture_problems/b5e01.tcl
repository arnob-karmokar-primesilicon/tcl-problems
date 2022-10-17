#! /usr/bin/tclsh

set mylist {0 0 0 0}
set size [llength $mylist]
puts $mylist

for {set i [expr $size - 1]} {$i >= 0} {incr i -1} {
	for {set j 0} {$j < $size} {incr j} {
		set mylist [lreplace $mylist $i $i [expr $j + 1]] 
		puts $mylist
	}
}
