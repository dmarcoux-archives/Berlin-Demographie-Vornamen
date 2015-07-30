describe Name do
    before do
        subject(:name) { Name.new }
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

        context "when neighborhood is nil or an empty string" do
            it "" do

            end
        end

        context "when neighborhood contains a string" do
            context "which is a valid neighborhood" do

            end

            context "which isn't a valid neighborhood" do

            end
        end
    end

    describe "#validates_greater_than" do
        context "a column which is of type Integer" do
            context "having a value smaller than the value received" do

            end

            context "having a value equal to the value received" do

            end

            context "having a value greater than the value received" do

            end
        end

        context "a column which isn't of type Integer" do
            it "raises an error" do

            end
        end
    end
end
