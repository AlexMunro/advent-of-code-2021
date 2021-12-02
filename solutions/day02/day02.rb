# frozen_string_literal: true

class Day02
  INPUT = "../../inputs/day02.txt"

  def self.input
    @input ||= File.open(INPUT).readlines.map(&:strip).map(&:split)
  end

  def self.find_depth(instructions)
    instructions.select { |command, _| command == "down" }.map(&:last).map(&:to_i).sum -
      instructions.select { |command, _| command == "up" }.map(&:last).map(&:to_i).sum
  end

  def self.find_horizontal_pos(instructions)
    instructions.select { |command, _| command == "forward" }.map(&:last).map(&:to_i).sum
  end

  def self.part_one
    find_depth(input) * find_horizontal_pos(input)
  end

  def self.part_two
  end
end
