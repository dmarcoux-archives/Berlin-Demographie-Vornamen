class Name < Sequel::Model
    self.raise_on_save_failure = false

    def validates_neighborhood
        unless (neighborhood || "").empty?
            valid_neighborhoods = %w{friedrichshain-kreuzberg
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
                                     steglitz-zehlendorf}

            unless valid_neighborhoods.include?(neighborhood)
                errors.add(:neighborhood, "must be a valid neighborhood in the following list: #{valid_neighborhoods.join(", ")}")
            end
        end
    end

    def validate
        super
        validates_presence [:name, :count, :gender, :neighborhood]
        validates_type Integer, :count, allow_nil: true
        validates_type String, [:name, :gender, :neighborhood], allow_nil: true
        validates_exact_length 1, :gender, allow_nil: true
        validates_max_length 40, :name, allow_nil: true
        validates_unique [:name, :gender, :neighborhood], allow_nil: true
        validates_neighborhood
        validates_greater_than 0, :count
    end
end
