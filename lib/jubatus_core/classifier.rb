require 'jubatus/classifier/client'
module JubatusCore
  class Classifier
    include JubatusCore
    def initialize(host: '127.0.0.1', port: 9199, name: '')
      @jubatus = Jubatus::Classifier::Client::Classifier.new(host, port, name)
    end

    private

    def client_analyze(source)
      @jubatus.classify(source)
    end

    def client_update(source)
      @jubatus.train(source)
    end
  end
end
