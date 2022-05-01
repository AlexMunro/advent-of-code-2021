# frozen_string_literal: true

require_relative "../../utils/input/lines"

require "rbtree"
require "set"

require_relative "./pods_state"

class Day23
  extend Input::Lines

  def self.part_one
    new(input).organisation_cost
  end

  def self.part_two
  end

  def initialize(lines)
    initial_rows = lines[2..3].map { |line| line.chars.filter { |c| c >= "A" && c <= "D" } }
    @initial_state = PodsState.new(initial_rows)
  end

  def organisation_cost
    frontier = MultiRBTree[0 => @initial_state]
    visited = Set.new

    while (cost, current_state = frontier.shift)
      return cost if current_state.goal?

      puts "ayy" if visited.include? current_state
      next if visited.include? current_state
      visited << current_state

      current_state.neighbours.each { |neighbour, neighbour_cost| frontier[cost + neighbour_cost] = neighbour }
    end

    raise "Unable to find a solution"
  end
end
