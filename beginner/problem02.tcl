#! /usr/bin/tclsh
set t1 0;
set t2 1;

set nextTerm [expr $t1 + $t2];

puts "Enter a fibonacci series value:";
gets stdin n;

set START_TIME [clock clicks -microseconds]
puts -nonewline "The fibonacci series is: $t1 $t2 ";

for {set i 3} {$i<=$n} {incr i} {
	puts -nonewline "$nextTerm ";
	set t1 $t2;
	set t2 $nextTerm;
	set nextTerm [expr $t1 + $t2];
}

set END_TIME [clock clicks -microseconds];

puts "";
puts "Total run time is: [expr $END_TIME - $START_TIME] microseconds";
