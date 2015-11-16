require 'rubygems'

require 'bundler'
Bundler.require(:default)

unless ENV['RACK_ENV'] == 'production'
  require 'dotenv'
  # Loading .env and if possible, .env.<environment> files
  Dotenv.load(Dir.pwd << '/.env', Dir.pwd << "/.env.#{ENV['RACK_ENV']}")
end

# Bundler.require calls must be separate
# as the environment variable RACK_ENV might have been set with dotenv
Bundler.require(ENV['RACK_ENV'].to_sym)

require './app.rb'
run BDVApp
