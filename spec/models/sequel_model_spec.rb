require_relative "../spec_helper"

describe Sequel::Model do
    before do
        @c = Class.new(Sequel::Model) do
                def self.set_validations(&block)
                    define_method(:validate, &block)
                end

                attr_accessor :value
             end
        @c.plugin :validation_helpers

        @m = @c.new
    end

    describe "#validates_greater_than" do
        describe "a column which is of type Integer" do
            before do
                @c.set_validations { validates_greater_than(5, :value) }
            end

            describe "having a value smaller than the value received" do
                it "must not be valid" do
                    @m.value = 0
                    @m.wont_be :valid?
                end
            end

            describe "having a value equal to the value received" do
                it "must not be valid" do
                    @m.value = 5
                    @m.wont_be :valid?
                end
            end

            describe "having a value greater than the value received" do
                it "must be valid" do
                    @m.value = 10
                    @m.must_be :valid?
                end
            end
        end

        describe "a column which isn't of type Integer" do
            it "must not be valid" do
                @c.set_validations { validates_greater_than(5, :value) }
                @m.wont_be :valid?

                @m.value = "123"
                @m.wont_be :valid?

                @m.value = true
                @m.wont_be :valid?
            end
        end
    end
end
