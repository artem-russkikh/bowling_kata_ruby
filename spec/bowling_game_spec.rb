# frozen_string_literal: true
describe BowlingGame do
  def roll_times(times = 20, pins = 0)
    times.times { subject.roll(pins: pins) }
  end

  it('can be #roll') { is_expected.to respond_to :roll }
  it('can get #score') { is_expected.to respond_to :score }

  context '#roll 20.times with zero pins' do
    before { roll_times(20, 0) }

    it('#score is correct') { expect(subject.score).to eq(0) }
  end

  context '#roll 20.times with one pins' do
    before { roll_times(20, 1) }

    it('#score is correct') { expect(subject.score).to eq(20) }
  end
end
