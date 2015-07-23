# encoding: utf-8
require "sinatra"

class BDV_App < Sinatra::Application

end

require_relative "models/init"
require_relative "routes/init"
