# frozen_string_literal: true

require "./solutions/day10/navigation_line"

RSpec.describe NavigationLine do
  let(:corrupt_lines) do
    [
      "{([(<{}[<>[]}>{[]{[(<()>",
      "[[<[([]))<([[{}[[()]]]",
      "[{[{({}]{}}([{[{{{}}([]",
      "[<(<(<(<{}))><([]([]()",
      "<{([([[(<>()){}]>(<<{{",
    ].map { |line| described_class.new(line) }
  end

  let(:incomplete_lines) do
    [
      "[({(<(())[]>[[{[]{<()<>>",
      "[(()[<>])]({[<{<<[]>>(",
      "(((({<>}<{<{<>}{[]{[]{}",
      "{<[[]]>}<{[{[{[]{()[[[]",
      "<{([{{}}[<[[[<>{}]]]>[]]",
    ].map { |line| described_class.new(line) }
  end

  describe "#corruption_score" do
    it "returns a score for corrupt lines" do
      expect(corrupt_lines[0].corruption_score).to eq described_class::SCORING["}"]
      expect(corrupt_lines[1].corruption_score).to eq described_class::SCORING[")"]
      expect(corrupt_lines[2].corruption_score).to eq described_class::SCORING["]"]
      expect(corrupt_lines[3].corruption_score).to eq described_class::SCORING[")"]
      expect(corrupt_lines[4].corruption_score).to eq described_class::SCORING[">"]
    end

    it "returns zero for incomplete lines" do
      expect(incomplete_lines.map(&:corruption_score)).to all be_zero
    end
  end

  describe "#completion_score" do
    it "returns a score for incomplete lines" do
      expect(incomplete_lines[0].completion_score).to eq 288_957
      expect(incomplete_lines[1].completion_score).to eq 5_566
      expect(incomplete_lines[2].completion_score).to eq 1_480_781
      expect(incomplete_lines[3].completion_score).to eq 995_444
      expect(incomplete_lines[4].completion_score).to eq 294
    end

    it "returns zero for corrupt lines" do
      expect(corrupt_lines.map(&:completion_score)).to all be_zero
    end
  end
end
