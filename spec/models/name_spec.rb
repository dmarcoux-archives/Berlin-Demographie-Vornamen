require_relative "../spec_helper"

describe Name do
    before do
        @name = Name.new
    end

    describe "#validates_neighborhood" do
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

        describe "when neighborhood is nil or an empty string" do
            it "" do

            end
        end

        describe "when neighborhood contains a string" do
            describe "which is a valid neighborhood" do

            end

            describe "which isn't a valid neighborhood" do

            end
        end
    end
end
