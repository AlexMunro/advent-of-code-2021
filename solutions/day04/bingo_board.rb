# frozen_string_literal: true

require "set"

class BingoBoard
  def initialize(rows)
    @rows = rows
    @called_numbers = Set[]
  end

  def call(number)
    @called_numbers.add(number)
    @most_recent_number = number
  end

  def bingo?
    winning_row? || winning_column?
  end

  def score
    (@rows.flatten.to_set - @called_numbers).sum * @most_recent_number
  end

  private

  def winning_row?
    @rows.any? { |row| @called_numbers & row == row.to_set }
  end

  def winning_column?
    (0..@rows[0].length).any? do |column_idx|
      column = @rows.map { |row| row[column_idx] }
      @called_numbers & column == column.to_set
    end
  end

  def winning_downward_diagonal?
    (0...@rows.length).all? do |position|
      @called_numbers.include?(@rows[position][position])
    end
  end

  def winning_upward_diagonal?
    (0...@rows.length).all? do |position|
      @called_numbers.include?(@rows[position][@rows.length - 1 - position])
    end
  end
end
