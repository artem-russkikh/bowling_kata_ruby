# frozen_string_literal: true
require 'active_support/core_ext/array/grouping'
require 'bowling_game/frame'

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
    frames_array = rolls.in_groups_of(2)
    frames_array.each_with_index do |frame_array, frame_index|
      current_frame = Frame.new(frame_array)
      next_frame = Frame.new(frames_array[frame_index + 1])
      result += if current_frame.spare?
                  current_frame.score + next_frame.first_roll
                else
                  current_frame.score
                end
    end
    result
  end

  private

  def spare?(frame_sum)
    frame_sum == 10
  end

  def sum_frames(first_frame, second_frame)
    first = first_frame || 0
    second = second_frame || 0
    first + second
  end

  attr_reader :rolls
  attr_reader :current_roll
end
