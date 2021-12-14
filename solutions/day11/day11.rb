# frozen_string_literal: true

require "set"
require_relative "../../utils/input/int_grid"

class Day11
  extend Input::IntGrid

  def self.part_one
    new(input).total_flashes(100)
  end

  def self.part_two
    new(input).flash_sync_step
  end

  def initialize(octopodes)
    @octopodes = octopodes
  end

  def total_flashes(steps)
    1.upto(steps).sum { flashes_in_next_step }
  end

  def flash_sync_step
    (1..).find { flashes_in_next_step == @octopodes.sum(&:length) }
  end

  private

  def flashes_in_next_step
    flashed_this_step = Set.new
    @octopodes = @octopodes.map { |row| row.map { |octopus| octopus + 1 } }

    while (currently_flashing = ready_to_flash).any?
      flashed_this_step.merge(currently_flashing)
      currently_flashing.each { |x, y| reset_and_increment_neighbours(x, y, flashed_this_step) }
    end

    flashed_this_step.length
  end

  def ready_to_flash
    @octopodes.each_with_index.map do |row, y|
      row.each_with_index.filter_map { |octopus, x| [x, y] if octopus >= 10 }
    end.reject(&:empty?).flatten(1)
  end

  def reset_and_increment_neighbours(x, y, already_flashed)
    @octopodes[y][x] = 0
    adjacent_points_except([x, y], already_flashed).each do |adjacent_x, adjacent_y|
      @octopodes[adjacent_y][adjacent_x] += 1
    end
  end

  def adjacent_points(point)
    @adjacent_points ||= {}

    @adjacent_points[point] ||= begin
      x = point.first
      y = point.last

      [
        ([x - 1, y] if x.positive?),
        ([x + 1, y] if x < @octopodes[0].length - 1),
        ([x, y - 1] if y.positive?),
        ([x, y + 1] if y < @octopodes.length - 1),
        ([x - 1, y - 1] if x.positive? && y.positive?),
        ([x + 1, y - 1] if x < @octopodes[0].length - 1 && y.positive?),
        ([x - 1, y + 1] if x.positive? && y < @octopodes.length - 1),
        ([x + 1, y + 1] if x < @octopodes[0].length - 1 && y < @octopodes.length - 1),
      ].compact
    end
  end

  def adjacent_points_except(point, points)
    adjacent_points(point) - points.to_a
  end
end
