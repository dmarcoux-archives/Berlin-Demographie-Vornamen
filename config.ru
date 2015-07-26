require "rubygems"

require "bundler"
Bundler.require(:default)

require "dotenv"
Dotenv.load

# Bundler.require calls must be separate as the environment variable RACK_ENV might have been set with dotenv
Bundler.require(ENV["RACK_ENV"].to_sym)

require './app.rb'
run BDV_App
