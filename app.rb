# encoding: utf-8
require "sinatra"

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDV_App < Sinatra::Application
end

require_relative "models/init"
require_relative "routes/init"
