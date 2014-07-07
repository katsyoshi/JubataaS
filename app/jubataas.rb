require 'jubatus_core/classifier'
require 'bundler'
require 'json'
require 'haml'
Bundler.require

class JubataaS < Sinatra::Base
  NAME = 'hoge'
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  def startup_jubatus(name)
    @client = JubatusCore::Classifier.new(name: name)
    @client.load(name)
  rescue MessagePack::RPC::RuntimeError => e
    STDERR.puts(e)
  ensure
    @client
  end

  def shutdown_jubatus(name)
    @client.save(name)
    @client.clear
  end

  get '/css/main.css' do
    sass :'sass/main'
  end

  get '/js/main.js' do
    coffee :'coffee/main'
  end

  get '/' do
    haml :index
  end

  get "/classifier/status" do
    startup_jubatus(NAME)
    status = @client.status
    shutdown_jubatus(NAME)
    status.to_json
  end

  post "/classifier", provides: :json do
    params = JSON.parse(request.body.read)
    begin
      startup_jubatus(NAME)
      c = @client.result(@client.analyze(params))
      shutdown_jubatus(NAME)
      c.to_json
    rescue => e
      e
    end
  end

  post "/classifier/update", provides: :json do
    params = JSON.parse(request.body.read)
    begin
      startup_jubatus(NAME)
      @client.update(params)
      shutdown_jubatus(NAME)
    rescue => e
      e
    end
  end
end
