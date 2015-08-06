module RoutesUtils
    # Sanitize all params or only present ones for the model, depending on the argument "all"
    def sanitize_params(model, params, all = false)
        unless model.respond_to?(:columns_sanitization)
            raise NoMethodError.new("undefined method or class variable 'columns_sanitization' for model '#{model.name}'",
                                    "RoutesUtils.sanitize_params")
            # columns_sanitization example: { col1: :to_s, col2: :to_i, col3: :to_f }
        end

        columns = model.columns_sanitization

        # The params hash from Sinatra routes has String keys... so we replaced them by Symbol
        params = Hash[params.map { |k, v| [k.to_sym, v] }]

        h = {}
        columns.each do |column, sanitize_method|
            if (p = params[column]) || all
                h[column.to_sym] = p.send(sanitize_method)
            end
        end

        params.merge(h).select { |k, v| (model.allowed_columns || []).include?(k) }
    end

    def sanitize_default_params(model, params)
        sanitize_params(model, params, true)
    end

    def sanitize_limit_param(l)
        limit = l.to_i

        return limit if (limit > 0 && limit <= 100)

        100
    end

    def sanitize_offset_param(o)
        offset = o.to_i

        return offset if offset >= 0

        0
    end
end
