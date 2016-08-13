# frozen_string_literal: true
require 'bowling_game/frame'

# A game has 10 frames
# A frame has 1 or two rolls
# The 'tenth frame' has two or three rolls
# It is different from all the other frames
class BowlingGame
  def initialize
    @frames = []
    @current_frame = 0
  end

  # Called each time the player rolls a ball
  # @param pins [Integer] the number of pins knocked down
  # @return true
  def roll(pins:)
    return false if current_frame >= 10
    update_current_frame!(pins)
    true
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    result = 0
    frames.each { |frame| result += frame.score }
    result
  end

  private

  # Return proceeded frame after performing roll with pins
  # @return [BowlingGame::Frame]
  def frame_after_roll(pins)
    frame = frames[current_frame]
    return Frame.new(pins: [pins]) if frame.nil?
    roll_limit = 2
    roll_limit = 1 if frame.pins.first == 10
    roll_limit = 3 if current_frame == 10 && pins == 10
    return nil if frame.count >= roll_limit
    frame.push(pins)
    frame
  end

  def update_current_frame!(pins)
    updated_frame = frame_after_roll(pins)
    return (frames[current_frame] = updated_frame) if updated_frame
    last_frame = frames.last
    @current_frame = current_frame + 1
    frames.push Frame.new(pins: [pins], prev_frame: last_frame)
    last_frame.next_frame = frames.last
  end

  # @return [Array]
  attr_reader :frames
  # @return [Integer]
  attr_reader :current_frame
end
