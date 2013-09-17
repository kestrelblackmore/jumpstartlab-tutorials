require 'jumpstart_auth'
require 'bitly'



class MicroBlogger
	attr_reader :client
	
	def initialize
		puts "Initializing"
		@client = JumpstartAuth.twitter

		Bitly.use_api_version_3
		@bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
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
				when 'elt' then everyones_last_tweet
				when 's' then shorten parts[1]
				when 'turl' then tweet((parts[1..-2].join(" ")) + " " + shorten(parts[-1]))
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

		if get_followers.include?(target)
			tweet("d #{target} #{message}")
			puts "Message sent."

		else
			puts "#{target} does not follow you so I couldn't DM them for you :("
		end

	end

	def everyones_last_tweet
		# get list of those I'm following
		friends = @client.friends[0..5].sort_by { |friend| friend.screen_name.downcase}
		friends.each do |friend|
			puts "#{friend.screen_name} said (#{friend.status.created_at.strftime("%A, %b %d")}): #{friend.status.text}"
			puts "--"
		end

	end

	def shorten(url)
		#shorten url here
		short_url = @bitly.shorten(url).short_url

		puts "Shortening this url: #{url}"
		puts "To: #{short_url}"

		return short_url
	end


	def test_functionality
		#puts get_followers
	end

	private

	def get_followers
		@client.followers.collect { |follower| follower.screen_name }
	end

end

blogger = MicroBlogger.new
blogger.run
#blogger.tweet("".ljust(141, "abcd"))
