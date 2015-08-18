require "pry"
class EventsCLI
    def keyword_search
        print "Search events by keyword: "
        input = gets.chomp
        # search(keyword)
        puts "searching #{loading}"
        puts "this are the events"
    end

    def loading
        i = 0
        while i <= 4
            print "."
            sleep 0.5
            i += 1
        end
    end

    # def search(keyword, category="Music", borough="Manhattan")
    #     @search_by_keyword = "#{EventsListings::BASE_SEARCH}&#{word}&#{category}&#{borough}&api-key=#{EventsListings::API_KEY}"
    # end
end
