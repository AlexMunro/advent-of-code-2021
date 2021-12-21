# frozen_string_literal: true

require "./solutions/day18/snail_number"

RSpec.describe SnailNumber do
  describe "#sum" do
    it "sums the snail numbers, reducing along the way" do
      expect(described_class.new([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]],
                                  [1, 1]]).tap(&:sum).pairs).to eq [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]

      expect(described_class.new([[1, 1], [2, 2], [3, 3],
                                  [4, 4]]).tap(&:sum).pairs).to eq [[[[1, 1], [2, 2]], [3, 3]], [4, 4]]

      expect(described_class.new([[1, 1], [2, 2], [3, 3], [4, 4],
                                  [5, 5]]).tap(&:sum).pairs).to eq [[[[3, 0], [5, 3]], [4, 4]], [5, 5]]

      expect(described_class.new([[1, 1], [2, 2], [3, 3], [4, 4], [5, 5],
                                  [6, 6]]).tap(&:sum).pairs).to eq [[[[5, 0], [7, 4]], [5, 5]], [6, 6]]

      expect(described_class.new([[[[0, [4, 5]], [0, 0]], [[[4, 5], [2, 6]], [9, 5]]],
                                  [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]],
                                  [[2, [[0, 8], [3, 4]]], [[[6, 7], 1], [7, [1, 6]]]],
                                  [[[[2, 4], 7], [6, [0, 5]]], [[[6, 8], [2, 8]], [[2, 1], [4, 5]]]],
                                  [7, [5, [[3, 8], [1, 4]]]],
                                  [[2, [2, 2]], [8, [8, 1]]],
                                  [2, 9],
                                  [1, [[[9, 3], 9], [[9, 0], [0, 7]]]],
                                  [[[5, [7, 4]], 7], 1],
                                  [[[[4, 2], 2], 6],
                                   [8,
                                    7]]]).tap(&:sum).pairs).to eq [[[[8, 7], [7, 7]], [[8, 6], [7, 7]]],
                                                                   [[[0, 7], [6, 6]], [8, 7]]]
    end
  end

  describe "#reduce" do
    let(:example_input) do
      [[[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]]]
    end

    subject { described_class.new(example_input).tap(&:reduce).pairs }

    it "reduces the numbers until they can no longer be reduced" do
      is_expected.to eq [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]
    end
  end

  describe "#magnitude" do
    it "recursively calculates the number's magnitude" do
      expect(described_class.new([[9, 1]]).magnitude).to eq 29
      expect(described_class.new([[[9, 1], [1, 9]]]).magnitude).to eq 129
      expect(described_class.new([[[1, 2], [[3, 4], 5]]]).magnitude).to eq 143
      expect(described_class.new([[[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]]).magnitude).to eq 1384
      expect(described_class.new([[[[[1, 1], [2, 2]], [3, 3]], [4, 4]]]).magnitude).to eq 445
      expect(described_class.new([[[[[3, 0], [5, 3]], [4, 4]], [5, 5]]]).magnitude).to eq 791
      expect(described_class.new([[[[[5, 0], [7, 4]], [5, 5]], [6, 6]]]).magnitude).to eq 1137
      expect(described_class.new([[[[[8, 7], [7, 7]], [[8, 6], [7, 7]]],
                                   [[[0, 7], [6, 6]], [8, 7]]]]).magnitude).to eq 3488
    end
  end
end
