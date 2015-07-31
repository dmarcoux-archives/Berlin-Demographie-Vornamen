class Sequel::Model
    # PARAMS (Integer, Symbol)
    def validates_greater_than(value, column)
        column = send(column)

        if column.is_a? Integer
            if column <= value
                errors.add(column, "must be greater than #{value}")
            end
        else
            errors.add(column, "must be of type Integer to be validated")
        end
    end
end

