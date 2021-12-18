# frozen_string_literal: true

require_relative "../../utils/input/lines"

require_relative "./packet"

class Day16
  extend Input::Lines

  def self.part_one
    new(input.first).sum_version_numbers
  end

  def self.part_two
    new(input.first).evaluate
  end

  def initialize(input_string)
    transmission = input_string.each_char.map { |c| format("%04d", c.hex.to_s(2)) }.join
    @outer_packet = Packet.from_bits(transmission)
  end

  def sum_version_numbers
    @outer_packet.version_sum
  end

  def evaluate
    @outer_packet.value
  end
end
