#! /usr/bin/tclsh
## unsolved
proc fibonacci {n} {
	if {$n<=1} {
		return $n;
	} else {
		return [expr [fibonacci n] + [fibonacci [expr $n - 1]];
	}
}

puts "[fibonacci 10]";
