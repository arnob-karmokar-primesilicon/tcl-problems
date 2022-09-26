#! /usr/bin/tclsh

set fp [open "text.txt" r];
set currentLine 1;
while {[gets $fp line]>=0} {
	set words [split $line " "];
	set count 0;
	set index 0;
	set updatedLine $words;
	foreach word $words {
		regexp -nocase -indices "summer" $word matched; 
		if {[info exists matched]==1} {
			incr count;
			set updatedLine [lreplace $updatedLine $index $index [string replace $word 0 5 "winter"]];
			unset matched;
		}
		incr index;
	}
	if {$count>0} {
		puts "$currentLine: $count";
		puts $updatedLine;
	}
	incr currentLine;
}
