# encoding: utf-8
class BDV_App < Sinatra::Application
    before do
        content_type :json
    end

    get "/names" do
        #TODO params
        count = params[:count].to_i
        gender = params[:gender]
        neighborhood = params[:neighborhood]

        status 200
    end

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
end
