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
			
			input = gets.chomp
			parts = input.split
			command = parts[0]

			case command
				when 'q' then puts "Goodbye!"
				when 't' then tweet(parts[1..-1].join(" "))
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				when 'p' then test_functionality
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

	def dm(target, message)
		puts "Trying to send #{target} this direct message:"
		puts message

		screen_names = get_friends

		if screen_names.include?(target)
			tweet("d #{target} #{message}")
			puts "Message sent."

		else
			puts "#{target} does not follow you so I couldn't DM them for you :("
		end

	end

	def test_functionality
		#puts get_friends
	end

	private

	def get_friends
		@client.followers.collect { |follower| follower.screen_name }
	end

end

blogger = MicroBlogger.new
blogger.run
#blogger.tweet("".ljust(141, "abcd"))
