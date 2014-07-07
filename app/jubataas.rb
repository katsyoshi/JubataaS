require 'jubatus_core/classifier'
require 'bundler'
require 'json'
require 'haml'
Bundler.require

class JubataaS < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
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

  get "/classifier/:name/status.json" do
    name = params[:name]
    startup_jubatus(name)
    status = @client.status
    shutdown_jubatus(name)
    status.to_json
  end

  post "/classifier/:name.json", provides: :json do
    paramters = JSON.parse(request.body.read)
    begin
      name = params[:name]
      startup_jubatus(name)
      c = @client.result(@client.analyze(paramters))
      shutdown_jubatus(name)
      c.to_json
    rescue => e
      STDERR.puts e
      {error: e.backtrace}.to_json
    end
  end

  post "/classifier/:name/update.json", provides: :json do
    paramters = JSON.parse(request.body.read)
    begin
      name = params[:name]
      startup_jubatus(name)
      @client.update(paramters)
      shutdown_jubatus(name)
    rescue => e
      STDERR.puts e
      {error: e.backtrace}.to_json
    end
  end

  get '/classifier/:name/clear.json' do
    begin
      name = params[:name]
      startup_jubatus(name)
      @client.clear
      shutdown_jubatus(name)
    rescue => e
      STDERR.puts e
      {error: e.backtrace}.to_json
    end
  end

  private

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
end
