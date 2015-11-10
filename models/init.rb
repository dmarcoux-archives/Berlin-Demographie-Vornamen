require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'])

# Load plugins for all models
Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :validation_helpers

# Load Sequel::Model extensions and all models
require_relative 'sequel_model'
require_relative 'name'
