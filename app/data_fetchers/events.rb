require_relative 'eventdatabase'
class Events
	def initialize
	@API_KEY = '0b7c8b92227545449aa4998f9fce1601:9:72708466'
	@URL = 'http://api.nytimes.com/svc/events/v2/listings.json?'
	@event_db = EventDatabase.new

	end

	def search(keyword)
		url =	"#{@@URL}&query=#{keyword}&api-key=#{@@API_KEY}"
		js =  open(url).read
		event_hash = JSON.parse(js)
		@event = event_hash["results"]
		@event_db.populate_table(@event)
	end

	def search_borough(keyword,burough)
		url =	"#{@URL}&filters=borough:#{burough}&query=#{keyword}&api-key=#{@API_KEY}"
		js =  open(url).read
		event_hash = JSON.parse(js)
		@event = event_hash["results"]
		@event_db.populate_table(@event)
	end


	def get_event_hash
		@event
	end

	def get_hash_value(keyword)
		get_event_hash.each {|ele| puts ele[keyword]}
	end

	def get_event_db
		@event_db
	end

end
