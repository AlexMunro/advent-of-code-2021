# frozen_string_literal: true

require_relative "../../utils/input/lines"

class Day20
  extend Input::Lines

  attr_reader :lit_pixels

  def self.part_one
    new(input[0], input[2..]).lit_pixels_after_double_enhancement
  end

  def self.part_two
  end

  def initialize(algorithm, image)
    @algorithm = algorithm
    @lit_pixels = parse_pixels(image)
    @neighbouring_points = {}
  end

  def lit_pixels_after_double_enhancement
    2.times { enhance }
    @lit_pixels.length
  end

  private

  def parse_pixels(image)
    image.each_with_index.flat_map do |line, y|
      line.chars.each_with_index.filter_map do |char, x|
        { x:, y: } if char == "#"
      end
    end
  end

  def enhance
    pixels_to_consider = @lit_pixels.flat_map { |p| neighbouring_points(p) }.uniq

    @lit_pixels = pixels_to_consider.filter { |p| lit_after_enchancement?(p) }
  end

  def neighbouring_points(point)
    @neighbouring_points[point] ||= (point[:y] - 1..point[:y] + 1).flat_map do |y|
      (point[:x] - 1..point[:x] + 1).map do |x|
        { x:, y: }
      end
    end
  end

  def lit_after_enchancement?(point)
    lookup_position = neighbouring_points(point).map do |p|
      @lit_pixels.include?(p) ? "1" : "0"
    end.join.to_i(2)

    @algorithm[lookup_position] == "#"
  end
end
