# frozen_string_literal: true
require 'active_support/core_ext/object/blank'

class BowlingGame
  # Class for safely accessing score in frames
  class Frame
    attr_reader :first_roll
    attr_reader :second_roll

    def initialize(frame = [])
      raise ArgumentError unless frame.is_a?(Array)
      args = frame.first(2).delete_if(&:blank?)
      raise ArgumentError if args.any? { |roll| !roll.is_a?(Integer) }
      @first_roll = args[0] || 0
      @second_roll = args[1] || 0
    end

    def strike?
      first_roll == 10
    end

    def spare?
      first_roll + second_roll == 10
    end
  end
end
