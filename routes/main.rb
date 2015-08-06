class BDV_App < Sinatra::Application
    helpers RoutesUtils

    before do
        content_type :json
    end

    before "/names/:id" do |id|
        id = id.to_i

        if id <= 0
            halt [400, { message: "Invalid id parameter", description: "A valid Integer greater than 0 must be provided" }.to_json]
        end

        unless @name = Name.find(id: id)
            halt [404, { message: "Not found", description: "Name ##{id} doesn't exist" }.to_json]
        end
    end

    # Retrieve a list of names
    get "/names" do
        s_params = sanitize_default_params(Name, params)

        name = s_params[:name]
        count = s_params[:count]
        gender = s_params[:gender]
        neighborhood = s_params[:neighborhood]

        limit = sanitize_limit_param(params[:limit])
        offset = sanitize_offset_param(params[:offset])

        names = DB[:names]
        names = names.filter(name: name) unless name.empty?
        names = names.filter(count: count) unless count <= 0
        names = names.filter(gender: gender) unless gender.empty?
        names = names.filter(neighborhood: neighborhood) unless neighborhood.empty?

        # TODO sorting, aliases for common queries (neighborhood, male/female, etc...)
        [200, names.limit(limit).offset(offset).all.to_json]
    end

    # Retrieve a specific name
    get "/names/:id" do
        [200, @name.to_json]
    end

    # Create a new name
    post "/names" do
        s_params = sanitize_default_params(Name, params)

        name = Name.new(s_params)
        if name.save
            [200,{ "location" => "#{request.base_url}#{request.path_info}/#{name.id}" }, name.to_json]
        else
            [422, name.errors.to_json]
        end
    end

    # Update a specific name
    put "/names/:id" do |id|
        s_params = sanitize_params(Name, params)

        if s_params.empty?
            return [400, { message: "Parameters needed", description: "Provide valid parameters to update Name ##{id}" }.to_json]
        end

        unless @name.update(s_params)
            return [422, @name.errors.to_json]
        end

        [200, @name.to_json]
    end

    # Delete a specific name
    delete "/names/:id" do |id|
        unless @name.destroy
            return [500, { message: "Name deletion error", description: "Name ##{id} couldn't be deleted" }.to_json]
        end

        [200, { message: "Name deleted", description: "Name ##{id} deleted successfully" }.to_json]
    end
end
