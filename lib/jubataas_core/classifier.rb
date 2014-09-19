require 'jubatus/classifier/client'
module JubataasCore
  class Classifier
    include JubataasCore
    def initialize(host: '127.0.0.1', port: 9199, name: '')
      @jubatus = Jubatus::Classifier::Client::Classifier.new(host, port, name)
    end

    def result(results)
      results.map do |result|
        result.map do |er|
          {score: er.score, label: er.label}
        end
      end
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
