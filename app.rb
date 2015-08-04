require "sinatra"

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDV_App < Sinatra::Application
end

require_relative "models/init"
# Load all files under lib, helpers and routes
Dir["#{__dir__}/lib/*.rb", "#{__dir__}/helpers/*.rb","#{__dir__}/routes/*.rb"].each { |file| require file }
