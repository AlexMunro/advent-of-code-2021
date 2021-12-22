# frozen_string_literal: true

require_relative "../../utils/input/lines"

require "set"

class Day22
  extend Input::Lines

  INSTRUCTION_REGEX = %r{
    ^(?<mode>(on)|(off))\s # Mode
    x=(?<x1>-?\d+)\.\.(?<x2>-?\d+), # x range
    y=(?<y1>-?\d+)\.\.(?<y2>-?\d+), # y range
    z=(?<z1>-?\d+)\.\.(?<z2>-?\d+)$ # z range
  }x

  def self.part_one
    new(input).cubes_near_origin
  end

  def self.part_two
  end

  def initialize(instructions)
    @instructions = instructions
  end

  def cubes_near_origin
    turned_on_cubes = Set.new

    @instructions.each do |instruction|
      captures = instruction.match(INSTRUCTION_REGEX).named_captures

      x_range = captures["x1"].to_i..captures["x2"].to_i
      y_range = captures["y1"].to_i..captures["y2"].to_i
      z_range = captures["z1"].to_i..captures["z2"].to_i

      next unless [x_range, y_range, z_range].all? { |range| partially_overlaps?(range, -50..50) }

      turn_on = captures["mode"] == "on"

      (-50..50).each do |x|
        next unless x_range.include? x

        (-50..50).each do |y|
          next unless y_range.include? y

          (-50..50).each do |z|
            next unless z_range.include? z

            turn_on ? turned_on_cubes << [x, y, z] : turned_on_cubes.delete([x, y, z])
          end
        end
      end
    end

    turned_on_cubes.length
  end

  private

  def partially_overlaps?(first_range, second_range)
    first_range.begin <= second_range.end && first_range.end >= second_range.begin
  end
end
