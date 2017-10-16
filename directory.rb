def menu
	@students = []
	loop do
		print_menu_options
		menu_selection(gets.chomp)
	end
end

def print_menu_options
	puts "What would you like to do next?"
	puts "1. Input students"
	puts "2. Print students"
	puts "3. Save list to students.csv"
	puts "9. Exit program"
end

def menu_selection(user_input)
	puts
	case user_input
	when '1' then input_students
	when '2' then sort_students
	when '3' then save_students
	when '9' then abort('Program Ended')
	else
		puts "#{user_input} is not a valid entry"
	end
end

def sort_students
	case get_sort
	when 'all' then print_names(@students)
	when 'cohort' then print_cohort
	when 'initial' then print_with_initial
	when 'characters' then print_max_chars
	end
	print_footer
end

def input_students
	puts "Please enter the student information:"
	puts "Enter a blank name to exit."
	puts
	loop do 
		puts "Please enter full name."
		name = gets.chomp
		puts
		break if name.empty?
		puts "Please enter cohort."
		cohort = get_month
		@students << {name: name, cohort: cohort}
		puts "#{name} has been added."
		puts "We now have a total of #{@students.count} #{@students.count > 1 ? 'students' : 'student'}."
		puts
	end
end

def get_month
	months = [	'January', 'February', 'March', 'April', 'May', 'June',
				'July', 'August', 'September', 'October', 'November', 'December']
	input = gets.chomp.capitalize
	puts
	if input.empty?
		# => Default cohort.
		'October'
	elsif months.include?(input)
		input
	else
		puts "#{input} is not a valid month. Please try again."
		get_month
	end
end

def print_header(headline)
	width = 50
	puts headline.center(width)
	puts "-------------".center(width)
end

def print_names(selection)
	width = 50
	# => Using each with index:
	print_header("The Students of Makers Academy:")
	unless selection.empty?
		selection.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
		puts
		puts "#{selection.count} #{selection.count > 1 ? 'students' : 'student'} in the current selection".center(width)
		puts
	else
		puts "No students in current selection".center(width)
	end
end

def print_cohort
	# => Print list of students from a specific cohort
	puts "Which cohort would you like to sort by?"
	cohort = get_month
	puts
	selection = @students.select { |student| student[:cohort] == cohort }
	print_names(selection)
end

def print_with_initial
	# => Print if letter begins with chosen initial.
	puts "Which initial would you like to sort by?"
	initial = gets.chomp.downcase
	puts
	if initial.length == 1
		selection = @students.select { |student| student[:name][0].downcase == initial }
		print_names(selection)
	else
		puts "Please enter 1 initial."
		print_with_initial
	end
end

def print_max_chars
	# => Print names with less than x characters
	puts "What's the maximum number of characters in a name you'd like to see?"
	num = gets.chomp.to_i
	puts
	selection = @students.select { |student| student[:name].length <= num }
	print_names(selection)
end

def print_footer
	width = 50
	puts "-------------".center(width)
	if @students.empty?
		puts "No students have been added to the directory.".center(width)
		puts
	else
		puts "Overall, we have #{@students.length} great #{@students.length > 1 ? 'students' : 'student'}".center(width)
		puts
	end
end

def get_sort
	puts "How would you like to sort the list of students?"
	puts "Options: all / cohort / initial / characters"
	input = gets.chomp.downcase
	puts
	if ['all', 'cohort', 'initial', 'characters'].include?(input)
		input
	else
		puts "#{input} is not a valid option."
		get_sort
	end
end

def save_students
	file = File.open("students.csv", 'w')
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(',')
		file.puts csv_line
	end
	file.close
end

menu
