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
      polymer: lines[0],
      rules: lines[2..]
        .map { |line| line.split(" -> ") }
        .to_h
    )
  end

  def initialize(polymer:, rules:)
    @polymer = polymer.chars.each_cons(2).map(&:join).tally
    @rules = rules
    @longest_rule = 2
  end

  def difference_between_most_and_least_common_element(rule_applications)
    rule_applications.times { apply_rules }
    counts = element_counts.values
    ((counts.max - counts.min) / 2.0).ceil # Remember that (almost) every entry is counted twice
  end

  def apply_rules
    per_rule_tallies = @polymer.map do |pair, amount|
      inserted = @rules[pair]
      {
        "#{pair[0]}#{inserted}" => amount,
        "#{inserted}#{pair[1]}" => amount
      }
    end

    @polymer = merge_tallies(per_rule_tallies)
  end

  private

  def element_counts
    @polymer.each_with_object({}) do |pair_entry, counts|
      first_char = pair_entry.first[0]
      second_char = pair_entry.first[1]
      amount = pair_entry.last

      counts[first_char] ||= 0
      counts[second_char] ||= 0
      counts[first_char] += amount
      counts[second_char] += amount

      counts
    end
  end

  def merge_tallies(tallies)
    tallies.each_with_object({}) do |next_tally, combined_tally|
      next_tally.each do |pair, amount|
        combined_tally[pair] ||= 0
        combined_tally[pair] += amount
      end
    end
  end
end
