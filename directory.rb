students = [
	"Dr. Hannibal Lecter",
	"Darth Vader",
	"Nurse Ratched",
	"Michael Corleone",
	"Alex DeLarge",
	"The Wicked Witch of the West",
	"Terminator",
	"Freddy Krueger",
	"The Joker",
	"Joffrey Baratheon",
	"Norman Bates"
]

def print_header(headline)
	puts headline
	puts "-------------"
end

def print_names(list)
	list.each { |x| puts x }
end

def print_footer(list)
	puts "Overall, we have #{list.length} great students"
end

print_header("The Students of Villains Academy:")
print_names(students)
print_footer(students)
