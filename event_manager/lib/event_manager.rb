require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
	# http://congress.api/sunlightfoundation.com/legislators/locate?zip=90210&apikey=e179a6973728c4dd3fb1204283aaccb5
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
	legislator_names = legislators.collect do |legislator|
		"#{legislator.first_name} #{legislator.last_name}"
	end
	legislators_string = legislator_names.join(", ")
end

def legislators_by_zipcode_for_letter(zipcode)
	# http://congress.api/sunlightfoundation.com/legislators/locate?zip=90210&apikey=e179a6973728c4dd3fb1204283aaccb5
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists?("output")

	filename = "output/thanks_#{id}.html"

	File.open(filename, "w") do |file|
		file.puts form_letter
	end

end

def clean_phone(phone)
	# remove unwanted characters
	phone.gsub!(/\.|-|\s|\(|\)/, '')

	length = phone.length

	phone = "NA" if length < 10 or length > 11
	phone = "NA" if length == 11 && phone[0] != "1"
	phone = phone[1..10] if phone != "NA" && length == 11
	phone[0..9] if phone != "NA"
end

puts "EventManager Initialized!"

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

contents.each do |row|
	id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	phone = clean_phone(row[:homephone])

#	legislators = legislators_by_zipcode(zipcode)
#	puts "#{name} #{zipcode} #{phone} #{legislators}"

	legislators = legislators_by_zipcode_for_letter(zipcode)
	form_letter = erb_template.result(binding)
	save_thank_you_letters(id, form_letter)
end



