# frozen_string_literal: true
require 'active_support/core_ext/array/grouping'
require 'bowling_game/frame'
require 'bowling_game/pin'

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
    roll(pins: 0) if strike?(pins)
    true
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    result = 0
    rolls.in_groups_of(2).each_with_index do |frame_array, frame_index|
      result += process_frame(frame_array, frame_index)
    end
    result
  end

  private

  # @return [Boolean]
  def strike?(pins)
    pins == 10
  end

  # @return [Integer]
  def strike_bonus(frame_index)
    next_frame = Frame.new(rolls.in_groups_of(2)[frame_index + 1])
    next_frame.score
  end

  # @return [Integer]
  def spare_bonus(frame_index)
    next_frame = Frame.new(rolls.in_groups_of(2)[frame_index + 1])
    next_frame.first_roll
  end

  # @return [Integer]
  def process_frame(frame_array, frame_index)
    current_frame = Frame.new(frame_array)
    if current_frame.strike?
      current_frame.score + strike_bonus(frame_index)
    elsif current_frame.spare?
      current_frame.score + spare_bonus(frame_index)
    else
      current_frame.score
    end
  end

  # @return [Array]
  attr_reader :rolls
  # @return [Integer]
  attr_reader :current_roll
end
