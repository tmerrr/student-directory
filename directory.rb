def input_students
	students = []
	puts "Please enter the name of the students."
	puts "Hit Enter with no input to finish."
	loop do 
		name = gets.chomp
		puts
		break if name.empty?
		students << {name: name, cohort: 'october'}
		puts "#{name} has been added."
		puts "We now have a total of #{students.count} students."
		puts
	end
	students
end

def print_header(headline)
	puts headline
	puts "-------------"
end

def print_names(students)
	students.each_with_index { |student, index| puts "#{index + 1}.  #{student[:name]} (#{student[:cohort].capitalize} cohort)" }
end

def print_footer(students)
	puts "Overall, we have #{students.length} great students"
end

students = input_students
print_header("The Students of Makers Academy:")
print_names(students)
print_footer(students)
