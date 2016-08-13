# frozen_string_literal: true
describe BowlingGame::Pin do
  it('respond_to #value') { is_expected.to respond_to :value }
  it('respond_to #strike?') { is_expected.to respond_to :strike? }
  it('respond_to #to_i') { is_expected.to respond_to :to_i }

  context 'if argument is not Integer' do
    subject { described_class.new('wrong argument') }

    context 'convert argument to zero' do
      it('#value is correct') { expect(subject.value).to eq(0) }
      it('#strike? is correct') { expect(subject.strike?).to eq(false) }
      it('#to_i is correct') { expect(subject.to_i).to eq(subject.value.to_i) }
    end
  end

  context 'if argument is present' do
    subject { described_class.new(4) }

    it('#value is correct') { expect(subject.value).to eq(4) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#to_i is correct') { expect(subject.to_i).to eq(subject.value.to_i) }
  end

  context 'if argument is strike' do
    subject { described_class.new(10) }

    it('#value is correct') { expect(subject.value).to eq(10) }
    it('#strike? is correct') { expect(subject.strike?).to eq(true) }
    it('#to_i is correct') { expect(subject.to_i).to eq(subject.value.to_i) }
  end
end
