# TODO Improve this file... ugly hardcoded stuff...
module RoutesUtils
    # Prepare all parameters by getting rid of nil and converting non-String columns to their proper type
    def sanitize_default_params(params)
        # Cannot use symbols here because the hash params has string keys
        params.merge!({
                        "name" => params[:name].to_s,
                        "count" => params[:count].to_i,
                        "gender" => params[:gender].to_s,
                        "neighborhood" => params[:neighborhood].to_s
                      })
    end

    # Convert non-String columns to their proper type, but only if they are present in params
    def sanitize_params(params)
        if params[:count]
            # Cannot use symbols here because the hash params has string keys
            params.merge!({ "count" => params[:count].to_i })
        end

        params.select! { |k, v| ["name", "count", "gender", "neighborhood"].include?(k) }
    end
end
