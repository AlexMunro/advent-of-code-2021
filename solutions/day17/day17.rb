# frozen_string_literal: true

require_relative "../../utils/input/lines"
require_relative "../../utils/math_utils/numbers"
require_relative "./launch"

# Mostly naive implementation with a few uses of triangular numbers for
# bounding the search space and calculating the peak
class Day17
  extend Input::Lines

  def self.part_one
    new(input[0]).peak
  end

  def self.part_two
    new(input[0]).valid_velocity_combination_count
  end

  def initialize(input)
    parsed_input = parse_input(input)
    @x_target = parsed_input[:x_target]
    @y_target = parsed_input[:y_target]
  end

  def peak
    # Intuitively, we can get the most airtime with the highest peak with
    # the slowest x axis velocity and highest y axis velocity.
    (minimum_x_velocity..).each do |x_velocity|
      successful_y_velocities = successful_y_velocities_for_x_velocity(x_velocity)
      return MathUtils::Numbers.triangle_number(successful_y_velocities.max) if successful_y_velocities.any?
    end
  end

  def valid_velocity_combination_count
    (minimum_x_velocity..@x_target.end).sum do |x_velocity|
      successful_y_velocities_for_x_velocity(x_velocity).length
    end
  end

  private

  def parse_input(input)
    regex = /x=(?<x_begin>-?\d+)..(?<x_end>-?\d+), y=(?<y_begin>-?\d+)..(?<y_end>-?\d+)/
    parsed_values = regex.match(input)

    {
      x_target: (parsed_values[:x_begin].to_i)..(parsed_values[:x_end].to_i),
      y_target: (parsed_values[:y_begin].to_i)..(parsed_values[:y_end].to_i),
    }
  end

  def minimum_x_velocity
    # Some napkin maths gives us a lower bound for the triangle number needed
    # to reach the x target area
    (Math.sqrt(2 * @x_target.begin).floor..).find do |x_velocity|
      MathUtils::Numbers.triangle_number(x_velocity) >= @x_target.begin
    end
  end

  def successful_y_velocities_for_x_velocity(x_velocity)
    (@y_target.begin..@y_target.begin.abs).each do |y_velocity|
      result_at(x_velocity, y_velocity)
    end

    @all_results[x_velocity].map do |y_velocity, result|
      y_velocity if result == Launch::ON_TARGET
    end.compact
  end

  def result_at(x_velocity, y_velocity)
    @all_results ||= {}
    @all_results[x_velocity] ||= {}
    @all_results[x_velocity][y_velocity] ||= Launch.new(@x_target, @y_target, x_velocity, y_velocity).result
  end
end
