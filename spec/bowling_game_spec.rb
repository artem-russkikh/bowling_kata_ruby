# frozen_string_literal: true
describe BowlingGame do
  it 'can be rolled' do
    expect(subject).to respond_to :roll
  end

  it 'can get score' do
    expect(subject).to respond_to :score
  end
end
