$:.unshift File.join(__dir__, '../lib')
$:.unshift File.join(__dir__, '../app')

require 'sinatra'
require 'rack/test'
require 'rspec'

require 'jubataas_core'
require 'jubataas_core/classifier'
require 'jubataas'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before do
    jubatus = Jubatus::Classifier::Client::Classifier.new '127.0.0.1', 9199, ''
    retry_num = 0
    begin
      jubatus.save('pretest_status')
      jubatus.clear
    rescue MessagePack::RPC::TimeoutError
      if retry_num < 5
        retry_num += 1
        sleep 0.1
        retry
      end
    end
  end

  config.after do
    jubatus = Jubatus::Classifier::Client::Classifier.new '127.0.0.1', 9199, ''
    retry_num = 0
    begin
      jubatus.clear
      jubatus.load('pretest_status')
    rescue MessagePack::RPC::TimeoutError
      if retry_num < 5
        retry_num += 1
        sleep 0.1
        retry
      end
    end
  end
end
