# frozen_string_literal: true

require_relative "../../utils/input/int_grid"

require "set"
require "rbtree"

class Day15
  extend Input::IntGrid

  def self.part_one
    new(input).shortest_path
  end

  def self.part_two
    new(input).shortest_path_through_larger_maze
  end

  def initialize(grid)
    @grid = grid
  end

  def shortest_path_through_larger_maze
    @grid = @grid.map do |line|
      (0..4).map { |n| line.map { |digit| escalate_risk(digit, n) } }.flatten(1)
    end

    @grid = (0..4).map do |n|
      @grid.map do |line|
        line.map { |digit| escalate_risk(digit, n) }
      end
    end.flatten(1)

    shortest_path
  end

  def shortest_path
    goal = [@grid[0].length - 1, @grid.length - 1]
    frontier = MultiRBTree[0 => [0, 0]]
    visited = Set.new([[0, 0]])

    while (distance, position = frontier.shift)
      return distance if position == goal

      adjacent_points(position).each do |neighbour|
        next if visited.include? neighbour

        visited = visited.merge([neighbour])
        frontier[distance + @grid[neighbour.last][neighbour.first]] = neighbour
      end
    end

    raise "Solution not found"
  end

  private

  def adjacent_points(point)
    x = point.first
    y = point.last

    [
      ([x + 1, y] if x < @grid[0].length - 1),
      ([x, y + 1] if y < @grid.length - 1),
      ([x - 1, y] if x.positive?),
      ([x, y - 1] if y.positive?),
    ].compact
  end

  def escalate_risk(original_risk_level, escalation_rate)
    ((original_risk_level - 1 + escalation_rate) % 9) + 1
  end
end
