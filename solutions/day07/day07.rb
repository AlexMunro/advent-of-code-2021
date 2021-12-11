# frozen_string_literal: true

require_relative "../../utils/input/int_list"

class Day07
  extend Input::IntList

  def self.part_one
    new(input).least_fuel_required(:linear_fuel_required_for_position)
  end

  def self.part_two
    new(input).least_fuel_required(:superlinear_fuel_required_for_position)
  end

  def initialize(starting_positions)
    @starting_positions = starting_positions.sort
    @linear_fuel_required_for_position = {}
    @superlinear_fuel_required_for_position = {}
  end

  # Binary search starting from the mean
  def least_fuel_required(fuel_required)
    search_position = @starting_positions.sum / @starting_positions.length
    lower_bound = @starting_positions.first
    upper_bound = @starting_positions.last

    loop do
      if send(fuel_required, search_position) > send(fuel_required, search_position - 1)
        upper_bound = search_position - 1
      elsif send(fuel_required, search_position) > send(fuel_required, search_position + 1)
        lower_bound = search_position + 1
      else
        return send(fuel_required, search_position)
      end

      search_position = (lower_bound + upper_bound) / 2
    end
  end

  def linear_fuel_required_for_position(position)
    @linear_fuel_required_for_position[position] ||= @starting_positions.sum { |n| (position - n).abs }
  end

  def superlinear_fuel_required_for_position(position)
    @superlinear_fuel_required_for_position[position] ||= @starting_positions.sum do |n|
      distance = (position - n).abs
      distance * (distance + 1) / 2
    end
  end
end
