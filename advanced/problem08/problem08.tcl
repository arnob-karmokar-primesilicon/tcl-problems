set inputFile [read [open "input.txt" r]]

puts $inputFile

puts "No of Sentence [llength [regexp -inline -all {\?|\.|\!} $inputFile]]"

puts "No of Word [llength [regexp -inline -all { } $inputFile]]"

