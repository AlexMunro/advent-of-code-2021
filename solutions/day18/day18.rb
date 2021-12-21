# frozen_string_literal: true

require_relative "../../utils/input/eval_lines"

require_relative "./snail_number"

class Day18
  extend Input::EvalLines

  def self.part_one
    new(input).sum_magnitude
  end

  def self.part_two
    new(input).largest_magnitude_from_two
  end

  def initialize(snail_arrays)
    @snail_arrays = snail_arrays
    @snail_numbers = SnailNumber.new(snail_arrays)
  end

  def sum_magnitude
    @snail_numbers.tap(&:sum).magnitude
  end

  def largest_magnitude_from_two
    combinations = @snail_arrays.combination(2) + @snail_arrays.reverse.combination(2)
    combinations
      .map { |snail_pair| SnailNumber.new(deep_copy(snail_pair)).tap(&:sum).magnitude }
      .max
  end

  private

  # This is an awful hack. Be very, very careful with your input!
  def deep_copy(array)
    eval(array.to_s) # rubocop:disable Security/Eval
  end
end
