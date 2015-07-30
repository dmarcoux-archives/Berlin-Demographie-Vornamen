ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.require :default, :test

require "rack/test"
require "minitest/autorun"
# Load the Sinatra application
require_relative "../app.rb"

include Rack::Test::Methods

def app
    BDV_App
end
