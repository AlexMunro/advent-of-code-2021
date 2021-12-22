# frozen_string_literal: true

require_relative "../../utils/input/lines"

class Day21
  extend Input::Lines

  def self.part_one
    new(input[0].chars.last.to_i, input[1].chars.last.to_i).practice_game
  end

  def self.part_two
  end

  def initialize(first_player_start, second_player_start)
    @first_player_pos = first_player_start
    @second_player_pos = second_player_start
    @dice_pos = 1
    @dice_roll_count = 0
  end

  def practice_game
    first_player_score = second_player_score = 0

    loop do
      3.times do
        @first_player_pos += roll_dice
        @first_player_pos %= 10
      end

      if @first_player_pos.zero?
        first_player_score += 10
      else
        first_player_score += @first_player_pos
      end

      if first_player_score >= 1000
        return second_player_score * @dice_roll_count
      end

      3.times do
        @second_player_pos += roll_dice
        @second_player_pos %= 10
      end

      if @second_player_pos.zero?
        second_player_score += 10
      else
        second_player_score += @second_player_pos
      end

      if second_player_score >= 1000
        return first_player_score * @dice_roll_count
      end
    end
  end

  def roll_dice
    @dice_pos = (@dice_pos % 100) + 1
    @dice_roll_count += 1

    if @dice_pos == 1
      100
    else
      @dice_pos - 1
    end
  end
end
