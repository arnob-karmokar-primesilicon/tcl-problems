############################################
# Title: Advanced Problem 09 - Read two input file and compare user data with the user data
# Version: 1.0
# Author: Arnob Karmokar
# Email: arnob.karmokar@primesilicon.com
# Date: 29 Nov 2022
############################################
set inputFile [open "main.txt" r]
set tableStart 0
while {[gets $inputFile line]>=0} {
	if {[regexp -nocase {worked|performance|regularity} $line]} {
		set std([string map {"Worked" "Work Hour" } [lrange $line 0 end-1]]) [lindex $line end]
	}
	if {[regexp -nocase {Heart Rate \d+-\d+|sleep|Blood Pressure \d+-\d+} $line]} {
		if {![info exists stdHealth([lrange $line 0 end-1])]} {
			set stdHealth([lrange $line 0 end-1]) [lindex $line end]
		}
	}	
	if {[regexp {BMI CHART} $line]} {
		set tableStart 1
		gets $inputFile line
		gets $inputFile line
		set bmiList [lrange $line 1 end]
		gets $inputFile line
		gets $inputFile line
	}
	if {$tableStart} {
		set currentRow 0
		foreach weight [lrange $line 1 end] {
			set bmi([lindex $line 0],$weight) [lindex $bmiList $currentRow]
			incr currentRow
		}
	}
}
close $inputFile
foreach info [array names std] {
	puts -nonewline "Standard $info $std($info), "
}
puts -nonewline "\nStandard Health Information: "
foreach info [array names stdHealth] {
	puts -nonewline "$info $stdHealth($info), "
}
puts ""
set inputFile [open "Information.txt" r]

while {[gets $inputFile line]>=0} {
	if {[regexp -nocase {name} $line]} {
		set name [lrange $line 1 end]
	}
	if {[regexp -nocase {height|weight|heart|sleep|work|performance} $line]} {
		dict set userInfo($name) [lrange $line 0 end-1] [string map {hr ""} [lindex $line end]]
	}
	if {[regexp -nocase {^\d} $line]} {
		lappend userRegularity($name) [lindex $line end]
	}
}

foreach user [array names userInfo] {
	puts "\n########## Name $user ##########"
	set regularity [expr [expr [join $userRegularity($user) "+"]] / [llength $userRegularity($user)]]
	puts -nonewline "Regularity $regularity "
	foreach val [dict keys $userInfo($user)] {
		puts -nonewline "$val [dict get $userInfo($user) $val] "
	}

	if {[dict get $userInfo($user) sleep]<=$stdHealth(Sleep)} {
		puts "\nSleep at least 7hr"
	} else {
		puts "\nMuch Sleep. Cut down it to 7hr."
	}
	if {[dict get $userInfo($user) Performance]>$std(Performance)} {
		puts "Performance: Good"
	} else {
		puts "Performance: Need to Improve"
	}
	if {$regularity>$std(Regularity)} {
		puts "Regularity: Good Keep It Up"
	} else {
		puts "Regularity: Need to Improve"
	}
	puts "BMI: $bmi([dict get $userInfo($user) Height],[dict get $userInfo($user) Weight])"
}
