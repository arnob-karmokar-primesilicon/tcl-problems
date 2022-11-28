################################################
# Title: Advanced problem 01 - Finding unique pin data after DFT insertion
# Version: 1.0
# Author: Arnob Karmokar
# Date: 28 Nov 2022
################################################
set pinList [read [open "pre_DFT_DEF.txt" r]]
set inputFile [open "lif0_fp_def.txt" r]
set outputFile [open "output.txt" w+]
set flag 0
set flag2 0
while {[gets $inputFile line]>=0} {
	if {[regexp {^PINS} $line]} {
		set flag 1
	}
	if {[regexp {END PINS} $line]} {
		set flag 0
	}
	if {$flag && [regexp {^-} $line]} {
		set flag2 0
		set pinName [string map {[ \\[ ] \\]} [lindex $line 1]]
		if {[regexp $pinName $pinList]==0} {
			set flag2 1
			#puts $outputFile $pinName
		}
	}
	if {$flag2 && $flag} {
		puts $outputFile $line
	}
}

close $outputFile
close $inputFile
