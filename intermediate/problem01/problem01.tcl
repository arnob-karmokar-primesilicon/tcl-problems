set f [open "text.txt" r]
set o [open "output.txt" w]
set vowels {a e i o u}
while {[gets $f line]>0} {
	regexp -nocase -indices "summer" $line matched;
		if {[info exists matched]==1} {
			puts $o $line
			puts $o "Replaced String: [lreplace $line end end "replace"]"
			set line [split $line ""]
			puts $o "Reversed String: [join [lreverse $line] ""]"
			# Search all vowels
			set foundVowels ""
			foreach char $line {
				if {[regexp -nocase $char $vowels] && ![regexp " " $char]} {
					lappend foundVowels $char
				}
			}
			puts $o "My vowels: [join $foundVowels ""]"
			puts $o "Number of vowels: [llength $foundVowels`]"
			set uniqueVowels [lsort -u -nocase $foundVowels]
			puts $o "Number of unique vowels: [llength $uniqueVowels]"
			# Print position of each vowels
			foreach char $uniqueVowels {
				puts $o "Position of \"$char\" in my string: [lsearch -all $line $char]"
				#puts $o $char
			}
			unset matched
		}
}
