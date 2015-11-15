# TODO: SSL
configure do
  # Enable Cross Origin Resource Sharing (CORS)
  enable :cross_origin
end

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDVApp < Sinatra::Application
  use Rack::Session::Pool, expire_after: 2_592_000 # 30 days in seconds
  use Rack::Deflater

  # Basic authentication
  before do
    content_type :json

    unless session[:authorized] ||= (params[:key] == 'bdv')
      status 401
      @body = { message: 'Unauthorized access',
                description: 'Please login by providing the valid key' }
      halt
    end
  end

  # Formatting the response JSON body
  after do
    @body ||= { message: 'Not found',
                descrition: 'The requested route was not found' }

    response.body = if params[:pretty].nil?
                      @body.to_json
                    else
                      JSON.pretty_generate(@body)
                    end
  end
end

require_relative 'models/init'
# Load all files under lib, helpers and routes
Dir["#{__dir__}/lib/*.rb", "#{__dir__}/helpers/*.rb", "#{__dir__}/routes/*.rb"].each do |file|
  require file
end
