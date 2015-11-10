ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require :default, :test

require 'rack/test'
require 'minitest/autorun'

# TODO: Check if the app lines are needed only for routes spec... then transfer them or not
# Load the Sinatra application
require_relative '../app.rb'

include Rack::Test::Methods

def app
    BDV_App
end
