# frozen_string_literal: true
require 'active_support/core_ext/array/grouping'
require 'active_support/core_ext/object/try'
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
    updated_frame = frame_after_roll(pins)
    if updated_frame
      @frames[current_frame] = updated_frame
    else
      @current_frame = current_frame + 1
      @frames[current_frame] = Frame.new([pins])
    end
    true
  end

  # Return proceeded frame after performing roll with pins
  # @return [BowlingGame::Frame]
  def frame_after_roll(pins)
    frame = @frames[current_frame].try(:dup)
    return Frame.new([pins]) if frame.nil?
    roll_limit = 2
    roll_limit = 1 if frame.pins.first == 10
    roll_limit = 3 if current_frame == 10 && pins == 10
    return nil if frame.count >= roll_limit
    frame.push(pins)
    frame
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    result = 0
    frames.each_with_index do |frame, frame_index|
      result += process_frame(frame, frame_index)
    end
    result
  end

  private

  # @return [Integer]
  def strike_bonus(frame_index)
    next_frame = frames[frame_index + 1]
    return 0 unless next_frame
    if next_frame.strike?
      frame_after_next = frames[frame_index + 2]
      if frame_after_next
        next_frame.score + frame_after_next.score
      else
        next_frame.score
      end
    else
      next_frame.score
    end
  end

  # @return [Integer]
  def spare_bonus(frame_index)
    next_frame = frames[frame_index + 1]
    next_frame.first_roll
  end

  # @return [Integer]
  def process_frame(frame, frame_index)
    if frame.strike?
      frame.score + strike_bonus(frame_index)
    elsif frame.spare?
      frame.score + spare_bonus(frame_index)
    else
      frame.score
    end
  end

  # @return [Array]
  attr_reader :frames
  # @return [Integer]
  attr_reader :current_frame
end
