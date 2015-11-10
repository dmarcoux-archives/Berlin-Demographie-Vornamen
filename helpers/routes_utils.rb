module RoutesUtils
  # Sanitize all params or only present ones for the model, depending on the argument "all"
  def sanitize_params(model, params, all = false)
    unless model.respond_to?(:columns_sanitization)
      raise NoMethodError.new("undefined method or class variable 'columns_sanitization' for model '#{model.name}'",
                              'RoutesUtils.sanitize_params')
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

    return limit if limit > 0 && limit <= 100

    100
  end

  def sanitize_offset_param(o)
    offset = o.to_i

    return offset if offset >= 0

    0
  end

  # Link path parameters to a model's common filters
  def path_params(model, path_info)
    unless model.respond_to?(:common_filters)
      raise NoMethodError.new("undefined method or class variable 'common_filters' for model '#{model.name}'",
                              'RoutesUtils.path_params')
    end

    return [] if path_info.empty?

    # Keeping only the path parameters from request's path info
    params = path_info[1..-1].split('/')[1..-1].map(&:to_sym)
    return [] if params.empty?

    model.common_filters.select { |k, v| params.include?(k)}.values
  end

  # Prepare sort params so they can be used with Sequel
  def sort_params(model, params)
    # Keep only sortable columns
    p = params.to_s.split(',').select { |v| (model.allowed_columns || []).include?(v.sub(/^-/, '').to_sym) }

    p.map do |v|
      if v[0] == '-'
        # Descending sort
        Sequel.desc(v[1..-1].to_sym)
      else
        # Ascending sort
        Sequel.asc(v.to_sym)
      end
    end
  end
end
