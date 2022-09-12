#! /usr/bin/tclsh

proc factorial {n} {
	if {$n<=1} {
		return 1;
	}
	return [expr $n * [factorial [expr $n - 1]]];
}


puts "Enter a number: ";

gets stdin number;

set START_TIME [clock clicks -microseconds];

puts "Factorial of $number is : [factorial $number]";

set fac_list [split "" ""];

for {set i 1} {$i<=$number} {incr i} {
	lappend fac_list [factorial $i];
}

puts "All factorials of 1 to $number is: $fac_list";

set sum 0.0;

foreach item $fac_list {
	set sum [expr $sum + $item];
}

puts "Sum: $sum";

puts "Avg: [expr $sum / [llength $fac_list]]";

puts -nonewline "sqrt = ";
foreach item $fac_list {
	puts -nonewline "[expr sqrt($item)] ";
}

set END_TIME [clock clicks -microseconds]
puts "";
puts "Total RUNTIME: [expr $END_TIME - $START_TIME] microsecond(s)";
