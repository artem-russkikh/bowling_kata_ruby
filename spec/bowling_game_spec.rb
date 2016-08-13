# frozen_string_literal: true
describe BowlingGame do
  it('can be rolled') { is_expected.to respond_to :roll }
  it('can get score') { is_expected.to respond_to :score }

  context 'rolled 20.times' do
    before { 20.times { subject.roll(0) } }

    it('score is zero') { expect(subject.score).to eq(0) }
  end
end
