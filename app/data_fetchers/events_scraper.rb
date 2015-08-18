# require "nokogiri"
# require "open-uri"
# require "pry"
# require "awesome_print"
# require_relative "events_listings.rb"
# class EventsScraper
#     keyword_doc = open("#{EventsListings::BASE_SEARCH}#{@keyword}&api_key=#{EventsListings::API_KEY}").read
#     json = JSON.parse(keyword_doc)
#     ap json
# end
