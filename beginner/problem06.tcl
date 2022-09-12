#! /usr/bin/tclsh

proc isConsonant {char} {
	set vowels [split "A E I O U a e i o u , . ? ! ; : _ - ( ) { } '" " "]

	if {[lsearch $vowels $char]==-1 && $char != " "} {
		return 1;
	}	
	return 0;
}

#set text [split "The man is a thief." ""];

set consonants 0

set fp [open "demo.txt" r];

while {[gets $fp data]>=0} {
	set text [split $data ""];

	foreach char $text {
		if {[isConsonant $char] == 1} {
			incr consonants;
		}
	}
}


puts "Number of consonants: $consonants";
