# encoding: utf-8
require "sequel"

DB = Sequel.connect("postgres://dany/berlin-demographie-vornamen")

require_relative "name"
