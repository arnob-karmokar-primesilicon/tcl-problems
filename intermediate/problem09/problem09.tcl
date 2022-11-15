#######################################
# Title: Intermediate Problem 09 - Area Extension of list of Rectangular Instance
# Author: Arnob Karmokar
# Version: 1.0
# Date: 15 Nov 2022
#######################################

set tcl_precision 6
set f [open "library_spec_14_05_18.txt" r]

puts "Enter Memory Name:"
#set memoryName "memory_m1"
gets stdin memoryName
puts "Enter Extension:"
#set extension "10 15 10 15"
gets stdin extension

set ST [clock click -microseconds]

while {[gets $f line]>=0} {
	# Parse lc_dimensions
	if {[regexp {lc_dimension: } $line]} {
		foreach item [lindex $line 1] {
			set lcDim([lindex $item 0]) [lindex $item 1]
		}
	}

	# Parse lib_cell
	if {[regexp {lib_cell } $line]} {
		foreach item [lindex $line 1] {
			set memoryLC([lindex $item 0]) [string map {" " ""} [lindex $item 1]]
		}
	}
	# Parse memory_origin
	if {[regexp {^  memory_m[0-9] } $line]} {
		set memoryOrigin([lindex $line 0]) [lindex $line 1]
	}

	if {[regexp {die_area} $line]} {
		set die_area [lindex $line 1]
	}

	if {[regexp {die_aspect_ratio} $line]} {
		set die_aspect_ratio [lindex $line 1]
	}

	if {[regexp {core2die} $line]} {
		set core2die [string map {"'" ""} [lrange $line 1 2]]
	}

}

set height [expr sqrt($die_area/$die_aspect_ratio)]
set width [expr $height * $die_aspect_ratio]
puts "Height is: $height"
puts "Width is: $width"
set pitchY [lindex $core2die 1]
set pitchX [lindex $core2die 0]
puts "Upper right of core is = [set coreWidthPitch [expr $width - $pitchX]] [set coreHeightPitch [expr $height - $pitchY]]"

set coreWidth $pitchX
set coreHeight $pitchY
while {$coreWidth<$coreWidthPitch} {
	set coreWidth [expr $coreWidth + $pitchX]
}
if {$coreWidth>$coreWidthPitch} {
	set coreWidth [expr $coreWidth - $pitchX]
}

while {$coreHeight<$coreHeightPitch} {
	set coreHeight [expr $coreHeight + $pitchY]
}
if {$coreHeight>$coreHeightPitch} {
	set coreHeight [expr $coreHeight - $pitchY]
}
puts "Upper right of core align with pitch = $coreWidth $coreHeight"
set lx [lindex $memoryOrigin($memoryName) 0]
set ly [lindex $memoryOrigin($memoryName) 1]
puts "LL of memory = $lx $ly"

set lcMem $lcDim($memoryLC($memoryName))
set ux [expr $lx + [lindex $lcMem 0]]
set uy [expr $ly + [lindex $lcMem 1]]
puts "UR of memory = $ux $uy"

puts "Extension is = $extension"
if {[llength $extension]==1} {
	set elx [expr $lx-$extension]
	set euy [expr $uy + $extension]
	set eux [expr $ux + $extension]
	set ely [expr $lx - $extension]
} elseif {[llength $extension]==4} {
	set elx [expr $lx - [lindex $extension 0]]
	set euy [expr $uy + [lindex $extension 1]]
	set eux [expr $ux + [lindex $extension 2]]
	set ely [expr $lx - [lindex $extension 3]]
}

puts "EXTENSION (E N W S) = $elx $euy $eux $ely" 

if {$ely < $pitchY} {
	set ely $pitchY
}
if {$elx < $pitchX} {
	set elx $pitchX
}
puts "LL IS: $elx $ely"
puts "UP IS: $eux $euy"

set ET [clock clicks -microseconds]

puts "Total runtime is: [expr $ET - $ST] microseconds"


