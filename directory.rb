def input_students
	students = []
	puts "Please enter the student information"
	puts "Hit Enter with no input to finish."
	puts
	loop do 
		puts "Please enter full name."
		name = gets.chomp
		puts
		break if name.empty?
		puts "Please enter cohort."
		cohort = gets.chomp
		cohort = cohort.empty? ? 'October' : cohort
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

def print_all(selection)
	# => Using each with index:
	print_header("The Students of Makers Academy:")
	unless selection.empty?
		selection.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
	else
		puts "No students in current selection".center(50)
	end

	# => Using loop:
	# iter = 0
	# while iter < students.length
	# 	student = students[iter]
	# 	iter += 1
	# 	puts "#{iter}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)"
	# end
end

def print_cohort(students)
	# => Print list of students from a specific cohort
	puts "Which cohort would you like to sort by?"
	cohort = gets.chomp
	puts
	selection = students.select { |student| student[:cohort] == cohort }
	print_all(selection)
end

def print_with_initial(students)
	# => Print if letter begins with chosen initial.
	puts "Which initial would you like to sort by?"
	initial = gets.chomp.downcase
	puts
	if initial.length == 1
		selection = students.select { |student| student[:name][0].downcase == initial }
		print_all(selection)
	else
		puts "Please enter 1 initial."
		print_with_initial(students)
	end
end

def print_names_less_than(students)
	# => Print names with less than x characters
	puts "What's the maximum number of characters in a name you'd like to see?"
	num = gets.chomp.to_i
	puts
	selection = students.select { |student| student[:name].length < num }
	print_all(selection)
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

def sort?
	puts "Would you like to sort / filter your list of students? [y / n]"
	input = gets.chomp.downcase
	puts
	if input == 'y'
		true
	elsif input == 'n'
		false
	else
		puts "Not a valid repsonse. Please answer with 'y' or 'n'"
		sort?
	end
end

def get_sort
	puts "How would you like to sort the list of students?"
	puts "Options: cohort / initial / characters"
	input = gets.chomp.downcase
	puts
	if ['cohort', 'initial', 'characters'].include?(input)
		input
	else
		puts "#{input} is not a valid option."
		get_sort
	end
end

students = input_students
print_what = sort? ? get_sort : 'all'
case print_what
when 'cohort' then print_cohort(students)
when 'initial' then print_with_initial(students)
when 'characters' then print_names_less_than(students)
else
	print_all(students)
end
print_footer(students)
