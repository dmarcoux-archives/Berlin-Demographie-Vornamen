# TODO SSL, pretty print
require "sinatra"

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDV_App < Sinatra::Application
    # Basic authentication for all routes
    use Rack::Auth::Basic, "Restricted Area" do |username, password|
        [username, password] == ["bdv", "admin"]
    end

    use Rack::Deflater
end

require_relative "models/init"
# Load all files under lib, helpers and routes
Dir["#{__dir__}/lib/*.rb", "#{__dir__}/helpers/*.rb","#{__dir__}/routes/*.rb"].each { |file| require file }
