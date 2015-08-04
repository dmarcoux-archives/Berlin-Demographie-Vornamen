# TODO specs
module RoutesUtils
    # Sanitize all params or only present ones for the model, depending on the default argument
    # With default == true -> All params
    # With default == false -> Only present params
    def sanitize_params(model, params, default = false)
        columns = model.columns_sanitization

        h = {}
        columns.each do |column, sanitize_method|
            if (p = params[column]) || default
                # Using string keys to use the same key type as in the hash params
                h[column.to_s] = p.send(sanitize_method)
            end
        end

        params.merge!(h).select! { |k, v| model.allowed_columns.include?(k.to_sym) }
    end

    def sanitize_default_params(model, params)
        sanitize_params(model, params, true)
    end
end
