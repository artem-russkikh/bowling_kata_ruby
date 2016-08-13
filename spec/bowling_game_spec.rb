# frozen_string_literal: true
describe BowlingGame do
  it('can be #roll') { is_expected.to respond_to :roll }
  it('can get #score') { is_expected.to respond_to :score }

  context '#roll 20.times with zero pins' do
    before { 20.times { subject.roll(pins: 0) } }

    it('#score is correct') { expect(subject.score).to eq(0) }
  end

  context '#roll 20.times with one pins' do
    before { 20.times { subject.roll(pins: 1) } }

    it('#score is correct') { expect(subject.score).to eq(20) }
  end
end
