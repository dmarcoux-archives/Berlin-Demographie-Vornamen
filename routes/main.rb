# encoding: utf-8
class BDV_App < Sinatra::Application
    before do
        content_type :json
    end

    # Retrieve a list of names
    get "/names" do
        # Retrieve parameters and convert them to the good type, but also get rid of nil
        name = params[:name].to_s
        count = params[:count].to_i
        gender = params[:gender].to_s
        neighborhood = params[:neighborhood].to_s

        names = DB[:names]
        names = names.filter(name: name) unless name.empty?
        names = names.filter(count: count) unless count <= 0
        names = names.filter(gender: gender) unless gender.empty?
        names = names.filter(neighborhood: neighborhood) unless neighborhood.empty?

        status 200
        # TODO implement pagination
        names.limit(100).all.to_json
    end

    # Retrieve a specific name
    get "/names/:id" do |id|
        id = id.to_i
        if id > 0
            name = Name.find(id: id)
            status 200
            name.to_json
        else
            status 400
            {
                message: "Invalid id parameter.",
                description: "A valid Integer must be provided"
            }.to_json
        end
    end

    # Create a new name
    post "/names" do

    end

    # Update a specific name
    put "/names/:id" do |id|

    end

    # Delete a specific name
    delete "/names/:id" do |id|

    end
end
