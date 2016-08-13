# frozen_string_literal: true
require 'active_support/core_ext/enumerable'
require 'bowling_game/frame'

# A game has 10 frames
# A frame has 1 or two rolls
# The 'tenth frame' has two or three rolls
# It is different from all the other frames
class BowlingGame
  def initialize
    @frames = []
    @current_frame = nil
    @current_frame_index = 0
    @pins = nil
  end

  # Called each time the player rolls a ball
  # @param pins [Integer] the number of pins knocked down
  # @return true
  def roll(pins:)
    return false if tenth_frame?
    @pins = pins
    update_current_frame!
    true
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    frames.sum(&:score)
  end

  private

  def tenth_frame?
    current_frame_index >= 10
  end

  # @return [BowlingGame::Frame]
  def update_current_frame!
    updated_frame = frame_after_roll
    return (self.current_frame = updated_frame) if updated_frame
    last_frame = frames.last
    @current_frame_index = current_frame_index + 1
    frames.push Frame.new(pins: [pins], prev_frame: last_frame)
    last_frame.next_frame = frames.last
  end

  # Return proceeded frame after performing roll with pins
  # @return [BowlingGame::Frame]
  def frame_after_roll
    return Frame.new(pins: [pins]) if current_frame.nil?
    return nil if current_frame.count >= roll_limit
    current_frame.push(pins)
    current_frame
  end

  # @return [Integer]
  def roll_limit
    return 1 if current_frame_is_strike?
    return 3 if tenth_frame? && pins_is_a_strike?
    2
  end

  # @return [Boolean]
  def pins_is_a_strike?
    pins == 10
  end

  # @return [BowlingGame::Frame]
  def current_frame
    frames[current_frame_index]
  end

  # @return [Boolean]
  def current_frame_is_strike?
    current_frame.pins.first == 10
  end

  # @return [BowlingGame::Frame]
  def current_frame=(value)
    frames[current_frame_index] = value
  end

  # @return [Integer]
  attr_reader :pins
  # @return [Array]
  attr_reader :frames
  # @return [Integer]
  attr_reader :current_frame_index
end
