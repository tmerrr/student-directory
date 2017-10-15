def input_students
	students = []
	puts "Please enter the name of the students."
	puts "Hit Enter with no input to finish."
	loop do 
		name = gets.chomp
		puts
		break if name.empty?
		puts "Please enter cohort"
		cohort = gets.chomp
		puts
		puts "Please enter DOB (DD/MM/YYYY)"
		dob = gets.chomp
		puts
		students << {name: name, cohort: cohort, dob: dob}
		puts "#{name} has been added."
		puts "We now have a total of #{students.count} #{students.count > 1 ? 'students' : 'student'}."
		puts
	end
	students
end

def print_header(headline)
	width = 50
	puts headline.center(width)
	puts "-------------".center(width)
end

def print_all_names(students)
	# => Using each with index:
	# students.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }

	# => Using loop:
	iter = 0
	while iter < students.length
		student = students[iter]
		iter += 1
		puts "#{iter}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)"
	end
end

def print_with_initial(students, initial)
	# => Print if letter begins with chosen initial.
	selection = students.select { |student| student[:name][0].downcase == initial.downcase }
	selection.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
end

def print_names_less_than(students, x)
	# => Print names with less than x characters
	selection = students.select { |student| student[:name].length < x }
	selection.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
end

def print_footer(students)
	width = 50
	puts "-------------".center(width)
	if students.empty?
		puts "No students have been added to the directory.".center(width)
	else
		puts "Overall, we have #{students.length} great #{students.length > 1 ? 'students' : 'student'}".center(width)
	end
end

students = input_students
print_header("The Students of Makers Academy:")
print_all_names(students)
print_footer(students)

# print_with_initial(students, 'a')
# print_names_less_than(students, 5)
