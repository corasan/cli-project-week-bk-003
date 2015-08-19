require 'rubygems'
require 'sequel'
require 'sqlite3'
require 'awesome_print'

class EventDatabase
	attr_accessor:event

	def initialize
  @@DB = Sequel.sqlite
		@@DB.create_table :EventTable do
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
			String :RecurringStartDate 
      String :RecurringEndDate 
      String :RecurringDays
		end
  end
  
def populate_table(event_array)
  @event = @@DB[:EventTable]
	event_array.each do |value|
    unless value["recur_days"].nil?
      days = value["recur_days"].join(",")
    end
		@event.insert(:EventName => value["venue_name"],:EventDetailURL => value["event_detail_url"],
    :Description => value["web_description"],:VenueName => value["venue_name"],:VenueDetailURL => value["venue_detail_url"],
    :Borough => value["borough"],:Neighborhood => value["neighborhood"],:StreetAddress => value["street_address"],
    :CrossStreet => value["cross_street"],:City => value["city"],:State => value["state"],
    :PostalCode => value["postal_code"],:Telephone => value["telephone"],:VenueWebsite => value["venue_website"],
    :CriticName => value["critic_name"],:Category => value["category"],
    :Admission => value["free"],:KidFriendly => value["kid_friendly"],:Festival => value["festival"],
    :Date => value["date_time_description"],:RecurringStartDate => value["recurring_start_date"],
    :RecurringEndDate => value["recurring_end_date"],:RecurringDays => days)
		end
  end
end


