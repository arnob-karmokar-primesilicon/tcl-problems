proc dec2bin {number bit} {
	set bin ""
	# Calculates minimum required bits for the given number
	if {$number==0} {
		set bit 1
	} else {
		set bit [expr [expr int(log($number)/log(2) + 1)]>$bit?[expr int(log($number)/log(2) + 1)]:$bit]
	}
	while {$number > 0 || $bit>[llength $bin]} {
		lappend bin [expr $number%2]
		set number [expr $number/2]
	}
	return [lreverse $bin]
}

proc subset {n} {
	set setList {}
	set bit [expr int(log(($n**2)-1)/log(2) + 1)]
	for {set i 0} {$i<$n**2} {incr i} {
		set bin [dec2bin $i $bit]
		set idx 0
		set ss {}
		foreach item [lreverse $bin] {
			#puts $item
			if {$item} {
				lappend ss $idx
			}
			incr idx
		}
		lappend setList $ss
	}
	return $setList
}

#puts [subset 3]
