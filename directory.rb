students = [
	{name: "Dr. Hannibal Lecter", cohort: 'november'},
	{name: "Darth Vader", cohort: 'november'},
	{name: "Nurse Ratched", cohort: 'november'},
	{name: "Michael Corleone", cohort: 'november'},
	{name: "Alex DeLarge", cohort: 'november'},
	{name: "The Wicked Witch of the West", cohort: 'november'},
	{name: "Terminator", cohort: 'november'},
	{name: "Freddy Krueger", cohort: 'november'},
	{name: "The Joker", cohort: 'november'},
	{name: "Joffrey Baratheon", cohort: 'november'},
	{name: "Norman Bates", cohort: 'november'}
]

def print_header(headline)
	puts headline
	puts "-------------"
end

def print_names(students)
	students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_footer(list)
	puts "Overall, we have #{list.length} great students"
end

print_header("The Students of Villains Academy:")
print_names(students)
print_footer(students)
