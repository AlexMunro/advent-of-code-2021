# frozen_string_literal: true

require_relative "../../utils/input/lines"

class Day14
  extend Input::Lines

  def self.part_one
    from_strings(input).difference_between_most_and_least_common_element(10)
  end

  def self.part_two
    from_strings(input).difference_between_most_and_least_common_element(40)
  end

  def self.from_strings(lines)
    new(
      polymer: lines[0].chars,
      rules: lines[2..]
        .map { |line| line.split(" -> ") }
        .to_h
    )
  end

  def initialize(polymer:, rules:)
    @polymer = polymer
    @rules = rules
    @longest_rule = 2
  end

  def difference_between_most_and_least_common_element(rule_applications)
    rule_applications.times { apply_rules }
    element_counts = @polymer.tally.values
    element_counts.max - element_counts.min
  end

  def apply_rules
    insertions = @polymer.each_cons(2).each_with_index.filter_map do |pair, index|
      [@rules[pair.join], index] if @rules[pair.join]
    end

    insertions.reverse.each do |substitution, index|
      @polymer.insert(index + 1, substitution)
    end

    @polymer
  end
end
