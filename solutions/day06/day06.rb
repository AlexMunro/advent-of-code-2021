# frozen_string_literal: true

class Day06
  INPUT = File.expand_path("../../inputs/day06.txt", File.dirname(__FILE__))

  def self.input
    File.open(INPUT).readlines[0].strip.split(",").map(&:to_i)
  end

  def self.part_one
    new.children_after_days(input, 80)
  end

  def self.part_two
    new.children_after_days(input, 256)
  end

  def initialize
    @descendants = {}
  end

  def children_after_days(initial_fish, days)
    initial_fish.map { |fish| self_and_descendant_count(fish, days) }.sum
  end

  def self_and_descendant_count(fish_timer, days)
    @descendants[{ fish_timer: fish_timer, days: days }] ||= begin
      descendant_count = 0
      while fish_timer < days
        days -= fish_timer + 1
        fish_timer = 6
        descendant_count += self_and_descendant_count(8, days)
      end
      descendant_count + 1
    end
  end
end
