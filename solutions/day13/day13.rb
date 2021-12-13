# frozen_string_literal: true

require_relative "../../utils/input/lines"
require "set"

class Day13
  extend Input::Lines

  FOLD_REGEX = /^fold along (?<dimension>\w)=(?<value>\d+)$/

  def self.part_one
    from_strings(input).dots_after_first_fold
  end

  def self.part_two
    from_strings(input).message_after_all_folds.join("\n")
  end

  def self.from_strings(lines)
    split_point = lines.index("")

    new(
      points: lines[...split_point]
        .map { |line| line.split(",").map(&:to_i) }
        .map { |x, y| { x:, y: } }
        .to_set,
      folds: lines[split_point + 1..]
        .map { |line| line.match(FOLD_REGEX).named_captures }
    )
  end

  def initialize(points:, folds:)
    @points = points
    @folds = folds
  end

  def dots_after_first_fold
    perform_fold(@folds.first)
    @points.length
  end

  def message_after_all_folds
    @folds.each { |fold| perform_fold(fold) }
    max_y = @points.map { |p| p[:y] }.max
    max_x = @points.map { |p| p[:x] }.max

    (0..max_y).map do |y|
      (0..max_x).map { |x| @points.include?({x: x, y: y}) ? "*" : " " }.join
    end
  end

  private

  def perform_fold(position)
    dimension = position["dimension"].to_sym
    value = position["value"].to_i

    folding_points = @points.filter { |point| point[dimension] > value }
    folded_points = folding_points.map do |point|
      new_value = point[dimension] - ((point[dimension] - value) * 2)
      point.merge({ dimension => new_value })
    end

    @points = @points - folding_points + folded_points
  end
end
