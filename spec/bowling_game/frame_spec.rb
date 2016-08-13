# frozen_string_literal: true
describe BowlingGame::Frame do
  it('respond_to #first_roll') { is_expected.to respond_to :first_roll }
  it('respond_to #second_roll') { is_expected.to respond_to :second_roll }
end
