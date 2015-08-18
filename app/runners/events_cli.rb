# require "pry"
require "thor"
class EventsCLI < Thor

    desc "search KEYWORD", "Search for an even using a keyword"
    def search(keyword)
        # puts "Search events by keyword: "
        # search(keyword)
        print "searching"
        puts loading
        puts "-SHOW EVENTS FOR #{keyword.upcase} HERE-"
    end

    def help
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
    }
    # def search(keyword, category="Music", borough="Manhattan")
    #     @search_by_keyword = "#{EventsListings::BASE_SEARCH}&#{word}&#{category}&#{borough}&api-key=#{EventsListings::API_KEY}"
    # end
end
