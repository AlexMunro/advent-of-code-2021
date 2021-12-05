# frozen_string_literal: true

class Day03
  INPUT = File.expand_path("../../inputs/day03.txt", File.dirname(__FILE__))

  def self.input
    @input ||= File.open(INPUT).readlines.map(&:strip)
  end

  def self.part_one
    solution = new(input)
    solution.gamma * solution.epsilon
  end

  def self.part_two
    solution = new(input)
    solution.oxygen_generation * solution.co2_rating
  end

  def initialize(input)
    @input = input
  end

  def gamma
    @gamma ||= (0...@input[0].length).map do |i|
      @input.map { |bitstring| bitstring[i] }
        .tally
        .max_by(&:last)
        .first
    end.join.to_i(2)
  end

  def epsilon
    (2**@input[0].length) - 1 - gamma
  end

  def oxygen_generation
    (0...@input.length).inject(@input) do |remaining_readings, i|
      most_common_value = remaining_readings
        .map { |reading| reading[i] }
        .tally
        .max_by { |value, frequency| [frequency, value] }
        .first

      remaining_readings.filter { |reading| reading[i] == most_common_value }
    end.first.to_i(2)
  end

  def co2_rating
    (0...@input.length).inject(@input) do |remaining_readings, i|
      least_common_value = remaining_readings
        .map { |r| r[i] }
        .tally
        .min_by { |value, frequency| [frequency, value] }
        .first

      remaining_readings.filter { |r| r[i] == least_common_value }
    end.first.to_i(2)
  end
end
