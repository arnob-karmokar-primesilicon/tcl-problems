puts "Enter a List of number:";
gets stdin numberList;
set listLength [llength $numberList];
set i 0;
set sum 0.0;
set sqSum 0.0;
set sqError 0.0;
foreach num $numberList {
	set sum [expr $sum + $num];
	set sqSum [expr $sqSum + [expr {$num ** 2}]];
}
set avg [expr $sum / $listLength];
foreach num $numberList {
	set sqError [expr [expr $num - $avg] ** 2]; 
}
puts "Sum of list : $sum";

#set avg [expr $sum / $listLength];
puts "Average: $avg";

puts "Square mean: [expr $sqSum / $listLength]";

puts "Standard Dev: [expr sqrt([expr $sqError / [expr $listLength - 1]])]";
