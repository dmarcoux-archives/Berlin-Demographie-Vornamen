class Name < Sequel::Model
    self.raise_on_save_failure = false
    self.set_allowed_columns(:name, :count, :gender, :neighborhood)

    @@valid_neighborhoods = %w{friedrichshain-kreuzberg
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

    # Used when sanitizing user input
    @@columns_sanitization = {
                                name: :to_s,
                                count: :to_i,
                                gender: :to_s,
                                neighborhood: :to_s
                             }
    def self.columns_sanitization
        @@columns_sanitization
    end

    # Used to have aliases linked to certain columns' common values for this model. It can be used to have more verbose REST routes for example
    @@common_filters = {
                        male: { gender: 'm' },
                        female: { gender: 'w' }
                       }
    @@valid_neighborhoods.each { |n| @@common_filters[n.to_sym] = { neighborhood: n } }

    def self.common_filters
        @@common_filters
    end

    def validates_neighborhood
        unless (neighborhood || '').empty?
            unless @@valid_neighborhoods.include?(neighborhood)
                errors.add(:neighborhood, "must be a valid neighborhood in the following list: #{@@valid_neighborhoods.join(', ')}")
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
