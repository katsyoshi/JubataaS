require 'spec_helper'

describe 'JubataaS' do
  include Rack::Test::Methods

  let(:app) { JubataaS }
  let(:test) { 'test' }
  let(:response) { JSON.parse(last_response.body) }
  let(:learn_data) {
    {
      'types' => { 'name' => 'str', 'num' => 'num', 'str' => 'str' },
      'data' => [ {'name' => 'hoge', 'num' => 1, 'str' => 10} ],
    }
  }
  let(:analyze_data) { learn_data['label'] = { '1' => 'foo' } }

  describe 'get status' do
    context 'success' do
      before do
        get "/classifier/#{test}/status.json"
      end
      it { expect(response["PROGNAME"]).to eq("jubaclassifier") }
    end
  end
end
