ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require :default, :test

require 'rack/test'
require 'minitest/autorun'

include Rack::Test::Methods

# Load the Sinatra application
require_relative '../app.rb'
