# frozen_string_literal: true
require 'active_support/core_ext/object/blank'

class BowlingGame
  # Class for safely accessing score in frames
  class Frame
    # @return [Integer]
    attr_reader :first_roll
    # @return [Integer]
    attr_reader :second_roll

    # @return [BowlingGame::Frame]
    def initialize(frame = [])
      args = frame
      args = [] unless args.is_a?(Array)
      args = args.first(2).delete_if(&:blank?)
      raise ArgumentError if args.any? { |roll| !roll.is_a?(Integer) }
      @first_roll = args[0] || 0
      @second_roll = args[1] || 0
    end

    # @note immutable
    # @return [Boolean]
    def strike?
      @is_strike ||= first_roll == 10
    end

    # @note immutable
    # @return [Boolean]
    def spare?
      @is_spare ||= score == 10
    end

    # @note immutable
    # @return [Integer]
    def score
      @score ||= first_roll + second_roll
    end
  end
end
