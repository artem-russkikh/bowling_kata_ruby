# frozen_string_literal: true
describe BowlingGame do
  it 'can roll' do
    expect(subject).to respond_to :roll
  end
end
