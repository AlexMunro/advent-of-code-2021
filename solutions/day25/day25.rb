# frozen_string_literal: true

require_relative "../../utils/input/lines"

require "set"

class Day25
  extend Input::Lines

  def self.part_one
    new(input).steps_to_steady_state
  end

  def initialize(lines)
    @horizontal_herd = Set.new
    @vertical_herd = Set.new
    @height = lines.length
    @width = lines[0].length

    lines.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        case char
        when ">"
          @horizontal_herd << [x,y]
        when "v"
          @vertical_herd << [x,y]
        end
      end
    end
  end

  def steps_to_steady_state
    (1..).find { !advance_state }
  end

  private

  def advance_state
    changed = false

    occupied_spaces = @horizontal_herd.union(@vertical_herd)

    next_horizontal_herd = @horizontal_herd.map do |x, y|
      attempted_next_pos = [(x + 1) % @width, y]

      if occupied_spaces.include? attempted_next_pos
        [x, y]
      else
        changed = true
        attempted_next_pos
      end
    end.to_set

    occupied_spaces = next_horizontal_herd.union(@vertical_herd)

    next_vertical_herd = @vertical_herd.map do |x, y|
      attempted_next_pos = [x, (y + 1) % @height]

      if occupied_spaces.include? attempted_next_pos
        [x, y]
      else
        changed = true
        attempted_next_pos
      end
    end.to_set

    @horizontal_herd = next_horizontal_herd
    @vertical_herd = next_vertical_herd

    changed
  end
end
