filepath = $0	# => Returns the absolute filepath
filename = File.basename(__FILE__)	# => Returns base file name

def cant_read
	"You can't read me!"
end

puts File.read(filepath)
