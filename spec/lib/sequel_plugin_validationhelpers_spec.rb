require_relative "../spec_helper"

describe "Sequel::Plugin::ValidationHelpers" do
    before do
        @c = Class.new(Sequel::Model) do

             end
    end

    describe "#validates_greater_than" do
        describe "a column which is of type Integer" do
            describe "having a value smaller than the value received" do

            end

            describe "having a value equal to the value received" do

            end

            describe "having a value greater than the value received" do

            end
        end

        describe "a column which isn't of type Integer" do
            it "must not be valid" do

            end
        end
    end
end
