$:.unshift File.join(__dir__, '../lib')

require 'sinatra'
require 'rack/test'
require 'rspec'

require 'jubatus_core'
require 'jubatus_core/classifier'
RSpec.configure do |config|
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
