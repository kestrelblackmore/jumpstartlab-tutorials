require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing"
		@client = JumpstartAuth.twitter
	end

	def run
		puts "Welcome to Kestrel's Twitter Client!"

		command = ""
		while command != "q"
			printf "Enter command: "
			command = gets.chomp

			case command
				when 'q' then puts "Goodbye!"
				else
					puts "Sorry, I don't know how to #{command}"
			end
			
		end

	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			 puts "Message must be less than 140 characters"
		end
	end
end

blogger = MicroBlogger.new
blogger.run
#blogger.tweet("".ljust(141, "abcd"))
