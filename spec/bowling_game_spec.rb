# frozen_string_literal: true
describe BowlingGame do
  def roll_many(times = 20, pins = 0)
    times.times { subject.roll(pins: pins) }
  end

  def roll_spare
    subject.roll(pins: 5)
    subject.roll(pins: 5)
  end

  def roll_strike
    subject.roll(pins: 10)
  end

  it('can be #roll') { is_expected.to respond_to :roll }
  it('can get #score') { is_expected.to respond_to :score }

  context '#roll 20.times with zero pins' do
    before { roll_many(20, 0) }

    it('#score is correct') { expect(subject.score).to eq(0) }
  end

  context '#roll 20.times with one pins' do
    before { roll_many(20, 1) }

    it('#score is correct') { expect(subject.score).to eq(20) }
  end

  context '#roll spare' do
    before do
      roll_spare
      subject.roll(pins: 3)
      roll_many(17, 0)
    end

    it('spare add extra 3 score') { expect(subject.score).to eq(16) }
  end

  context '#roll strike' do
    before do
      roll_strike
      subject.roll(pins: 3)
      subject.roll(pins: 4)
      roll_many(16, 0)
    end

    it('strike add extra 3+4 scores') { expect(subject.score).to eq(24) }
  end
end
