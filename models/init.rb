require 'sequel'

DB = Sequel.postgres({
                       database: "#{ENV['POSTGRES_DB']}",
                       host: "#{ENV['POSTGRES_HOST']}",
                       user: "#{ENV['POSTGRES_USER']}",
                       pool_sleep_time: 0.5, # in seconds
                       pool_timeout: 10 # in seconds
                     })

# Load plugins for all models
Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :validation_helpers

# Load Sequel::Model extensions and all models
require_relative 'sequel_model'
require_relative 'name'
