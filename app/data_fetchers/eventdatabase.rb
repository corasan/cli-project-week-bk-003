class EventDatabase
    attr_accessor:event
    attr_accessor:favorite
    def initialize
        @db = Sequel.connect('sqlite://events_database.db')
        createTables if !@db.table_exists?(:EventTable)
        @favorite =	@db[:FavoriteTable]
        @event = @db[:EventTable]
    end
    def createTables
        @db.create_table :EventTable do
            primary_key :EventID
            String :EventName
            String :EventDetailURL
            String :Description
            String :VenueName
            String :VenueDetailURL
            String :Borough
            String :Neighborhood
            String :StreetAddress
            String :CrossStreet
            String :City
            String :State
            String :PostalCode
            String :Telephone
            String :VenueWebsite
            String :CriticName
            String :Category
            String :Admission
            String :KidFriendly
            String :Festival
            String :Date
            Date :RecurringStartDate
            Date :RecurringEndDate
            String :RecurringDays
        end

        @db.create_table :FavoriteTable do
            primary_key :FavoriteID
            foreign_key :EventID_fk
        end
    end
    def populate_table(event_array)
        event_array.each do |value|
            unless value["recur_days"].nil?
                days = value["recur_days"].join(",")
            end
            unless value["RecurringStartDate"].nil? || value["RecurringEndDate"].nil?
                recurring_start_date =	Date.parse(value["RecurringStartDate"])
                recurring_end_date = Date.parse(value["RecurringEndDate"])
            end
            @event.insert(:EventName => value["venue_name"],:EventDetailURL => value["event_detail_url"],
                :Description => Sanitize.clean(value["web_description"]),:VenueName => value["venue_name"],:VenueDetailURL => value["venue_detail_url"],
                :Borough => value["borough"],:Neighborhood => value["neighborhood"],:StreetAddress => value["street_address"],
                :CrossStreet => value["cross_street"],:City => value["city"],:State => value["state"],
                :PostalCode => value["postal_code"],:Telephone => value["telephone"],:VenueWebsite => value["venue_website"],
                :CriticName => value["critic_name"],:Category => value["category"],
                :Admission => value["free"],:KidFriendly => value["kid_friendly"],:Festival => value["festival"],
                :Date => value["date_time_description"],:RecurringStartDate => recurring_start_date,
                :RecurringEndDate => recurring_end_date,:RecurringDays => days)
        end
    end
end
