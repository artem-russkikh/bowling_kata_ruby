# frozen_string_literal: true
require 'active_support/core_ext/module/delegation'

class BowlingGame
  # Class for safely accessing pins values in frames
  class Pin
    attr_reader :value

    delegate :to_i, to: :value

    def initialize(val = 0)
      @value = val
      @value = 0 unless value.is_a?(Integer)
    end

    def strike?
      value == 10
    end
  end
end
