# frozen_string_literal: true

class Line
  class LineFormatError < StandardError; end
  class InfiniteGradientError < StandardError; end

  attr_reader :x1, :y1, :x2, :y2

  def self.from_string(string)
    line_regex = /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/
    match = string.match(line_regex)
    raise LineFormatError, "Invalid line: #{string}" unless match

    new(*match.captures.map(&:to_i))
  end

  def initialize(x1, y1, x2, y2) # rubocop:disable Naming/MethodParameterName
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def horizontal?
    y1 == y2
  end

  def vertical?
    x1 == x2
  end

  # Only considers points where X and Y are integers
  def enumerate_points
    if horizontal?
      Range.new(*[x1, x2].sort).map { |x| [x, y1] }
    elsif vertical?
      Range.new(*[y1, y2].sort).map { |y| [x1, y] }
    else
      start, stop = [{ x: x1, y: y1 }, { x: x2, y: y2 }].sort_by { |point| point[:x] }

      if upward?
        (start[:x]..stop[:x]).map { |x| [x, start[:y] + x - start[:x]] }
      else
        (start[:x]..stop[:x]).map { |x| [x, start[:y] - (x - start[:x])] }
      end
    end
  end

  private

  def upward?
    ((y2 - y1) / (x2 - x1)).positive?
  end
end
