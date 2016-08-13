# frozen_string_literal: true
require 'active_support/core_ext/array/grouping'

# A game has 10 frames
# A frame has 1 or two rolls
# The 'tenth frame' has two or three rolls
# It is different from all the other frames
class BowlingGame
  def initialize
    @rolls = []
    @current_roll = 0
  end

  # Called each time the player rolls a ball
  # @param pins [Integer] the number of pins knocked down
  # @return true
  def roll(pins:)
    @rolls[current_roll] = pins
    @current_roll = current_roll + 1
    true
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    result = 0
    rolls.in_groups_of(2) do |frame|
      result += (frame[0] + frame[1])
    end
    result
  end

  private

  attr_reader :rolls
  attr_reader :current_roll
end
