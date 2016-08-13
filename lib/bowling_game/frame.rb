# frozen_string_literal: true
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/module/delegation'

class BowlingGame
  # Class for safely accessing score in frames
  class Frame
    # @return [BowlingGame::Frame]
    attr_accessor :prev_frame, :next_frame
    # @return [Array]
    attr_reader :pins

    delegate :count, :size, :blank, :empty, to: :pins

    # @return [BowlingGame::Frame]
    def initialize(*arguments)
      args = arguments[0] || {}
      self.prev_frame = args[:prev_frame]
      self.next_frame = args[:next_frame]
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
      pins.sum == 10
    end

    # @return [Integer]
    def score
      score_count = frame_score
      if strike?
        score_count + strike_bonus
      elsif spare?
        score_count + spare_bonus
      else
        score_count
      end
    end

    # @return [BowlingGame::Frame]
    def push(pin)
      @pins.push(pin)
    end

    protected

    def frame_score
      pins.sum
    end

    private

    def strike_bonus
      return 0 unless next_frame
      return next_frame.frame_score unless next_frame.strike?
      frame_after_next_score = next_frame&.next_frame&.frame_score || 0
      next_frame.frame_score + frame_after_next_score
    end

    def spare_bonus
      next_frame.try(:first_pin) || 0
    end
  end
end
