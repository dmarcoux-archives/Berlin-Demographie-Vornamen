# encoding: utf-8
require "sequel"

DB = Sequel.connect(ENV["DATABASE_URL"])

# Load the JSON Serializer plugin for all models
Sequel::Model.plugin :json_serializer

# Load all models
require_relative "name"
