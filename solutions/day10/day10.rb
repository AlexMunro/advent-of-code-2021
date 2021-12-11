# frozen_string_literal: true

require_relative "./navigation_line"
require_relative "../../utils/input/lines"

class Day10
  extend Input::Lines

  def initialize(lines)
    @lines = lines.map { |line| NavigationLine.new(line) }
  end

  def self.part_one
    new(input).score_corrupt_lines
  end

  def self.part_two
    new(input).median_completion_score
  end

  def score_corrupt_lines
    @lines.sum(&:corruption_score)
  end

  def median_completion_score
    completion_scores = @lines.map(&:completion_score).reject(&:zero?).sort
    completion_scores[completion_scores.length / 2]
  end
end
