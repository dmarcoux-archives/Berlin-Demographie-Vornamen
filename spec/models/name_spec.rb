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
end
