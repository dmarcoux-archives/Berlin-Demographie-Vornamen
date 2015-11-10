# TODO: SSL
configure do
  # Enable Cross Origin Resource Sharing (CORS)
  enable :cross_origin
end

set :root, File.dirname(__FILE__)

# Initialize the Sinatra app
class BDV_App < Sinatra::Application
  use Rack::Session::Pool, expire_after: 2_592_000 # 30 days in seconds
  use Rack::Deflater

  # Basic authentication
  before do
    content_type :json

    unless session[:authorized] ||= (params[:key] == 'bdv')
      status 401
      @body = { message: 'Unauthorized access', description: 'Please login by providing the valid key' }
      halt
    end
  end

  # Formatting the response JSON body
  after do
    @body ||= { message: 'Not found', descrition: 'The requested route was not found' }

    pretty_print = !!params[:pretty]

    response.body = if pretty_print
                      JSON.pretty_generate(@body)
                    else
                      @body.to_json
                    end
  end
end

require_relative 'models/init'
# Load all files under lib, helpers and routes
Dir["#{__dir__}/lib/*.rb", "#{__dir__}/helpers/*.rb","#{__dir__}/routes/*.rb"].each { |file| require file }
