# require "pry"
require "thor"
require 'awesome_print'
require 'userinput'
class EventsCLI < Thor

	option :Manhattan, :aliases => "-m", :desc => "filters for Manhattan"  
	option :Brooklyn, :aliases => "-b", :desc => "filters for brooklyn"
	option :Queens, :aliases => "-q", :desc => "filters for Queens"
	option :StatenIsland, :aliases => "-s", :desc => "filters for StatenIsland"
	option :Bronx,:aliases => "-x", :desc => "filters for Bronx"
	
	
	desc "search [KEYWORD][Borough]", "Search for an event using a keyword"
	def search(keyword)
			flag = get_borough(options)
			# puts "Search events by keyword: "
        # search(keyword)
        print "searching"
        loading
        puts "-SHOW EVENTS FOR #{keyword.upcase} HERE-"
	 						events = Events.new
				events.search_borough(keyword,flag)
			#	ap events.get_event_db.all
				ds =	events.get_event_db.select(:EventName,:VenueName,:EventDetailURL,:StreetAddress,:City,:State,:PostalCode,:Date)
					extract_data(ds) 
					user_open_url(events)
	end

	desc "Help method", "information on how to use cli"
option :info,:aliases => "-t", :desc =>"flag for borough help"
    def help
			if options[:info]
				puts "Borough Flags"
				puts "--Manhattan -m, --Brooklyn -b, --Queens -q, --Bronx -x, --StatenIsland -s"
			end
			 	puts "Welcome! Search for events in New York."
        puts "Available commands: "
        puts "-search <KEYWORD>"
        puts "-search_filter <CATEGORY><BOROUGH>"
        puts "-help"
    end

    no_commands{

        def loading
            i = 0
            while i <= 4
                print "."
                sleep 0.5
                i += 1
            end
				end

			def extract_data(hash)
			hash.each do |array|
						  array.each do |key,values|
							 puts "#{key}: #{values}\n"
							end
							puts "-----------------------------------------------------------"
					 end		
			end
				def get_borough(options)
		if options[:Manhattan]
					flag = "Manhattan"
				elsif options[:Brooklyn]
					flag = "Brooklyn"
				elsif options[:Queens]
					flag = "Queens"
				elsif options[:Bronx]
					flag = "Bronx"
				elsif options[:StatenIsland]
					flag = "StatenIsland"
				else
					flag = "Manhattan+Bronx+Brooklyn+Queens+StatenIsland" 
				end	
				end
				
			 def open_url(url)
				system("open", url)
			 end	 
			 
			 def user_open_url(events)
			prompt = UserInput.new(message: 'Do you want to open Event URL')
					if prompt.ask.match(/[yY]/)
							prompt = UserInput.new(message: 'Enter EventName')
							event_name = prompt.ask
							ds = events.get_event_db.select(:EventDetailURL).where(:EventName => event_name)
							ds.each do |k|
							open_url(k[:EventDetailURL])
							end
					end
			 end
   }
end
