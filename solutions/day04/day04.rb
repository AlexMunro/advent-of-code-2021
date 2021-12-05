# frozen_string_literal: true

class Day04
  require_relative "./bingo_board"

  INPUT = "../../inputs/day04.txt"

  def self.input
    # Would have been able to use Array.split in Rails :(
    numbers = File.readlines(INPUT)[0].strip.split(",").map(&:to_i)

    boards = []

    File.readlines(INPUT)[1..].each do |line|
      if line == "\n"
        boards << []
      else
        boards.last << line.strip.split.map(&:to_i)
      end
    end

    { numbers:, boards: }
  end

  def initialize(numbers:, boards:)
    @numbers = numbers
    @boards = boards.map { |board| BingoBoard.new(board) }
  end

  def winning_board_score
    @numbers.each do |n|
      @boards.each { |board| board.call(n) }

      if (winner = @boards.find(&:bingo?))
        return winner.score
      end
    end
  end

  def losing_board_score
    @numbers.each do |n|
      @boards.each { |board| board.call(n) }
      return @boards[0].score if @boards.length == 1 && @boards[0].bingo?

      @boards.reject!(&:bingo?)
    end
  end

  def self.part_one
    new(**input).winning_board_score
  end

  def self.part_two
    new(**input).losing_board_score
  end
end
