require 'spec_helper'

describe JubatusCore::Classifier do
  let(:jubatus) { JubatusCore::Classifier.new(name: 'hoge') }

  let(:data) {
    {
      'types' => { 'string' => 'str', 'number' => 'num' },
      'data' => [
        { 'string' => 'hoge', 'number' => 0 },
        { 'string' => 'foo', 'number' => 1}
      ],
      'label' => { 0 => 'hoge', 1 => 'foo' }
    }
  }

  before do
    jubatus.update(data)
  end

  describe '#update' do
    context 'success' do
      it { expect(jubatus.status["num_classes"].to_i).to eq(2) }
    end
  end

  describe '#result' do
    context 'success' do
      let(:ref) {
        {
          'types' =>  { 'string' => 'str', 'number' => 'num' },
          'data' => [ { 'string' => 'hige', 'number' => 3 } ]
        }
      }

      it { expect(jubatus.analyze(ref).first.size).to eq(2) }
    end
  end
end
