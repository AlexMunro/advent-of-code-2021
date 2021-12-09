# frozen_string_literal: true

class Day08
  require_relative "./display_entry"

  INPUT = File.expand_path("../../inputs/day08.txt", File.dirname(__FILE__))

  def self.input
    File.open(INPUT).readlines.map(&:strip)
  end

  def self.part_one
    new(input).sum_easy_output
  end

  def self.part_two
    new(input).sum_all_output
  end

  def initialize(entries)
    @entries = entries.map { |string_entry| DisplayEntry.from_string(string_entry) }
  end

  def sum_easy_output
    @entries.sum(&:unique_segment_number_digits)
  end

  def sum_all_output
    @entries.sum(&:sum_digits)
  end
end
