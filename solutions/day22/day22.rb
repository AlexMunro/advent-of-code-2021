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
    new(input).total_cubes
  end

  def initialize(instructions)
    @instructions = parse_instructions(instructions)
  end

  def cubes_near_origin
    turned_on_cubes = Set.new

    @instructions.each do |instruction|
      unless instruction.slice(:x_range, :y_range, :z_range).values
          .all? { |range| partially_overlaps?(range, -50..50) }
        next
      end

      (-50..50).each do |x|
        next unless instruction[:x_range].include? x

        (-50..50).each do |y|
          next unless instruction[:y_range].include? y

          (-50..50).each do |z|
            next unless instruction[:z_range].include? z

            instruction[:turn_on] ? turned_on_cubes << [x, y, z] : turned_on_cubes.delete([x, y, z])
          end
        end
      end
    end

    turned_on_cubes.length
  end

  def total_cubes
    # entangled_cuboids = find_entangled_instruction_cuboids

    # entangled_cuboids.map { |cuboid_pile| turned_on_cubes_in_pile(cuboid_pile) }.sum

    # instructions.each_with_index do |instruction, idx|
    #   #
    # end
  end

  private

  def parse_instructions(instructions)
    instructions.each_with_index.map do |instruction, index|
      captures = instruction.match(INSTRUCTION_REGEX).named_captures
      {
        index: index,
        turn_on: captures["mode"] == "on",
        x_range: captures["x1"].to_i..captures["x2"].to_i,
        y_range: captures["y1"].to_i..captures["y2"].to_i,
        z_range: captures["z1"].to_i..captures["z2"].to_i,
      }
    end
  end

  def find_entangled_instruction_cuboids
    entangled_cuboids = @instructions.map { |i| [i] }
    loop do
      any_piles_merged = false

      entangled_cuboids[1..].each_with_index do |cuboid_pile, index|
        entangled_cuboids[0...index].each_with_index do |other_cuboid_pile, inner_index|
          next unless cuboid_piles_overlap?(cuboid_pile, other_cuboid_pile)

          entangled_cuboids[inner_index].concat(cuboid_pile)
          entangled_cuboids.delete_at(index)
          any_piles_merged = true
          break
        end

        break if any_piles_merged
      end

      break unless any_piles_merged
    end
    entangled_cuboids
  end

  def turned_on_cubes_in_pile(cuboid_pile)
    cuboid_pile.sort! { |cuboid| cuboid[:index] }

    cuboid_pile.shift until cuboid_pile.empty? || cuboid_pile[0][:turn_on]

    case cuboid_pile.length
    when 0
      0
    when 1
      size(cuboid_pile[0])
    else
      turned_on_cubes_in_entangled_pile(cuboid_pile)
    end
  end

  def turned_on_cubes_in_entangled_pile(cuboid_pile)
    turned_on_cuboids = [cuboid_pile.first]
    excess_turned_on_cuboids = []
    turned_off_cuboids = []
    excess_turned_off_cuboids = []

    cuboid_pile[1..].each do |next_cuboid|
      if next_cuboid[:turn_on]
        excess_turned_on_cuboids.concat(turned_on_cuboids
          .select { |c| cuboids_overlap?(c, next_cuboid) }
          .map { |c| intersecting_cuboid(c, next_cuboid) })
        turned_on_cuboids << next_cuboid
      else
        relevant_turned_off_cuboids = turned_on_cuboids
          .select { |c| cuboids_overlap?(c, next_cuboid) }
          .map { |c| intersecting_cuboid(c, next_cuboid) }

        excess_turned_off_cuboids.concat(relevant_turned_off_cuboids
          .select { |c| cuboids_overlap?(c, next_cuboid) }
          .map { |c| intersecting_cuboid(c, next_cuboid) })
        turned_off_cuboids << next_cuboid
      end
    end

    (turned_on_cuboids + excess_turned_off_cuboids).sum { |c| size(c) } -
      (excess_turned_on_cuboids + turned_off_cuboids).sum { |c| size(c) }
  end

  def partially_overlaps?(first_range, second_range)
    first_range.begin <= second_range.end && first_range.end >= second_range.begin
  end

  def cuboids_overlap?(first_cuboid, second_cuboid)
    partially_overlaps?(first_cuboid[:x_range], second_cuboid[:x_range]) &&
      partially_overlaps?(first_cuboid[:y_range], second_cuboid[:y_range]) &&
      partially_overlaps?(first_cuboid[:z_range], second_cuboid[:z_range])
  end

  def cuboid_entirely_within?(inner_cuboid, outer_cuboid)
    outer_cuboid[:x_range].cover?(inner_cuboid[:x_range]) &&
      outer_cuboid[:y_range].cover?(inner_cuboid[:y_range]) &&
      outer_cuboid[:z_range].cover?(inner_cuboid[:z_range])
  end

  def cuboid_piles_overlap?(first_cuboid_pile, second_cuboid_pile)
    first_cuboid_pile.all? do |cuboid|
      second_cuboid_pile.any? { |other_cuboid| cuboids_overlap?(cuboid, other_cuboid) }
    end
  end

  def intersecting_cuboid(first_cuboid, second_cuboid)
    {
      x_range: [first_cuboid[:x_range].first, second_cuboid[:x_range].first].min..
        [first_cuboid[:x_range].last, second_cuboid[:x_range].last].min,
      y_range: [first_cuboid[:y_range].first, second_cuboid[:y_range].first].min..
        [first_cuboid[:y_range].last, second_cuboid[:y_range].last].min,
      z_range: [first_cuboid[:z_range].first, second_cuboid[:z_range].first].min..
        [first_cuboid[:z_range].last, second_cuboid[:z_range].last].min,
    }
  end

  def size(cuboid)
    return 0 unless cuboid.slice(:x_range, :y_range, :z_range).values.map(&:size).all?(&:positive?)

    cuboid[:x_range].size * cuboid[:y_range].size * cuboid[:z_range].size
  end
end
