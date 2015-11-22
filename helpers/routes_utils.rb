# TODO: Create an error class which inherits from NoMethodError
#       and use it to avoid writing the same text in fail
module RoutesUtils
  # Link path parameters to a model's common filters
  def path_params(model, path_info)
    unless model.respond_to?(:common_filters)
      fail NoMethodError.new(
        "undefined method or class variable 'common_filters' for model '#{model.name}'",
        'RoutesUtils.path_params'
      )
    end

    return [] if path_info.empty?

    # Keeping only the path parameters from request's path info
    params = path_info[1..-1].split('/')[1..-1].map(&:to_sym)
    return [] if params.empty?

    model.common_filters.select { |k, _v| params.include?(k) }.values
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
