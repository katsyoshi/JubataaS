require 'spec_helper'

describe JubatusCore::Classifier do
  let(:save_file) { 'jubatus' }
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

      let(:results) {
        jubatus.analyze(ref).first
      }

      it { expect(results.size).to eq(2) }
      it { expect(results.first.label).to eq('foo') }
    end
  end

  describe '#save' do
    context 'success' do
      before do
        jubatus.save(save_file)
      end

      it 'get status' do
        expect(jubatus.status["num_classes"].to_i).to eq(2)
      end

      it 'after clear' do
        jubatus.clear
        expect(jubatus.status['num_classes'].to_i).to be_zero
      end
    end
  end

  describe '#load' do
    context 'success' do
      before do
        jubatus.save(save_file)
        jubatus.clear
      end

      it 'get status in befoer load' do
        expect(jubatus.status['num_classes'].to_i).to be_zero
      end

      it 'load status' do
        jubatus.load(save_file)
        expect(jubatus.status['num_classes'].to_i).to eq(2)
      end
    end
  end
end
