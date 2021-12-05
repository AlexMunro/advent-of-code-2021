# frozen_string_literal: true

require_relative "./line"

class Day05
  INPUT = File.expand_path("../../inputs/day05.txt", File.dirname(__FILE__))

  def self.input
    File.readlines(INPUT)
  end

  def self.part_one
    new(input).overlapping_points_for_horizontal_and_vertical_lines.count
  end

  def self.part_two
    new(input).overlapping_points_for_all_lines.count
  end

  def initialize(input)
    @input = input
  end

  def overlapping_points_for_horizontal_and_vertical_lines
    all_lines = @input.map { |line_string| Line.from_string(line_string) }
    find_repeated_points(horizontal_and_vertical_lines(all_lines))
  end

  def overlapping_points_for_all_lines
    all_lines = @input.map { |line_string| Line.from_string(line_string) }
    find_repeated_points(all_lines)
  end

  private

  def find_repeated_points(lines)
    lines
      .flat_map(&:enumerate_points)
      .tally
      .filter { |_, count| count > 1 }
      .keys
  end

  def horizontal_and_vertical_lines(lines)
    lines.filter { |line| line.horizontal? || line.vertical? }
  end
end
