require 'jubatus_core/classifier'
require 'bundler'
require 'json'
Bundler.require

class JubataaS < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  def startup_jubatus(name)
    @client = JubatusCore::Classifier.new(name: name)
    @client.load(name)
    @client
  end

  def shutdown_jubatus(name)
    @client.save(name)
    @client.clear
  end

  get "/classifier/status" do
    startup_jubatus("hoge")
    status = @client.status
    shutdown_jubatus("hoge")
    status.to_json
  end

  post "/classifier", provides: :json do
    params = JSON.parse(request.body.read)
    begin
      startup_jubatus("hoge")
      c = @client.result(@client.analyze(params))
      shutdown_jubatus("hoge")
      c.to_json
    rescue => e
      e
    end
  end

  post "/classifier/update", provides: :json do
    params = JSON.parse(request.body.read)
    begin
      startup_jubatus("hoge")
      @client.update(params)
      shutdown_jubatus("hoge")
    rescue => e
      e
    end
  end
end
