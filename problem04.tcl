#! /usr/bin/tclsh

puts "Input A line:";
gets stdin text1;

puts "Input A word:";
gets stdin text2;

set text [split [string tolower $text1] " "];

set search_string [string tolower $text2];

set i 0;
set index [split "" ""];

foreach word $text {
	regexp -nocase -indices $search_string $word matched;

	if {[info exists matched]==1} {
		lappend index $i;
		unset matched;
	}
	incr i;
}

puts "Index is: $index";
