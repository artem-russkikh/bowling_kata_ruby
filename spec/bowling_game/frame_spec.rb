# frozen_string_literal: true
describe BowlingGame::Frame do
  it('respond_to #first_pin') { is_expected.to respond_to :first_pin }
  it('respond_to #strike?') { is_expected.to respond_to :strike? }
  it('respond_to #spare?') { is_expected.to respond_to :spare? }
  it('respond_to #score') { is_expected.to respond_to :score }

  context 'frame when passing wrong argument' do
    context 'if argument is not Array' do
      subject { described_class.new(pins: 'wrong argument') }

      context 'convert argument to blank Array' do
        it('#first_pin is correct') { expect(subject.first_pin).to eq(0) }
        it('#strike? is correct') { expect(subject.strike?).to eq(false) }
        it('#spare? is correct') { expect(subject.spare?).to eq(false) }
        it('#score is correct') { expect(subject.score).to eq(0) }
      end
    end

    context 'if argument contain anything other than Integer' do
      it 'raise error' do
        expect do
          described_class.new(pins: [0, 'asd'])
        end.to raise_error ArgumentError
      end
    end
  end

  context 'frame have nil' do
    subject { described_class.new(pins: [2, nil]) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(2) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
    it('#score is correct') { expect(subject.score).to eq(2) }
  end

  context 'frame can have only one element' do
    subject { described_class.new(pins: [2]) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(2) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
    it('#score is correct') { expect(subject.score).to eq(2) }

    context 'element is nil' do
      subject { described_class.new(pins: [nil]) }

      it('#first_pin is correct') { expect(subject.first_pin).to eq(0) }
      it('#strike? is correct') { expect(subject.strike?).to eq(false) }
      it('#spare? is correct') { expect(subject.spare?).to eq(false) }
      it('#score is correct') { expect(subject.score).to eq(0) }
    end
  end

  context 'frame without elements' do
    subject { described_class.new(pins: []) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(0) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
    it('#score is correct') { expect(subject.score).to eq(0) }
  end

  context 'default frame' do
    subject { described_class.new(pins: [1, 5]) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(1) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
    it('#score is correct') { expect(subject.score).to eq(6) }
  end

  context 'frame is spare' do
    subject { described_class.new(pins: [7, 3]) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(7) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(true) }
    it('#score is correct') { expect(subject.score).to eq(10) }
  end

  context 'frame is strike' do
    subject { described_class.new(pins: [10]) }

    it('#first_pin is correct') { expect(subject.first_pin).to eq(10) }
    it('#strike? is correct') { expect(subject.strike?).to eq(true) }
    it('#spare? is correct') { expect(subject.spare?).to eq(true) }
    it('#score is correct') { expect(subject.score).to eq(10) }
  end
end
