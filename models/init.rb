# encoding: utf-8
require "sequel"

DB = Sequel.connect(ENV["DATABASE_URL"])

# Load plugins for all models
Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :validation_helpers

# Load all models
require_relative "name"
