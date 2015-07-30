# encoding: utf-8
require "sinatra"

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDV_App < Sinatra::Application
end

require_relative "models/init"
# Load all files under lib and routes
Dir["#{__dir__}/lib/*.rb", "#{__dir__}/routes/*.rb"].each { |file| require file }
