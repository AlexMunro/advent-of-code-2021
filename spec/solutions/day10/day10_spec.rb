# frozen_string_literal: true

require "./solutions/day10/day10"

RSpec.describe Day10 do
  let(:day10) do
    described_class.new(
      [
        "[({(<(())[]>[[{[]{<()<>>",
        "[(()[<>])]({[<{<<[]>>(",
        "{([(<{}[<>[]}>{[]{[(<()>",
        "(((({<>}<{<{<>}{[]{[]{}",
        "[[<[([]))<([[{}[[()]]]",
        "[{[{({}]{}}([{[{{{}}([]",
        "{<[[]]>}<{[{[{[]{()[[[]",
        "[<(<(<(<{}))><([]([]()",
        "<{([([[(<>()){}]>(<<{{",
        "<{([{{}}[<[[[<>{}]]]>[]]",
      ]
    )
  end

  describe "#score_corrupt_lines" do
    subject { day10.score_corrupt_lines }

    it { is_expected.to eq 26_397 }
  end

  describe "#median_completion_score" do
    subject { day10.median_completion_score }

    it { is_expected.to eq 288_957 }
  end
end
