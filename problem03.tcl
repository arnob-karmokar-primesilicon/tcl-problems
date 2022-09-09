#! /usr/bin/tclsh

puts "Enter filename: ";

gets stdin file_name;

# Check if file exists

if {[file exists $file_name]} {
	# puts "file exists";
	
	#opening file
	set fp [open $file_name r];
	global values;
	set i 0;
	while {[gets $fp data]>=0} {
		#puts $data;
		set values($i) $data;
		incr i;
	}
} else {
	puts "Error: file not found";
}

#puts $values(0);
#puts $values(1);
set var1 [split $values(0) " "];
set var2 [split $values(1) " "];

#puts $var1;
#puts $var2;
for {set i 1} {$i < [llength $values(0)]} {incr i} {
	set [lindex $var2 $i] [lindex $var1 $i];
	puts "[lindex $var2 $i] = [lindex $var1 $i]";
}

#puts $Test_Else;
