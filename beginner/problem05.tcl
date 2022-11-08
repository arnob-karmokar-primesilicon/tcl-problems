#! /usr/bin/tclsh

proc isPrime {n} {
	if {$n <= 1} {
		return 0;
	}
	for {set i 2} {$i <= sqrt($n)} {incr i} {
		if {[expr $n % $i] == 0} {
			return 0;
		}
	}
	return 1;
}

puts "Operation Selection: \n 1. Finding prime numbers between '0-N'\n 2. Finding Prime numbers between 'M-N'\n 3. Check 'X', prime or not."

gets stdin o;

if {$o == 1} {
	puts "Please enter the value of N: ";
	gets stdin range_max;
	
	puts -nonewline "Prime numbers in 0 to $range_max: ";
	for {set j 0} {$j <= $range_max} {incr j} {
		if {[isPrime $j]==1} {
			puts -nonewline "$j ";
		}
	}
} elseif {$o == 2} {
	puts "Please enter the value of M: ";
	gets stdin range_min;
	puts "Please enter the value of N: ";
	gets stdin range_max;
	
	puts -nonewline "Prime numbers in $range_min to $range_max: ";
	for {set j $range_min} {$j <= $range_max} {incr j} {
		if {[isPrime $j]==1} {
			puts -nonewline "$j ";
		}
	}
} elseif {$o == 3} {
	puts "Please enter a number to check, prime or not: ";
	gets stdin x;
	set ST [clock clicks -milliseconds]
	if {[isPrime $x] == 0} {
		puts "Given number '$x' is not a prime number.";
	} else {
		puts "Given number '$x' is a prime number.";
	}
	set ET [clock clicks -milliseconds]
	puts "[expr $ET-$ST]ms"
} else {
	puts "Invalid Operation";
}

