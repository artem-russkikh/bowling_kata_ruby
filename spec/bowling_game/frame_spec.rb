# frozen_string_literal: true
describe BowlingGame::Frame do
  it('respond_to #first_roll') { is_expected.to respond_to :first_roll }
  it('respond_to #second_roll') { is_expected.to respond_to :second_roll }
  it('respond_to #strike?') { is_expected.to respond_to :strike? }
  it('respond_to #spare?') { is_expected.to respond_to :spare? }

  context 'frame when passing wrong argument' do
    it 'raise error' do
      expect do
        described_class.new('wrong argument')
      end.to raise_error ArgumentError
    end
  end

  context 'frame have nil' do
    before { subject { described_class.new([2, nil]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(2) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(0) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
  end

  context 'frame can have only one element' do
    before { subject { described_class.new([2]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(2) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(0) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }

    context 'element is nil' do
      before { subject { described_class.new([nil]) } }

      it('#first_roll is correct') { expect(subject.first_roll).to eq(0) }
      it('#second_roll is correct') { expect(subject.second_roll).to eq(0) }
      it('#strike? is correct') { expect(subject.strike?).to eq(false) }
      it('#spare? is correct') { expect(subject.spare?).to eq(false) }
    end
  end

  context 'frame without elements' do
    before { subject { described_class.new([]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(0) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(0) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
  end

  context 'default frame' do
    before { subject { described_class.new([1, 5]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(1) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(5) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(false) }
  end

  context 'frame is spare' do
    before { subject { described_class.new([7, 3]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(7) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(3) }
    it('#strike? is correct') { expect(subject.strike?).to eq(false) }
    it('#spare? is correct') { expect(subject.spare?).to eq(true) }
  end

  context 'frame is strike' do
    before { subject { described_class.new([10]) } }

    it('#first_roll is correct') { expect(subject.first_roll).to eq(10) }
    it('#second_roll is correct') { expect(subject.second_roll).to eq(0) }
    it('#strike? is correct') { expect(subject.strike?).to eq(true) }
    it('#spare? is correct') { expect(subject.spare?).to eq(true) }
  end
end
