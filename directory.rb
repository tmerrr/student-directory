@students = []
@width = 50

def menu
	loop do
		print_menu_options
		menu_selection(get_input)
	end
end

def print_menu_options
	puts "What would you like to do next?"
	puts "1. Input students"
	puts "2. Print students"
	puts "3. Save list to file"
	puts "4. Load list from file"
	puts "9. Exit program"
end

def menu_selection(user_input)
	case user_input
	when '1' then input_students
	when '2' then sort_students
	when '3' then save_students
	when '4' then check_before_load
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

def get_input
	input = STDIN.gets.chomp
	puts
	input
end

def input_students
	puts "Please enter the student information:"
	puts "Enter a blank name to exit."
	puts
	loop do 
		puts "Please enter full name."
		name = get_input
		break if name.empty?
		puts "Please enter cohort."
		cohort = get_month
		add_to_student_array(name, cohort)
		puts "#{name} has been added."
		puts "We now have a total of #{@students.count} #{@students.count > 1 ? 'students' : 'student'}."
		puts
	end
end

def get_month
	months = [	'January', 'February', 'March', 'April', 'May', 'June',
				'July', 'August', 'September', 'October', 'November', 'December']
	input = get_input.capitalize
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

def add_to_student_array(name, cohort)
	@students << {name: name, cohort: cohort}
end

def print_header(headline)
	puts headline.center(@width)
	puts "-------------".center(@width)
end

def print_names(selection)
	# => Using each with index:
	print_header("The Students of Makers Academy:")
	unless selection.empty?
		selection.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
		puts
		puts "#{selection.count} #{selection.count > 1 ? 'students' : 'student'} in the current selection".center(@width)
		puts
	else
		puts "No students in current selection".center(@width)
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
	initial = get_input.downcase
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
	num = get_input.to_i
	selection = @students.select { |student| student[:name].length <= num }
	print_names(selection)
end

def print_footer
	puts "-------------".center(@width)
	if @students.empty?
		puts "No students have been added to the directory.".center(@width)
		puts
	else
		puts "Overall, we have #{@students.length} great #{@students.length > 1 ? 'students' : 'student'}".center(@width)
		puts
	end
end

def get_sort
	puts "How would you like to sort the list of students?"
	puts "Options: all / cohort / initial / characters"
	input = get_input.downcase
	input = 'all' if input.empty?
	if ['all', 'cohort', 'initial', 'characters'].include?(input)
		input
	else
		puts "#{input} is not a valid option."
		get_sort
	end
end

def save_students
	puts "Name the file you wish to save to. Enter a blank to save to default file."
	filename = get_filename
	unless check_before_save(filename)
		return puts "Cancelled. Did not save to #{filename}"
	end
	save_process(filename)
	save_load_feedback_message(false, filename)
end

def save_process(filename)
	File.open(filename, 'w') do |file|
		@students.each do |student|
			student_data = [student[:name], student[:cohort]]
			csv_line = student_data.join(',')
			file.puts csv_line
		end
	end
end

def check_before_save(filename)
	if File.exist?(filename)
		puts "A file called #{filename} already exists. Would you like to overwrite it?"
		confirm?
	else
		true
	end
end

def confirm?
	puts "Options: y / n"
	choice = get_input
	case choice.downcase
	when 'y' then true
	when 'n' then false
	else
		puts "#{choice} is not a valid option"
		confirm?
	end
end

def get_filename
	filename = get_input
	filename = "students.csv" if filename.empty?
	filename
end

def check_before_load
	if @students.any?
		puts "Loading from a file will overwrite the current list.  Would you like to continue?"
		return puts "Cancelled.  Did not load from file." unless confirm?
	end
	filename = get_load_file
	if File.exist?(filename)
		load_students(filename)
	else
		puts "Cancelled. File not found."
	end
end

def get_load_file
	puts "Which file would you like to load from? Enter a blank for the default file."
	get_filename
end

def load_students(filename = 'students.csv')
	@students.clear
	file = File.open(filename, 'r')
	file.readlines.each do |line|
		name, cohort = line.chomp.split(',')
		add_to_student_array(name, cohort)
	end
	file.close
	save_load_feedback_message(true, filename)
end

def try_load_students
	filename = ARGV.first
	return load_students if filename.nil?
	if File.exist?(filename)
		load_students(filename)
	else
		abort "#{filename} not found"
	end
end

def save_load_feedback_message(load, filename)
	puts "Successfully #{load ? 'loaded' : 'saved'} #{@students.count} students #{load ? 'from' : 'to'} #{filename}"
	puts
end

try_load_students
menu
