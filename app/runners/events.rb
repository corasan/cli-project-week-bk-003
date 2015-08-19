require 'nokogiri'
require 'open-uri'
require 'json'
require 'awesome_print'
require "pry"
require_relative 'eventdatabase'


#key 0b7c8b92227545449aa4998f9fce1601:9:72708466
# url = "http://api.nytimes.com/svc/events/{version}/listings[.response-format]?[optional-param1=value1]&[...]&api-key={your-API-key}"
class Events

@@EVENT_KEY = '0b7c8b92227545449aa4998f9fce1601:9:72708466'
@@URL = 'http://api.nytimes.com/svc/events/v2/listings.json?'

def search(keyword)
		url =	"#{@@URL}&query=#{keyword}&api-key=#{@@EVENT_KEY}"
		js =  open(url).read
		event_hash = JSON.parse(js)
		@event = event_hash["results"]
		@event_db = EventDatabase.new 
		@event_db.populate_table(@event)
	end

def search_borough(keyword,burough)
url =	"#{@@URL}&filters=borough:#{burough}&query=#{keyword}&api-key=#{@@EVENT_KEY}"
		js =  open(url).read
		event_hash = JSON.parse(js)
		@event = event_hash["results"]
		@event_db = EventDatabase.new 
		@event_db.populate_table(@event)
end


	def get_event_hash
		@event
	end

	def get_hash_value(keyword)
		get_event_hash.each do |ele|
		puts ele[keyword]
		end
	end
	
	def get_event_db
		@event_db.event
	end

end

