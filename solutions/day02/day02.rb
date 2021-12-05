# frozen_string_literal: true

class Day02
  INPUT = File.expand_path("../../inputs/day02.txt", File.dirname(__FILE__))

  def self.input
    @input ||= File.open(INPUT).readlines
      .map(&:strip)
      .map(&:split)
      .map { |command, amount| [command, amount.to_i] }
  end

  def self.part_one
    find_depth(input) * find_horizontal_pos(input)
  end

  def self.part_two
    get_depth_and_pos_with_aim(input).reduce(:*)
  end

  def self.find_depth(instructions)
    instructions.select { |command, _| command == "down" }.map(&:last).sum -
      instructions.select { |command, _| command == "up" }.map(&:last).sum
  end

  def self.find_horizontal_pos(instructions)
    instructions.select { |command, _| command == "forward" }.map(&:last).map(&:to_i).sum
  end

  def self.get_depth_and_pos_with_aim(instructions)
    depth = pos = aim = 0

    instructions.each do |command, amount|
      case command
      when "down"
        aim += amount
      when "up"
        aim -= amount
      when "forward"
        pos += amount
        depth += aim * amount
      end
    end

    [depth, pos]
  end
end
