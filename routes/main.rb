class BDVApp < Sinatra::Application
  helpers RoutesUtils

  before %r{^/names/([0-9]+)$} do |id|
    id = id.to_i

    if id == 0
      status 400
      @body = { message: 'Invalid id parameter', description: 'A valid Integer greater than 0 must be provided' }
      halt
    end

    # @name is used in actions called after this before filter
    unless (@name = Name.find(id: id))
      status 404
      @body = { message: 'Not found', description: "Name ##{id} doesn't exist" }
      halt
    end
  end

  # Retrieve a list of names
  get %r{^\/names(\/[a-z\-\_]+)*$} do
    names = DB[:names]

    # Query string parameters
    p = sanitize_default_params(Name, params)

    name = p[:name]
    count = p[:count]
    gender = p[:gender]
    neighborhood = p[:neighborhood]

    names = names.filter(name: name) unless name.empty?
    names = names.filter(count: count) unless count <= 0
    names = names.filter(gender: gender) unless gender.empty?
    names = names.filter(neighborhood: neighborhood) unless neighborhood.empty?

    # In addition to query string parameters, path parameters can also be used to filter records; e.g. /names/male/mitte instead of /names?gender=m&neighborhood=mitte
    p_params = path_params(Name, request.path_info)
    names = names.filter(p_params) unless p_params.empty?

    # Sort parameters must be processed one at a time since Sequel + PostgreSQL cannot resolve properly the ORDER clause with an array
    s_params = sort_params(Name, params[:sort])
    s_params.each { |s_param| names = names.order_more(s_param) }

    # Pagination parameters
    limit = sanitize_limit_param(params[:limit])
    offset = sanitize_offset_param(params[:offset])

    # Metadata
    names_count = names.count

    status 200
    @body = {
      items: names.limit(limit).offset(offset).all,
      count: names_count
    }
  end

  # Retrieve a specific name
  get %r{^\/names\/[0-9]+$} do
    status 200
    @body = @name
  end

  # Create a new name
  post '/names' do
    s_params = sanitize_default_params(Name, params)

    name = Name.new(s_params)
    if name.save
      status 200
      headers 'location' => "#{request.base_url}#{request.path_info}/#{name.id}"
      @body = name
    else
      status 422
      @body = name.errors
    end
  end

  # Update a specific name
  put %r{^/names/([0-9]+)$} do |id|
    s_params = sanitize_params(Name, params)

    if s_params.empty?
      status 400
      @body = { message: 'Parameters needed', description: "Provide valid parameters to update Name ##{id}" }
      return
    end

    unless @name.update(s_params)
      status 422
      @body = @name.errors
      return
    end

    status 200
    @body = @name
  end

  # Delete a specific name
  delete %r{^/names/([0-9]+)$} do |id|
    unless @name.destroy
      status 500
      @body = { message: 'Name deletion error', description: "Name ##{id} couldn't be deleted" }
      return
    end

    status 200
    @body = { message: 'Name deleted', description: "Name ##{id} deleted successfully" }
  end
end
