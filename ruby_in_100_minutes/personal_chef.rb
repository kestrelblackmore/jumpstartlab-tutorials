class PersonalChef
	def make_toast(color)
		if color.nil?
			puts "How am I supposed to make nothingness toast?"
		else
			puts "Making your toast #{color}."
		end

		return self
	end

	def make_milkshake(flavor)
		puts "Making you a #{flavor} milkshake."
		return self
	end

	def make_eggs(quantity)
		quantity.times do
			puts "Making an egg."
		end
		puts "I'm done!"
		return self
	end

	def game_plan(meals)
		meals.each do |meal|
			puts "We'll have #{meal}..."
		end

		all_meals = meals.join(", ")
		puts "In summary: #{all_meals}"
	end

	def inventory
		# below is a hash
		produce = {apples: 3, oranges: 1, carrots: 12}

		produce.each do |item, quantity|
			puts "There are #{quantity} #{item} in the fridge."
		end
	end

	def water_status(minutes)
	  if minutes < 7
	    puts "The water is not boiling yet."
	  elsif minutes == 7
	    puts "It's just barely boiling"
	  elsif minutes == 8
	    puts "It's boiling!"
	  else
	    puts "Hot! Hot! Hot!"
	  end

	  return self
	end

	def countdown(counter)
	  while counter > 0
	    puts "The counter is #{counter}"
	    counter = counter - 1
	  end

	  return self
	end


end

class Butler
	def open_front_door
		puts "Opening the front door Sir."
	end

	def open_door(door)
		puts "Opening the #{door} door Sir."
	end
end

class StringStuff
	# get length
	# "kestrel".length

	# replace text
	# "Kestrel".gsub("Kes", "Pet")

	# split a string
	# "this,is,some,text".split(",")

	# get substring
	# "Kestrel"[0..2] = "Kes"
	# "Kestrel"[0..-1] = "Kestrel"
	# "Kestrel"[0..-2] = "Kestre"

	# arrays
	# meals = ["breakfast","lunch","dinner"]
	# puts meals[2]
	# puts meals.first
	# puts meals.last
	# meals << "dessert"
end

