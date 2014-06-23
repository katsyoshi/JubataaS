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
  rescue MessagePack::RPC::RuntimeError
  ensure
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
end
