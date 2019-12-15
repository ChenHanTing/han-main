require 'sinatra/base'

class Api::Ping < Sinatra::Base
  get '/' do
    'API'
  end
end
