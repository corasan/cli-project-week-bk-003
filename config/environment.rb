require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

Dir['app/concerns/*.rb'].each {|f| require f}
Dir['app/models/*.rb'].each {|f| require f}
Dir['app/data_fetchers/*.rb'].each {|f| require f}
Dir['app/runners/*.rb'].each {|f| require f}

require 'open-uri'
require 'json'
require 'nokogiri'
require 'pry'
require "awesome_print"
require 'rubygems'
require 'sequel'
require 'sqlite3'
require 'sanitize'
require "thor"
require 'userinput'
