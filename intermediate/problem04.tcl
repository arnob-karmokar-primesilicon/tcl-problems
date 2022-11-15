#######################################
# Title: Intermediate Problem 04 - Prime and Composite Numbers
# Author: Arnob Karmokar
# Version: 1.0
# Date: 7 Nov 2022
#######################################

proc isPrime {n} {
	if {$n==0 || $n==1} {
		return 0
	}
	for {set i 2} {$i<=sqrt($n)} {incr i} {
		if {[expr $n%$i]==0} {
			return 0
		}
	}
	return 1
}

proc isComposite {n} {
	if {$n==0 || $n==1} {
		return 0
	}
	for {set i 2} {$i<=sqrt($n)} {incr i} {
		if {[expr $n%$i]==0} {
			return 1
		}
	}
	return 0
}

puts -nonewline "1. Find composite numbers.\n2. Find prime numbers.\nSelect your operation: ";
flush stdout
gets stdin op;
puts -nonewline "Enter lower range: "
flush stdout
gets stdin lowerLimit
puts -nonewline "Enter higher range: "
flush stdout
gets stdin higherLimit

set numList ""
if {$op==1} {
	for {set i $lowerLimit} {$i<=$higherLimit} {incr i} {
		if {[isComposite $i]} {
			lappend numList $i
		}
	}
	if {[llength $numList]>0} {
		puts "The list of composite number of the range {$lowerLimit to $higherLimit}: $numList"
	} else {
		puts "No composite number in the range {$lowerLimit to $higherLimit}"
	}
} elseif {$op==2} {
	for {set i $lowerLimit} {$i<=$higherLimit} {incr i} {
		if {[isPrime $i]} {
			lappend numList $i
		}
	}
	if {[llength $numList]>0} {
		puts "The list of prime number of the range {$lowerLimit to $higherLimit}: $numList"
	} else {
		puts "No prime number in the range {$lowerLimit to $higherLimit}"
	}
} else {
	puts "Invalid Operation!"
}
