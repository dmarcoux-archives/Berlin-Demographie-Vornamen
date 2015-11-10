class Sequel::Model
  # PARAMS (Integer, Symbol)
  def validates_greater_than(value, column_name)
    column_value = send(column_name)

    if column_value.is_a? Integer
      if column_value <= value
        errors.add(column_name, "must be greater than #{value}")
      end
    else
      # column_name should refer to a column of type Integer
      raise Sequel::Error::InvalidOperation
    end
  end
end

