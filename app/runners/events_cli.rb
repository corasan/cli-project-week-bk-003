class EventsCLI < Thor
    option :Manhattan, :aliases => "-m", :desc => "filters for Manhattan"
    option :Brooklyn, :aliases => "-b", :desc => "filters for brooklyn"
    option :Queens, :aliases => "-q", :desc => "filters for Queens"
    option :StatenIsland, :aliases => "-s", :desc => "filters for StatenIsland"
    option :Bronx,:aliases => "-x", :desc => "filters for Bronx"
    option :Full, :aliases => "-f", :desc => "Shows all information on event"

    @@events = Events.new
    desc "search [KEYWORD][Borough]", "Search for an event using a keyword"
    def search(keyword)
        flag = get_borough(options)
        print "searching"
        puts loading
        puts "*SHOW EVENTS FOR #{keyword.upcase} HERE*"
        @@events.search_borough(keyword,flag)
        extract_data(show_info(options,@@events.get_event_db.event))
        favorite(@@events)
        user_open_url(@@events)
        puts "Sisplay favorite"
        favorites
    end

    desc "Help method", "information on how to use cli"
    option :info,:aliases => "-t", :desc =>"flag for borough help"
    def help
        if options[:info]
            puts "Borough Flags:"
            puts "--Manhattan or -m, --Brooklyn or -b, --Queens or -q, --Bronx or -x, --StatenIsland or -s"
        end
        puts "Search for events in New York."
        puts "Available commands: "
        puts "* search <KEYWORD>\t Search events"
        puts "* help\t\t\t Show the available commands"
        puts "* help -t\t\t Show the borough flags"
        puts "* favorites\t\t Show  your favorite events"
    end

    desc "Diplays your saved events", "Retrieves saved events from"
    def favorites
        join_table =	@@events.get_event_db.event.join(@@events.get_event_db.favorite, :EventID_fk =>:EventID).select(:EventID,:EventName)
        extract_data(join_table)
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
                array.each {|key,values| puts "#{key}: #{values}\n"}
                puts "-----------------------------------------------------------"
            end
        end
        def get_borough(options)
            if options[:Manhattan] then flag = "Manhattan"
            elsif options[:Brooklyn] then flag = "Brooklyn"
            elsif options[:Queens] then flag = "Queens"
            elsif options[:Bronx] then flag = "Bronx"
            elsif options[:StatenIsland] then flag = "StatenIsland"
            else flag = "Manhattan+Bronx+Brooklyn+Queens+StatenIsland"
            end
        end

        def open_url(url)
            system("open", url)
        end

        def user_open_url(events)
            prompt = UserInput.new(message: 'Do you want to open Event URL')
            if prompt.ask.match(/[yY]/)
                prompt = UserInput.new(message: 'Enter EventID')
                event_id = prompt.ask
                ds = events.get_event_db.event.select(:EventDetailURL).where(:EventID => event_id)
                ds.each {|k| open_url(k[:EventDetailURL])}
            end
        end

        def show_info(options = :Full,events)
            if options[:Full]
                return ds = events.all
            else
                return	ds =	events.select(:EventID,:VenueName,:Description,:EventDetailURL,:StreetAddress,:City,:State,:PostalCode,:Date)
            end
        end

        def favorite(events)
            while true
                prompt = UserInput.new(message: 'Do you want to add an event to favorites')
                if prompt.ask.match(/[yY]/)
                    prompt =	UserInput.new(message: 'Enter EventID, -Digits[0-9] only!',validation: /[0-9]/)
                    event_id = prompt.ask
                    events.get_event_db.favorite.insert(:EventID_fk => event_id)
                else
                    break
                end
            end
        end

        def create_db
            @events = Events.new
        end
    }
end
