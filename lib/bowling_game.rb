# frozen_string_literal: true

# A game has 10 frames
# A frame has 1 or two rolls
# The 'tenth frame' has two or three rolls
# It is different from all the other frames
class BowlingGame
  # @see #score
  attr_writer :score

  # Called each time the player rolls a ball
  # @param pins [Integer] the number of pins knocked down
  # @return true
  def roll(pins:)
    self.score += pins
    true
  end

  # Iterate through all the frames, and calculate all their scores
  # @return [Integer]
  def score
    @score || 0
  end
end
