# frozen_string_literal: true
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/module/delegation'

class BowlingGame
  # Class for safely accessing score in frames
  class Frame
    # @return [BowlingGame::Frame]
    attr_accessor :prev, :next
    # @return [Array]
    attr_reader :pins

    delegate :count, :size, :blank, :empty, to: :pins

    # @return [BowlingGame::Frame]
    def initialize(*arguments)
      args = arguments[0] || {}
      @prev = args[:prev]
      @next = args[:next]
      pins_value = args[:pins]
      @pins = pins_value
      @pins = [] unless pins_value.is_a?(Array)
      @pins = pins.delete_if(&:blank?)
      raise ArgumentError if pins.any? { |pin| !pin.is_a?(Integer) }
    end

    # @return [Integer]
    def first_pin
      pins[0] || 0
    end

    # @return [Boolean]
    def strike?
      first_pin == 10
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
