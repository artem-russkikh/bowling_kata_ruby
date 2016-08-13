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
    frames = rolls.in_groups_of(2)
    frames.each_with_index do |frame, frame_index|
      next_frame = frames[frame_index + 1]
      frame_sum = frame[0] + frame[1]
      result += if spare?(frame_sum)
                  frame_sum + next_frame[0] # spare
                else
                  frame_sum
                end
    end
    result
  end

  private

  def spare?(frame_sum)
    frame_sum == 10
  end

  attr_reader :rolls
  attr_reader :current_roll
end
