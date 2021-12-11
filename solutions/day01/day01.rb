# frozen_string_literal: true

require_relative "../../utils/input/int_list"

class Day01
  extend Input::IntList

  def self.part_one
    number_of_improvements(input)
  end

  def self.part_two
    number_of_group_improvements(input)
  end

  def self.number_of_improvements(measurements)
    measurements.each_cons(2).count { |obj| obj[0] < obj[1] }
  end

  def self.number_of_group_improvements(measurements)
    measurements.each_cons(4).count { |obj| obj[..2].sum < obj[1..].sum }
  end
end
