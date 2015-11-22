class BDVApp < Sinatra::Application
  helpers Sinatra::Param, RoutesUtils

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
    # TODO: See if it is possible to extract these 'param ...' lines to make this method shorter
    # Filters
    param :name, String, default: ''
    param :count, Integer, default: 0
    param :gender, String, default: ''
    param :neighborhood, String, default: ''

    # Pagination
    param :offset, Integer, default: 0, min: 0
    param :limit, Integer, default: 100, min: 0, max: 100

    names = DB[:names]
    names = names.filter(name: params[:name]) unless params[:name].empty?
    names = names.filter(count: params[:count]) unless params[:count] <= 0
    names = names.filter(gender: params[:gender]) unless params[:gender].empty?
    names = names.filter(neighborhood: params[:neighborhood]) unless params[:neighborhood].empty?

    # In addition to query string parameters, path parameters can also be used to filter records; e.g. /names/male/mitte instead of /names?gender=m&neighborhood=mitte
    p_params = path_params(Name, request.path_info)
    names = names.filter(p_params) unless p_params.empty?

    # Sort parameters must be processed one at a time since Sequel + PostgreSQL cannot resolve properly the ORDER clause with an array
    s_params = sort_params(Name, params[:sort])
    s_params.each { |s_param| names = names.order_more(s_param) }

    # Metadata
    names_count = names.count

    status 200
    @body = {
      items: names.limit(params[:limit]).offset(params[:offset]).all,
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
    # TODO Use Sinatra-Param
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
    # TODO Use Sinatra-Param
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
