# frozen_string_literal: true
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/module/delegation'

class BowlingGame
  # Class for safely accessing score in frames
  class Frame
    # @return [Array]
    attr_reader :pins

    delegate :count, :size, to: :pins

    # @return [BowlingGame::Frame]
    def initialize(args = [])
      @pins = args
      @pins = [] unless pins.is_a?(Array)
      @pins = pins.delete_if(&:blank?)
      raise ArgumentError if pins.any? { |pin| !pin.is_a?(Integer) }
    end

    # @return [Integer]
    def first_roll
      pins[0] || 0
    end

    # @return [Integer]
    def second_roll
      pins[1] || 0
    end

    # @return [Boolean]
    def strike?
      first_roll == 10
    end

    # @return [Boolean]
    def spare?
      score == 10
    end

    # @return [Integer]
    def score
      pins.sum
    end

    # @return [BowlingGame::Frame]
    def push(pin)
      @pins.push(pin)
    end
  end
end
