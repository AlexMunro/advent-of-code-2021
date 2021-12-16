# frozen_string_literal: true

require "./solutions/day15/day15"

RSpec.describe Day15 do
  let(:day15) do
    described_class.new(
      [
        [1, 1, 6, 3, 7, 5, 1, 7, 4, 2],
        [1, 3, 8, 1, 3, 7, 3, 6, 7, 2],
        [2, 1, 3, 6, 5, 1, 1, 3, 2, 8],
        [3, 6, 9, 4, 9, 3, 1, 5, 6, 9],
        [7, 4, 6, 3, 4, 1, 7, 1, 1, 1],
        [1, 3, 1, 9, 1, 2, 8, 1, 3, 7],
        [1, 3, 5, 9, 9, 1, 2, 4, 2, 1],
        [3, 1, 2, 5, 4, 2, 1, 6, 3, 9],
        [1, 2, 9, 3, 1, 3, 8, 5, 2, 1],
        [2, 3, 1, 1, 9, 4, 4, 5, 8, 1],
      ]
    )
  end

  describe "#shortest_path" do
    subject { day15.shortest_path }

    it { is_expected.to eq 40 }
  end

  describe "#shortest_path_through_larger_maze" do
    subject { day15.shortest_path_through_larger_maze }

    it { is_expected.to eq 315 }
  end
end
