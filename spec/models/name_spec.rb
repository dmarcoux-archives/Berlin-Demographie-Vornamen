require_relative '../spec_helper'

describe Name do
    before do
        @c = Class.new(Name) do
                # Override validate method to only test Name.validates_neighborhood
                def validate
                    validates_neighborhood
                end
             end
        @m = @c.new(name: 'Name', gender: 'm', count: 1)
    end

    describe '#validates_neighborhood' do
        let(:valid_neighborhoods) { %w{friedrichshain-kreuzberg
                                       standesamt_i
                                       lichtenberg
                                       mitte
                                       reinickendorf
                                       tempelhof-schoeneberg
                                       marzahn-hellersdorf
                                       pankow
                                       spandau
                                       charlottenburg-wilmersdorf
                                       treptow-koepenick
                                       neukoelln
                                       steglitz-zehlendorf} }

        describe 'when neighborhood is nil or an empty string' do
            it do
                @m.must_be :valid?

                @m.neighborhood = ''
                @m.must_be :valid?
            end
        end

        describe 'when neighborhood contains a non-empty string' do
            describe 'which is a valid neighborhood' do
                it do
                    valid_neighborhoods.each do |valid_neighborhood|
                        @m.neighborhood = valid_neighborhood
                        @m.must_be :valid?
                    end
                end
            end

            describe "which isn't a valid neighborhood" do
                it do
                    @m.neighborhood = 'lala'
                    @m.wont_be :valid?

                    @m.neighborhood = 'no'
                    @m.wont_be :valid?
                end
            end
        end
    end
end
