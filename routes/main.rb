class BDV_App < Sinatra::Application
    helpers RoutesUtils

    before do
        content_type :json
    end

    before "/names/:id" do |id|
        id = id.to_i

        if id <= 0
            status 400
            @body = { message: "Invalid id parameter", description: "A valid Integer greater than 0 must be provided" }
            halt
        end

        unless @name = Name.find(id: id)
            status 404
            @body = { message: "Not found", description: "Name ##{id} doesn't exist" }
            halt
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
        status 200
        @body = names.limit(limit).offset(offset).all
    end

    # Retrieve a specific name
    get "/names/:id" do
        status 200
        @body = @name
    end

    # Create a new name
    post "/names" do
        s_params = sanitize_default_params(Name, params)

        name = Name.new(s_params)
        if name.save
            status 200
            headers ({ "location" => "#{request.base_url}#{request.path_info}/#{name.id}" })
            @body = name
        else
            status 422
            @body = name.errors
        end
    end

    # Update a specific name
    put "/names/:id" do |id|
        s_params = sanitize_params(Name, params)

        if s_params.empty?
            status 400
            @body = { message: "Parameters needed", description: "Provide valid parameters to update Name ##{id}" }
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
    delete "/names/:id" do |id|
        unless @name.destroy
            status 500
            @body = { message: "Name deletion error", description: "Name ##{id} couldn't be deleted" }
            return
        end

        status 200
        @body = { message: "Name deleted", description: "Name ##{id} deleted successfully" }
    end

    # Formatting the response JSON body
    after do
        pretty_print = !!params[:pretty]

        response.body = if pretty_print
                            JSON.pretty_generate(@body)
                        else
                            @body.to_json
                        end
    end
end
