# require "pry"
require "thor"
require 'awesome_print'
class EventsCLI < Thor

  desc "search [KEYWORD][Borough]", "Search for an event using a keyword"


  option :Manhattan, :aliases => "-m", :desc => "filters for Manhattan"  
	option :Brooklyn, :aliases => "-b", :desc => "filters for brooklyn"
	option :Queens, :aliases => "-q", :desc => "filters for Queens"
	option :StatenIsland, :aliases => "-s", :desc => "filters for StatenIsland"
	option :Bronx,:aliases => "-x", :desc => "filters for Bronx"

    def search(keyword)
			flag = get_borough(options)
			# puts "Search events by keyword: "
        # search(keyword)
        print "searching"
        # puts loading
        puts "-SHOW EVENTS FOR #{keyword.upcase} HERE-"
	 						events = Events.new
				events.search_borough(keyword,flag)
			#	ap events.get_event_db.all
					ds =	events.get_event_db.select(:EventName,:VenueName,:EventDetailURL,:StreetAddress,:City,:State,:PostalCode,:Date)
					 ds.each do |v|
						  v.each do |k,d|
							 puts "#{k}: #{d}\n"
							end
							puts "-----------------------------------------------------------"
		end	 
    end

    def help
        puts "Welcome! Search for events in New York."
        puts "Available commands: "
        puts "-search <KEYWORD>"
        puts "-search_filter <CATEGORY><BOROUGH>"
				puts "Flags -m :Manhattan"
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
 
   }
end
