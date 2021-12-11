# frozen_string_literal: true

require_relative "../../utils/input/file"

class Day09
  extend Input::File

  def self.input
    File.open(INPUT).readlines.map do |line|
      line.strip.chars.map(&:to_i)
    end
  end

  def self.part_one
    new(input).sum_risk_of_low_points
  end

  def self.part_two
    new(input).largest_three_basins_size
  end

  def initialize(heatmap)
    @heatmap = heatmap
    @adjacent_points = {}
  end

  def sum_risk_of_low_points
    low_points.sum { |point| height_at(point) } + low_points.length
  end

  def largest_three_basins_size
    low_points
      .map { |point| basin_surrounding(point).length }
      .sort
      .reverse[..2]
      .reduce(:*)
  end

  private

  def low_points
    @low_points ||= (0...@heatmap.length).flat_map do |y|
      (0...@heatmap[0].length)
        .filter { |x| minimum_point([x, y], adjacent_points([x, y])) }
        .map { |x| [x, y] }
    end
  end

  def height_at(point)
    @heatmap[point.last][point.first]
  end

  def adjacent_points(point)
    @adjacent_points[point] ||= begin
      x = point.first
      y = point.last

      [
        ([x - 1, y] if x.positive?),
        ([x + 1, y] if x < @heatmap[0].length - 1),
        ([x, y - 1] if y.positive?),
        ([x, y + 1] if y < @heatmap.length - 1)
      ].compact
    end
  end

  def adjacent_points_except(point, points)
    adjacent_points(point) - points.to_a
  end

  def basin_surrounding(starting_point)
    explored = seen = []
    frontier = [starting_point]

    until frontier.empty?
      valid_frontier = frontier
        .filter { |point| minimum_point(point, adjacent_points_except(point, seen + frontier)) }

      seen += frontier
      explored += valid_frontier

      frontier = next_basin_frontier(valid_frontier, explored)
    end

    explored.uniq
  end

  def minimum_point(point, adjacent_points)
    return false if height_at(point) == 9
    return true if adjacent_points.empty?

    height_at(point) < adjacent_points.map { |adj| height_at(adj) }.min
  end

  def next_basin_frontier(valid_frontier, explored)
    valid_frontier
      .flat_map { |point| adjacent_points_except(point, explored + valid_frontier) }
      .filter { |point| !explored.include?(point) }
      .uniq
  end
end
